import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../resource/app_colors.dart';
import '../resource/app_constants.dart';

class CachedImage extends StatelessWidget {

  final String? url;

  const CachedImage({
    Key? key,
    @required this.url,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.radiusBig),
      child: CachedNetworkImage(
        height: AppConstants.imageHeight,
        width: AppConstants.imageWidth,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withAlpha(AppConstants.alphaMedium),
                spreadRadius: AppConstants.dimensionSmall,
                blurRadius: AppConstants.dimensionMedium,
                offset: const Offset(AppConstants.dimensionZero, AppConstants.dimensionSmall), // changes position of shadow
              ),
            ],
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.colorBurn),
            ),
          ),
        ),
        imageUrl: url!,
        errorWidget: (context, url, error) =>
            Image.asset(AppConstants.emptyImage, fit: BoxFit.cover,),
      ),
    );
  }
}