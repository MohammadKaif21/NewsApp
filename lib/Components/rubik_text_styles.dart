import 'package:flutter_application/Utilities/global_constants.dart';
import 'package:flutter_application/Utilities/common_enums.dart';
import 'package:flutter/material.dart';

final rubikLight = TextStyle(fontFamily: GlobalConstants.rubik, fontWeight: FontWeight.w300);
final rubikRegular = TextStyle(fontFamily: GlobalConstants.rubik, fontWeight: FontWeight.w400);
final rubikMedium = TextStyle(fontFamily: GlobalConstants.rubik, fontWeight: FontWeight.w500);
final rubikSemiBold = TextStyle(fontFamily: GlobalConstants.rubik, fontWeight: FontWeight.w600);

class Label extends StatelessWidget {
  final String text;
  final int? maxLines;
  final double? fontSize;
  final Color? textColor;
  final TextAlign? align;
  final TextStyleType style;
  const Label({super.key, required this.text, required this.style, this.maxLines, this.fontSize, this.textColor, this.align});

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle();
    switch (style) {
      case TextStyleType.light:
        textStyle = rubikLight;
        break;
      case TextStyleType.regular:
        textStyle = rubikRegular;
        break;
      case TextStyleType.medium:
        textStyle = rubikMedium;
        break;
      case TextStyleType.semibold:
        textStyle = rubikSemiBold;
        break;
    }
    return Text(
      text,
      textAlign: align,
      // maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: textStyle.copyWith(color: textColor, fontSize: fontSize),
    );
  }
}
