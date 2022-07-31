// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:welivewithquran/Services/services.dart';
// import 'package:welivewithquran/Views/details_screen.dart';
// import 'package:welivewithquran/zTools/colors.dart';
// import 'package:welivewithquran/custom_widgets/custom_text.dart';

// import '../../Controller/ebook_controller.dart';

// class LibraryScreen extends StatelessWidget {
//   final BookController _controller = Get.put(BookController());

//   // Declare a field that holds the eBook.
//   //late final Ebook books;

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
//     return Obx(
//       () {
//         if (_controller.isLoading.value) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         return RefreshIndicator(
//           onRefresh: _controller.getAll,
//           child: Container(
//             padding: EdgeInsets.zero,
//             margin: EdgeInsets.zero,
//             width: double.infinity,
//             //height: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/main_background1.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(height: 70.h),
//                 CustomText(text: 'المكتبة', fontSize: 38.sp),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 7.0),
//                     child: GridView.builder(
//                       padding: EdgeInsets.zero,
//                       itemCount: _controller.bookList.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3, //2
//                         childAspectRatio: .5, //.7
//                         mainAxisExtent: 200,
//                       ),
//                       itemBuilder: (context, _index) {
//                         return GestureDetector(
//                           onTap: () {
//                             Get.to(
//                               () => DetailsScreen(),
//                               arguments: [
//                                 {
//                                   'id': _controller.bookList[_index].id,
//                                 },
//                                 {
//                                   'title':
//                                       _controller.bookList[_index].bookTitle,
//                                 },
//                                 {
//                                   'bookCover':
//                                       _controller.bookList[_index].bookCoverImg,
//                                 },
//                                 {
//                                   'bookPages': _controller.bookList[_index].id,
//                                 },
//                                 {
//                                   'bookDescription': _controller
//                                       .bookList[_index].bookDescription,
//                                 },
//                                 {
//                                   'bookFile':
//                                       _controller.bookList[_index].bookFileUrl,
//                                 },
//                                 {
//                                   'authorName':
//                                       _controller.bookList[_index].authorName,
//                                 },
//                                 {
//                                   'categoryName':
//                                       _controller.bookList[_index].categoryName,
//                                 },
//                                 {
//                                   "book": _index,
//                                 },
//                                 {
//                                   "books": _controller,
//                                 },
//                               ],
//                             );
//                             // Navigator.of(context).push(_createRoute());
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(3.0),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   height: 30.h,
//                                   width: 100.w,
//                                   decoration: BoxDecoration(
//                                     color: mainColor,
//                                     borderRadius: BorderRadius.circular(7),
//                                   ),
//                                   child: Center(
//                                       child: Text(
//                                     _controller.bookList[_index].bookTitle,
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16.sp,
//                                         height: 1.0),
//                                   )),
//                                 ),
//                                 SizedBox(height: 7.h),
//                                 Expanded(
//                                   child: SizedBox(
//                                     height: 210.h,
//                                     width: 130.w,
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(7.0),
//                                       child: Image.network(
//                                         imagesUrl +
//                                             _controller
//                                                 .bookList[_index].bookCoverImg,
//                                         fit: BoxFit.fill,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Route _createRoute() {
//   //   return PageRouteBuilder(
//   //     pageBuilder: (context, animation, secondaryAnimation) => DetailsScreen(),
//   //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//   //       const begin = Offset(1.0, 1.0);
//   //       const end = Offset.zero;
//   //       const curve = Curves.ease;

//   //       var tween =
//   //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//   //       return SlideTransition(
//   //         position: animation.drive(tween),
//   //         child: child,
//   //       );
//   //     },
//   //   );
//   // }

//   BoxDecoration borderSide() {
//     return const BoxDecoration(
//       border: Border(
//         left: BorderSide(
//           //                   <--- left side
//           color: Colors.black,
//           width: 3.0,
//         ),
//         top: BorderSide(
//           //                    <--- top side
//           color: Colors.black,
//           width: 3.0,
//         ),
//       ),
//     );
//   }
// }
