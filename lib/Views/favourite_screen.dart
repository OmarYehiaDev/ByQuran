import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:welivewithquran/zTools/colors.dart';
import 'package:welivewithquran/custom_widgets/custom_text.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  final List images = [
    'assets/images/sura_image3.png',
    'assets/images/sura_image2.png',
    'assets/images/sura_image2.png',
    'assets/images/sura_image3.png',
    'assets/images/sura_image2.png',
    'assets/images/sura_image2.png',
    'assets/images/sura_image3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/main_background1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 70.h,
              ),
              CustomText(
                text: 'المفضلة',
                fontSize: 24.sp,
                color: mainColor,
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
                itemCount: 7,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 0.7),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text('سورة رقم ' + index.toString()),
                      Flexible(child: Image.asset(images[index], fit: BoxFit.fill))
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
