import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../styles/images.dart';
import '../asset_image_view.dart';
import '../skeleton/shimmering_box_skeleton.dart';

class BasicNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height, width;
  final ImageWidgetBuilder? imageBuilder;
  final BoxFit? boxFit;
  final Widget? placeHolder;

  const BasicNetworkImage({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.imageBuilder,
    this.boxFit,
    this.placeHolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      imageBuilder: imageBuilder,
      fit: boxFit ?? BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          _imageShimmeringLoading(),
      errorWidget: (context, url, error) => CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        imageBuilder: imageBuilder,
        fit: boxFit ?? BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            _imageShimmeringLoading(),
        errorWidget: (context, url, error) => CachedNetworkImage(
          imageUrl: imageUrl,
          height: height,
          width: width,
          imageBuilder: imageBuilder,
          fit: boxFit ?? BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              _imageShimmeringLoading(),
          errorWidget: (context, url, error) => Image(
              height: height,
              width: width,
              image: Image.network(imageUrl).image,
              errorBuilder: (context, exception, stackTrace) =>
                  placeHolder ?? _imageErrorWidget()),
        ),
      ),
    );
  }

  Widget _imageShimmeringLoading() => const ShimmeringBoxSkeleton();

  Widget _imageErrorWidget() => const Center(
        child: SizedBox(
          height: 80,
          width: 80,
          child: AssetImageView(
            fileName: AppImages.logoFull,
          ),
        ),
      );
}
