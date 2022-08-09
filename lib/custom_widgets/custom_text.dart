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
    return Container(
      child: Text(
        text,
        maxLines: maxLines,
        textDirection: textDirection,
        textAlign: alignment,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
