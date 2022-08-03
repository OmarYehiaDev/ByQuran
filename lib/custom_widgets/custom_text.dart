import 'package:flutter/material.dart';
import 'package:welivewithquran/zTools/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight? fontWeight;
  final Alignment? alignment;
  final int? maxLines;

  const CustomText(
      {this.text = '',
      this.maxLines,
      this.fontSize = 18,
      this.color = mainColor,
      this.fontWeight,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
