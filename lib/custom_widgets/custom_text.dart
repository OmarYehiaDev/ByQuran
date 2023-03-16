import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:welivewithquran/zTools/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight? fontWeight;
  final TextAlign? alignment;
  final int? maxLines;
  final TextDirection? textDirection;

  const CustomText(
      {this.text = '',
      this.maxLines,
      this.fontSize = 18,
      this.color = mainColor,
      this.fontWeight,
      this.textDirection = TextDirection.rtl,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        child: Center(
          child: AutoSizeText(
            text,
            maxLines: maxLines,
            textDirection: textDirection,
            softWrap: true,
            maxFontSize: 35,
            minFontSize: 12,
            wrapWords: true,
            textAlign: alignment,
            style: TextStyle(
              fontSize: fontSize,
              color: color,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
