import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_text.dart';

class CustomSettingItem extends StatelessWidget {
  CustomSettingItem({
    Key? key,
    this.title,
    this.image,
    this.onPress,
    this.icon = Icons.arrow_forward_ios,
  }) : super(key: key);

  final String? image;
  final String? title;
  final Function()? onPress;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        color: null,
        height: 55.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    image!,
                    color: blueColor,
                  ),
                  SizedBox(
                    width: 17.w,
                  ),
                  CustomText(
                    text: title!,
                    color: blueColor,
                    fontSize: 17.sp,
                  )
                ],
              ),
              Icon(
                icon,
                size: 20,
                color: blueColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
