import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart';

import 'isolate_inference.dart';
import 'nms.dart';

class YoloModel {
  final String modelPath;
  final int inWidth;
  final int inHeight;
  final int numClasses;
  Interpreter? _interpreter;
  late final IsolateInference isolateInference;

  YoloModel(
    this.modelPath,
    this.inWidth,
    this.inHeight,
    this.numClasses,
  );

  Future<void> init() async {
    _interpreter = await Interpreter.fromAsset(modelPath);
    isolateInference = IsolateInference();
    await isolateInference.start();
  }

  List<List<double>> infer(Image image) {
    assert(_interpreter != null, 'The model must be initialized');
    final imgResized = copyResize(image, width: inWidth, height: inHeight);
    final imgNormalized = List.generate(
      inHeight,
      (y) => List.generate(
        inWidth,
        (x) {
          final pixel = imgResized.getPixel(x, y);
          return [pixel.rNormalized, pixel.gNormalized, pixel.bNormalized];
        },
      ),
    );

    // output shape:
    // 1 : batch size
    // 4 + 6: left, top, right, bottom and probabilities for each class
    // 8400: num predictions
    final output = [
      List<List<double>>.filled(4 + numClasses, List<double>.filled(8400, 0))
    ];
    int predictionTimeStart = DateTime.now().millisecondsSinceEpoch;
    _interpreter!.run([imgNormalized], output);
    debugPrint(
        'Prediction time: ${DateTime.now().millisecondsSinceEpoch - predictionTimeStart} ms');
    return output[0];
  }

  Future<List<List<double>>> _inference(InferenceModel inferenceModel) async {
    ReceivePort responsePort = ReceivePort();
    isolateInference.sendPort
        .send(inferenceModel..responsePort = responsePort.sendPort);
    // get inference result.
    var results = await responsePort.first;
    return results;
  }

  // inference still image
  Future<List<List<double>>> inferenceImage(Image image) async {
    var isolateModel = InferenceModel(image, _interpreter?.address ?? 0);
    return _inference(isolateModel);
  }

  Future<(List<int>, List<List<double>>, List<double>)> postprocess(
    List<List<double>> unfilteredBboxes,
    int imageWidth,
    int imageHeight, {
    double confidenceThreshold = 0.7,
    double iouThreshold = 0.1,
  }) async {
    List<int> classes;
    List<List<double>> bboxes;
    List<double> scores;
    int nmsTimeStart = DateTime.now().millisecondsSinceEpoch;
    (classes, bboxes, scores) = nms(
      unfilteredBboxes,
      confidenceThreshold: confidenceThreshold,
      iouThreshold: iouThreshold,
    );
    debugPrint(
        'NMS time: ${DateTime.now().millisecondsSinceEpoch - nmsTimeStart} ms');
    for (var bbox in bboxes) {
      bbox[0] *= imageWidth;
      bbox[1] *= imageHeight;
      bbox[2] *= imageWidth;
      bbox[3] *= imageHeight;
    }
    return (classes, bboxes, scores);
  }

  // (List<int>, List<List<double>>, List<double>) inferAndPostprocess(
  //   Image image, {
  //   double confidenceThreshold = 0.7,
  //   double iouThreshold = 0.1,
  // }) =>
  //     postprocess(
  //       infer(image),
  //       image.width,
  //       image.height,
  //       confidenceThreshold: confidenceThreshold,
  //       iouThreshold: iouThreshold,
  //     );
}
