import 'package:flutter/material.dart';

import '../../data/remote/models/ingredient_model.dart';

List<Ingredient> drawBoxesOnCanvasAndReturnDetectedIngredient(
    {required Canvas canvas,
    required Size screen,
    required List<Map<String, dynamic>> modelResults,
    required int imageWidth,
    required int imageHeight}) {
  if (modelResults.isEmpty) return [];

  double factorX = screen.width / imageWidth;
  double imgRatio = imageWidth / imageHeight;
  double newWidth = imageWidth * factorX;
  double newHeight = newWidth / imgRatio;
  double factorY = newHeight / imageHeight;

  double pady = (screen.height - newHeight) / 2;

  Color colorPick = const Color.fromARGB(255, 50, 233, 30);

  final Paint boxPaint = Paint()
    ..color = Colors.pink
    ..style = PaintingStyle.stroke
    ..strokeWidth = imageWidth * 0.006;

  final Paint textBackgroundPaint = Paint()..color = colorPick;
  double fontSizePercentage = imageHeight * 0.025;

  TextStyle textStyle = TextStyle(
    color: Colors.white,
    fontSize: fontSizePercentage,
  );

  List<Ingredient> detectedObjects = [];
  for (Map<String, dynamic> result in modelResults) {
    double left = result["box"][0] * factorX;
    double top = result["box"][1] * factorY + pady;
    double width = (result["box"][2] - result["box"][0]) * factorX;
    double height = (result["box"][3] - result["box"][1]) * factorY;

    Rect rect = Rect.fromLTWH(left, top, width, height);
    canvas.drawRect(rect, boxPaint);

    /// Add detected object to list and check if the item is exist then increase the quantity
    if (detectedObjects.isEmpty){
      detectedObjects.add(Ingredient(
        name: "${result['tag']}",
        quantity: 1,
      ));
    } else {
      bool isExist = false;
      for (int i = 0; i < detectedObjects.length; i++) {
        if (detectedObjects[i].name == result['tag']) {
          detectedObjects[i].quantity = detectedObjects[i].quantity! + 1;
          isExist = true;
          break;
        }
      }
      if (!isExist) {
        detectedObjects.add(Ingredient(
          name: "${result['tag']}",
          quantity: 1,
        ));
      }
    }

    TextSpan textSpan = TextSpan(
      text: "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(0)}%",
      style: textStyle,
    );
    TextPainter textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    Offset textOffset = Offset(left, top - textPainter.height - 2.0);

    Rect textBackgroundRect = Rect.fromPoints(
      Offset(textOffset.dx, textOffset.dy),
      Offset(textOffset.dx + textPainter.width,
          textOffset.dy + textPainter.height),
    );
    canvas.drawRect(textBackgroundRect, textBackgroundPaint);
    textPainter.paint(canvas, textOffset);
  }

  return detectedObjects;
}
