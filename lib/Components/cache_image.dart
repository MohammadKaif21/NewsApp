import 'package:flutter_application/Components/rubik_text_styles.dart';
import 'package:flutter_application/Utilities/common_enums.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final BorderRadius? radius;
  final Border? border;
  const CacheImage({super.key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.radius, this.border});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: image.isNotEmpty,
      replacement: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(borderRadius: radius ?? BorderRadius.zero, color: const Color(0xFFEEEEEE)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red, size: 48),
            Label(text: "Error 404!\nImage Not Found", style: TextStyleType.medium, align: TextAlign.center)
          ],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).cardColor, border: border, borderRadius: radius),
        child: ClipRRect(
          borderRadius: radius ?? BorderRadius.zero,
          child: CachedNetworkImage(
            fit: fit,
            width: width,
            height: height,
            imageUrl: image,
            placeholder: (context, url) => Container(width: width, height: height, decoration: const BoxDecoration(color: Color(0xFFADADAD))),
            errorWidget: (context, url, error) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(borderRadius: radius ?? BorderRadius.zero, color: const Color(0xFFEEEEEE)),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 48),
                  Label(text: "Error 404!\nImage Not Found", style: TextStyleType.medium, align: TextAlign.center)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
