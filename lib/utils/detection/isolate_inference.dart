import 'dart:isolate';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as image_lib;
import 'package:tflite_flutter/tflite_flutter.dart';

class IsolateInference {
  static const String _debugName = "TFLITE_INFERENCE";
  final ReceivePort _receivePort = ReceivePort();
  late Isolate _isolate;
  late SendPort _sendPort;

  SendPort get sendPort => _sendPort;

  Future<void> start() async {
    _isolate = await Isolate.spawn<SendPort>(entryPoint, _receivePort.sendPort,
        debugName: _debugName);
    _sendPort = await _receivePort.first;
  }

  Future<void> close() async {
    _isolate.kill();
    _receivePort.close();
  }

  static void entryPoint(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final InferenceModel isolateModel in port) {
      image_lib.Image? image;
      image = isolateModel.image;
      int inModelWidth = 640;
      int inModelHeight = 640;
      int numClasses = 6;

      final imgResized = image_lib.copyResize(image!,
          width: inModelWidth, height: inModelHeight);
      final imgNormalized = List.generate(
        inModelHeight,
        (y) => List.generate(
          inModelWidth,
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
      Interpreter interpreter =
          Interpreter.fromAddress(isolateModel.interpreterAddress);

      interpreter.run([imgNormalized], output);
      debugPrint(
          'Prediction time: ${DateTime.now().millisecondsSinceEpoch - predictionTimeStart} ms');

      isolateModel.responsePort.send(output[0]);
    }
  }

  static List<double> xywh2xyxy(List<double> bbox) {
    double halfWidth = bbox[2] / 2;
    double halfHeight = bbox[3] / 2;
    return [
      bbox[0] - halfWidth,
      bbox[1] - halfHeight,
      bbox[0] + halfWidth,
      bbox[1] + halfHeight,
    ];
  }

  /// Computes the intersection over union between two bounding boxes encoded with
  /// the xyxy format.
  static double computeIou(List<double> bbox1, List<double> bbox2) {
    assert(bbox1[0] < bbox1[2]);
    assert(bbox1[1] < bbox1[3]);
    assert(bbox2[0] < bbox2[2]);
    assert(bbox2[1] < bbox2[3]);

    // Determine the coordinate of the intersection rectangle
    double xLeft = max(bbox1[0], bbox2[0]);
    double yTop = max(bbox1[1], bbox2[1]);
    double xRight = min(bbox1[2], bbox2[2]);
    double yBottom = min(bbox1[3], bbox2[3]);

    if (xRight < xLeft || yBottom < yTop) {
      return 0;
    }
    double intersectionArea = (xRight - xLeft) * (yBottom - yTop);
    double bbox1Area = (bbox1[2] - bbox1[0]) * (bbox1[3] - bbox1[1]);
    double bbox2Area = (bbox2[2] - bbox2[0]) * (bbox2[3] - bbox2[1]);

    double iou = intersectionArea / (bbox1Area + bbox2Area - intersectionArea);
    assert(iou >= 0 && iou <= 1);
    return iou;
  }
}

class InferenceModel {
  image_lib.Image? image;
  int interpreterAddress;
  late SendPort responsePort;

  InferenceModel(this.image, this.interpreterAddress);
}
