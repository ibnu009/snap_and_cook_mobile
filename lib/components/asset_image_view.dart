import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/colors.dart';
import '../styles/values.dart';

class AssetImageView extends StatelessWidget {
  final String fileName;
  final IconData? materialIcon;
  final double? height;
  final double? width;
  final Color? color;
  final double? scale;
  final BoxFit? fit;
  final GestureTapCallback? onTap;

  const AssetImageView(
      {Key? key,
      required this.fileName,
      this.materialIcon,
      this.height = 24,
      this.width = 24,
      this.color,
      this.scale,
      this.fit,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _getView(),
    );
  }

  Widget _getView() {
    String mimType = fileName.split(".").last;
    String path = fileName;

    if (mimType.isEmpty) {
      if (materialIcon != null) {
        return Icon(
          materialIcon,
          size: width ?? 12,
          color: color,
        );
      }
      return Icon(
        Icons.image_not_supported_outlined,
        size: width,
        color: color,
      );
    }

    switch (mimType) {
      case "svg":
        return SvgPicture.asset(
          path,
          height: height,
          width: width,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
      case "png":
        return Image.asset(
          path,
          height: height,
          width: width,
          color: color,
          scale: scale,
          fit: fit,
        );
      case "jpg":
        return Image.asset(
          path,
          height: height,
          width: width,
          color: color,
          scale: scale,
          fit: fit,
        );
      case "jpeg":
        return Image.asset(
          path,
          height: height,
          width: width,
          color: color,
          scale: scale,
          fit: fit,
        );
      default:
        return Icon(
          Icons.image_not_supported_outlined,
          size: width,
          color: color ?? AppColors.heroBlack,
        );
    }
  }
}
