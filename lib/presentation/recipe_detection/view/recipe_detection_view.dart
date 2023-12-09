import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/appbar/basic_appbar.dart';
import '../../base/base_view.dart';
import '../view_model/recipe_detection_view_model.dart';

class RecipeDetectionView extends BaseView<RecipeDetectionViewModel> {
  const RecipeDetectionView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return BasicAppBar(appBarTitleText: "Detection", centerTitle: true);
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: _detection(context)),
        TextButton(
          onPressed: controller.pickImage,
          child: const Text("ambil gmbr serah"),
        )
      ],
    );
  }

  Widget _detection(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Obx(() {
          if (controller.imageBytes.value != null) {
            return Image.memory(controller.imageBytes.value!, fit: BoxFit.contain,);
          } else {
            return const SizedBox();
          }
        }),
        // ...displayBoxesAroundRecognizedObjects(MediaQuery.of(context).size),
      ],
    );
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (controller.modelResults.isEmpty) return [];

    double factorX = screen.width / (controller.imageWidth.value);
    double imgRatio =
        controller.imageWidth.value / controller.imageHeight.value;
    double newWidth = controller.imageWidth.value * factorX;
    double newHeight = newWidth / imgRatio;
    double factorY = newHeight / (controller.imageHeight.value);

    double pady = (screen.height - newHeight) / 2;

    Color colorPick = const Color.fromARGB(255, 50, 233, 30);
    return controller.modelResults.map((result) {
      return Positioned(
        left: result["box"][0] * factorX,
        top: result["box"][1] * factorY + pady,
        width: (result["box"][2] - result["box"][0]) * factorX,
        height: (result["box"][3] - result["box"][1]) * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.pink, width: 2.0),
          ),
          child: Text(
            "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      );
    }).toList();
  }
}
