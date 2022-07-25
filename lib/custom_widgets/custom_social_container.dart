import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSocialContainer extends StatelessWidget {
  CustomSocialContainer({
    Key? key,
    this.onTap,
    this.containerColor,
    required this.title,
  }) : super(key: key);
  final Color? containerColor;
  final Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Container(
          width: double.infinity,
          color: containerColor,
          height: 50.h,
          child: Center(
              child: Text(
            title,
            style: TextStyle(fontSize: 18.sp, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
