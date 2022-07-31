// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:get/get.dart';
// // import 'package:welivewithquran/Controller/ebook_controller.dart';
// import 'package:welivewithquran/Views/details_screen.dart';
// import 'package:welivewithquran/zTools/colors.dart';
// import 'package:welivewithquran/custom_widgets/custom_text.dart';


// class LibraryScreen extends StatelessWidget {
//    LibraryScreen({Key? key}) : super(key: key);

//   //  final BookController _controller = Get.put(BookController());

//    final List images = [
//     "assets/images/sura_image3.png",
//     "assets/images/sura_image2.png",
//     "assets/images/sura_image2.png",
//     "assets/images/sura_image3.png",
//     "assets/images/sura_image2.png",
//     "assets/images/sura_image2.png",
//     "assets/images/sura_image3.png",
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/images/main_background1.png'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Column(
//         children: [
//           SizedBox(height: 80.h,),
//           CustomText(
//             text: "المكتبة",
//             fontSize: 24.sp,
//             color: mainColor,
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12.0),
//               child: GridView.builder(
//                   itemCount: 7,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: .7
//                   ),
//                   itemBuilder: (context,index){
//                     return GestureDetector(
//                       onTap: (){
//                         // Get.to(()=>DetailsScreen());
//                         Navigator.of(context).push(_createRoute());

//                       },
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 30.h,
//                             width: 100.w,
//                             decoration: BoxDecoration(
//                               color: mainColor,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Center(child: Text("سورة الفاتحة",style: TextStyle(color: Colors.white,
//                             fontSize: 16.sp),)),
//                           ),
//                           SizedBox(height: 5.h,),
//                           Container(
//                             height: 210.h,
//                             width : 140.w,
//                             child: Image.asset(images[index],fit: BoxFit.fill,),
//                           ),
//                         ],
//                       ),
//                     );

//                   }),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//    Route _createRoute() {
//      return PageRouteBuilder(
//        pageBuilder: (context, animation, secondaryAnimation) =>  DetailsScreen(),
//        transitionsBuilder: (context, animation, secondaryAnimation, child) {
//          const begin = Offset(1.0, 1.0);
//          const end = Offset.zero;
//          const curve = Curves.ease;

//          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//          return SlideTransition(
//            position: animation.drive(tween),
//            child: child,
//          );
//        },
//      );
//    }

// }
