// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:welivewithquran/Services/services.dart';
// import 'package:welivewithquran/Views/read_book_screen.dart';
// import 'package:welivewithquran/zTools/colors.dart';
// import 'package:welivewithquran/custom_widgets/custom_text.dart';

// class DetailsScreen extends StatelessWidget {
//   DetailsScreen({Key? key}) : super(key: key);

//   final List images = [
//     'assets/images/sura_image3.png',
//     'assets/images/sura_image2.png',
//     'assets/images/sura_image2.png',
//     'assets/images/sura_image3.png',
//     'assets/images/sura_image2.png',
//     'assets/images/sura_image2.png',
//     'assets/images/sura_image3.png',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     dynamic argumentData = Get.arguments;

//     // final title = Get.arguments as String;

//     // return SafeArea(
//     //   child: Scaffold(
//     //     //extendBodyBehindAppBar: true,
//     //     appBar: AppBar(
//     //       elevation: 0,
//     //       backgroundColor: Colors.transparent,
//     //       toolbarHeight: 70,
//     //       leading: const SizedBox(),
//     //       actions: [
//     //         Padding(
//     //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//     //           child: GestureDetector(
//     //               onTap: () {
//     //                 Navigator.pop(context);
//     //               },
//     //               child: SvgPicture.asset('assets/icons/back_arrow.svg')),
//     //         )
//     //       ],
//     //       title: Text(
//     //         'تفاصيل',
//     //         style: TextStyle(
//     //             fontSize: 24.sp, color: mainColor, fontWeight: FontWeight.bold),
//     //       ),
//     //       centerTitle: true,
//     //     ),
//     //     body: Container(
//     //       width: double.infinity,
//     //       height: double.infinity,
//     //       decoration: const BoxDecoration(
//     //         image: DecorationImage(
//     //           image: AssetImage('assets/images/main_background1.png'),
//     //           fit: BoxFit.cover,
//     //         ),
//     //       ),
//     //       child: SingleChildScrollView(
//     //         child: Column(
//     //           children: [
//     //            const SizedBox(height: 70),
//     //
//     //             // Details
//     //             SizedBox(
//     //               height: 320.h,
//     //               width: double.infinity,
//     //               child: Row(
//     //                 children: [
//     //                   Expanded(
//     //                     child: Column(
//     //                       children: [
//     //                         CustomText(
//     //                             text: argumentData[1]['title'].toString(),
//     //                             fontSize: 24.sp),
//     //                         Expanded(
//     //                           child: ClipRRect(
//     //                             borderRadius: BorderRadius.circular(7.0),
//     //                             child: Image.network(
//     //                               imagesUrl +
//     //                                   argumentData[2]['bookCover'].toString(),
//     //                               width: 150.w,
//     //                               fit: BoxFit.fill,
//     //                             ),
//     //                           ),
//     //                         )
//     //                       ],
//     //                     ),
//     //                   ),
//     //                   Expanded(
//     //                     child: Column(
//     //                       children: [
//     //                         Expanded(
//     //                           child: SizedBox(
//     //                             width: double.infinity,
//     //                             child: Padding(
//     //                               padding: const EdgeInsets.symmetric(
//     //                                   horizontal: 8.0),
//     //                               child: Column(
//     //                                 crossAxisAlignment:
//     //                                     CrossAxisAlignment.start,
//     //                                 mainAxisAlignment: MainAxisAlignment.end,
//     //                                 children: [
//     //                                   Row(
//     //                                     children: [
//     //                                       CustomText(
//     //                                           text: 'عدد الصفحات:',
//     //                                           fontSize: 16.sp),
//     //                                       const SizedBox(width: 5),
//     //                                       CustomText(
//     //                                         text: argumentData[3]['bookPages']
//     //                                             .toString(),
//     //                                         fontSize: 16.sp,
//     //                                         color: mainColor,
//     //                                       ),
//     //                                     ],
//     //                                   ),
//     //                                   Row(
//     //                                     children: [
//     //                                       CustomText(
//     //                                         text: 'المؤلف:',
//     //                                         fontSize: 16.sp,
//     //                                         color: mainColor,
//     //                                       ),
//     //                                       const SizedBox(
//     //                                         width: 5,
//     //                                       ),
//     //                                       CustomText(
//     //                                         text: argumentData[6]['authorName']
//     //                                             .toString(),
//     //                                         fontSize: 16.sp,
//     //                                         color: mainColor,
//     //                                       ),
//     //                                     ],
//     //                                   ),
//     //                                   Row(
//     //                                     children: [
//     //                                       CustomText(
//     //                                         text: 'التصنيف:',
//     //                                         fontSize: 16.sp,
//     //                                         color: mainColor,
//     //                                       ),
//     //                                       const SizedBox(
//     //                                         width: 5,
//     //                                       ),
//     //                                       CustomText(
//     //                                         text: argumentData[7]
//     //                                                 ['categoryName']
//     //                                             .toString(),
//     //                                         fontSize: 16.sp,
//     //                                         color: mainColor,
//     //                                       ),
//     //                                     ],
//     //                                   ),
//     //                                 ],
//     //                               ),
//     //                             ),
//     //                           ),
//     //                         ),
//     //                         const SizedBox(height: 10),
//     //                         Padding(
//     //                           padding: const EdgeInsets.all(8.0),
//     //                           child: GestureDetector(
//     //                             onTap: () {
//     //                               Get.to(() => ReadBookScreen(), arguments: [
//     //                                 {
//     //                                   'pdf':
//     //                                       argumentData[5]['bookFile'].toString()
//     //                                 },
//     //                               ]);
//     //                             },
//     //                             child: Container(
//     //                               height: 50.h,
//     //                               decoration: BoxDecoration(
//     //                                   color: mainColor,
//     //                                   borderRadius: BorderRadius.circular(10)),
//     //                               child: Center(
//     //                                 child: CustomText(
//     //                                   text: 'قراءة الكتاب',
//     //                                   fontSize: 18.sp,
//     //                                   color: Colors.white,
//     //                                 ),
//     //                               ),
//     //                             ),
//     //                           ),
//     //                         ),
//     //                         Padding(
//     //                           padding: const EdgeInsets.all(8.0),
//     //                           child: GestureDetector(
//     //                             onTap: () {
//     //                               Get.to(() => ReadBookScreen(), arguments: [
//     //                                 {
//     //                                   'pdf':
//     //                                       argumentData[5]['bookFile'].toString()
//     //                                 },
//     //                               ]);
//     //                             },
//     //                             child: Container(
//     //                               height: 50.h,
//     //                               decoration: BoxDecoration(
//     //                                   color: mainColor,
//     //                                   borderRadius: BorderRadius.circular(10)),
//     //                               child: Center(
//     //                                 child: CustomText(
//     //                                   text: 'تحميل الكتاب',
//     //                                   fontSize: 18.sp,
//     //                                   color: Colors.white,
//     //                                 ),
//     //                               ),
//     //                             ),
//     //                           ),
//     //                         ),
//     //                         const SizedBox(height: 20),
//     //                       ],
//     //                     ),
//     //                   ),
//     //                 ],
//     //               ),
//     //             ),
//     //
//     //             const Divider(
//     //               indent: 25.0, endIndent: 25.0, thickness: 2, color: blueLightColor
//     //             ),
//     //
//     //             // Read else ...
//     //             Padding(
//     //               padding: const EdgeInsets.symmetric(horizontal: 30),
//     //               child: Row(
//     //                 mainAxisAlignment: MainAxisAlignment.start,
//     //                 children: [
//     //                   CustomText(
//     //                     text: 'اقرأ ايضا',
//     //                     fontSize: 18.sp,
//     //                     color: mainColor,
//     //                   ),
//     //                   const Icon(
//     //                     Icons.more_horiz_outlined,
//     //                     color: mainColor,
//     //                   )
//     //                 ],
//     //               ),
//     //             ),
//     //             SizedBox(height: 5.h),
//     //             SizedBox(
//     //               height:260.h,
//     //               //height:double.infinity,
//     //               child:
//     //               // Get Random eBook API
//     //               ListView.builder(
//     //                   scrollDirection: Axis.horizontal,
//     //                   itemCount: images.length,
//     //                   itemBuilder: (context, index) {
//     //                     return Column(
//     //                       children: [
//     //                         Image.asset(
//     //                           images[index],
//     //                           fit: BoxFit.fill,
//     //                           height: 210.h, width: 120.w
//     //                         ),
//     //                         Text(
//     //                           'د. فاطمة بنت عمر نصيف',
//     //                           style:
//     //                               TextStyle(color: blueColor, fontSize: 12.sp),
//     //                         ),
//     //                         Text(
//     //                           'سورة الفاتحة',
//     //                           style:
//     //                               TextStyle(color: mainColor, fontSize: 16.sp),
//     //                         ),
//     //                       ],
//     //                     );
//     //                   }),
//     //             )
//     //           ],
//     //         ),
//     //       ),
//     //     ),
//     //   ),
//     // );

//     return SafeArea(
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           toolbarHeight: 70,
//           leading: const SizedBox(),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: SvgPicture.asset('assets/icons/back_arrow.svg')),
//             )
//           ],
//           title: Text(
//             'تفاصيل',
//             style: TextStyle(
//                 fontSize: 24.sp, color: mainColor, fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//         ),
//         body:
//         Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/main_background1.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const SizedBox(height: 80), /// Appbar

// /// ------------------------------ Details ------------------------
//                 SizedBox(
//                   height: 290.h,
//                   width: double.infinity,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           children: [
//                             CustomText(
//                                 text: argumentData[1]['title'].toString(),
//                                 fontSize: 24.sp),
//                             Expanded(
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(7.0),
//                                 child: Image.network(
//                                   imagesUrl +
//                                       argumentData[2]['bookCover'].toString(),
//                                   height: 210.h,
//                                   width: 120.w,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Column(
//                           children: [
//                             Expanded(
//                               child: SizedBox(
//                                 width: double.infinity,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 8.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           CustomText(
//                                               text: 'عدد الصفحات: ',
//                                               fontSize: 16.sp),
//                                           const SizedBox(width: 5),
//                                           CustomText(
//                                             text: argumentData[3]['bookPages']
//                                                 .toString(),
//                                             fontSize: 16.sp,
//                                             color: mainColor,
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           // CustomText(
//                                           //   text: 'المؤلف:',
//                                           //   fontSize: 16.sp,
//                                           //   color: mainColor,
//                                           // ),
//                                           // const SizedBox(
//                                           //   width: 5,
//                                           // ),
//                                           CustomText(
//                                             text: argumentData[6]['authorName']
//                                                 .toString(),
//                                             fontSize: 16.sp,
//                                             color: mainColor,
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 1,),                                      Row(
//                                         children: [
//                                           CustomText(
//                                             text: 'قسم: ',
//                                             fontSize: 16.sp,
//                                             color: mainColor,
//                                           ),
//                                           const SizedBox(
//                                             width: 5,
//                                           ),
//                                           CustomText(
//                                             text: argumentData[7]
//                                                     ['categoryName']
//                                                 .toString(),
//                                             fontSize: 16.sp,
//                                             color: mainColor,
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             /// Download Read
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   print('downloading ....');
//                                 },
//                                 child: Container(
//                                   height: 50.h,
//                                   decoration: BoxDecoration(
//                                       color: mainColor,
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Center(
//                                     child: CustomText(
//                                       text: 'تحميل الكتاب',
//                                       fontSize: 18.sp,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             /// Read Book
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Get.to(() => ReadBookScreen(), arguments: [
//                                     {
//                                       'title': argumentData[1]['title'].toString(),
//                                       'description': argumentData[4]['bookDescription'],
//                                       //'description': argumentData[4]['bookDescription'].toString(),
//                                       'pdf': argumentData[5]['bookFile'].toString(),
//                                       'author': argumentData[6]['authorName'].toString(),
//                                     },
//                                   ]);
//                                 },
//                                 child: Container(
//                                   height: 50.h,
//                                   decoration: BoxDecoration(
//                                       color: mainColor,
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Center(
//                                     child: CustomText(
//                                       text: 'قراءة الكتاب',
//                                       fontSize: 18.sp,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(height: 20),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
// // ----------------------------------------------------------------

// /// ------------------------------ Divider ------------------------
//                 const Padding(
//                   padding:
//                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                   child: Divider(
//                       indent: 1.0,
//                       endIndent: 1.0,
//                       thickness: 2,
//                       color: blueLightColor),
//                 ),
// // ----------------------------------------------------------------

// /// ------------------------------ Read else -----------------------
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 30),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       CustomText(
//                         text: 'اقرأ ايضا',
//                         fontSize: 18.sp,
//                         color: mainColor,
//                       ),
//                       const Icon(
//                         Icons.more_horiz_outlined,
//                         color: mainColor,
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 5.h),
//                 SizedBox(
//                   height: 250.h, //180
//                   //height:double.infinity,
//                   child:
//                       // Get Random eBook API
//                       ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: images.length,
//                           itemBuilder: (context, index) {
//                             return Column(
//                               children: [
//                                 Expanded(
//                                   child: Image.asset(images[index],
//                                       fit: BoxFit.fill,
//                                       height: 190.h,
//                                       width: 120.w),
//                                 ),
//                                 Text(
//                                   'د. فاطمة بنت عمر نصيف',
//                                   style: TextStyle(
//                                       color: blueColor, fontSize: 12.sp),
//                                 ),
//                                 Text(
//                                   'سورة الفاتحة',
//                                   style: TextStyle(
//                                       color: mainColor, fontSize: 16.sp),
//                                 ),
//                               ],
//                             );
//                           }),
//                 )
// // ----------------------------------------------------------------
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
