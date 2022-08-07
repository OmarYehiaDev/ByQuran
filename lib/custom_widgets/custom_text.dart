import 'package:flutter/material.dart';
import 'package:welivewithquran/zTools/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight? fontWeight;
  final Alignment? alignment;
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
      alignment: alignment,
      child: Text(
        text,
        maxLines: maxLines,
        textDirection: textDirection,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
