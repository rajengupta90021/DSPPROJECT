// import 'dart:ffi';
//
// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
//
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../constant/colors.dart';
// import '../provider/ProviderData.dart';
// import 'bookingtest.dart';
// import 'cart.dart';
//
//
//
//
//
// class homepage extends StatefulWidget {
//   const homepage({super.key});
//
//   @override
//   State<homepage> createState() => _homepageState();
// }
//
// class _homepageState extends State<homepage> {
//
//
//
//
//   int _current = 0;
//   final CarouselController _controller = CarouselController();
//
//   final themeMode = ValueNotifier(2);
//
//   List recommendedTestList = [
//     {'name': 'Thyroid', 'image':'assets/thyroid.png'},
//     {'name': 'Diabetes', 'image':'assets/blood-test.png'},
//     {'name': 'Heart', 'image':'assets/pulse.png'},
//     {'name': 'Vitamin', 'image':'assets/vitamins.png'},
//     {'name': 'Joints', 'image':'assets/pain.png'},
//     {'name': 'Full Body', 'image':'assets/body.png'}
//     ];
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProviderData>(context);
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Hi, Guest User",style: TextStyle( fontWeight: FontWeight.bold,fontSize: 20),),
//           leading: IconButton(
//             onPressed: (){},
//             icon: Icon(Icons.menu),
//           ),
//           bottomOpacity: 30,
//           actions: [
//             InkWell(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => AddCart()));
//               },
//               child: Padding(
//                 padding:
//                 const EdgeInsets.only(left: 0, right: 15, top: 0, bottom: 15),
//                 child: Stack(
//                   children: [
//                     Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Icon(Icons.shopping_cart_rounded,
//                             color: navyBlueColor, size: 25)),
//                     provider.addIdValue.length == 0?Container():
//                     Positioned(
//                       top: -2,
//                       left: 6,
//                       right: 0,
//                       child: Container(
//                           decoration: new BoxDecoration(
//                             color: redColor,
//                             shape: BoxShape.circle,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(6.0),
//                             child: Text(provider.addIdValue.length.toString(),style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 13,
//                                 color: Colors.white),),
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       body: Container(
//         color: lightBink,
//         child: SingleChildScrollView(
//           child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//             CarouselSlider(
//               items: imageSliders,
//               carouselController: _controller,
//               options: CarouselOptions(
//                   autoPlay: true,
//                   enlargeCenterPage: true,
//                   aspectRatio: 2.0,
//                   onPageChanged: (index, reason) {
//                     setState(() {
//                       _current = index;
//                     });
//                   }),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: imgList.asMap().entries.map((entry) {
//                 return GestureDetector(
//                   onTap: () => _controller.animateToPage(entry.key),
//                   child: Container(
//                     width: 12.0,
//                     height: 12.0,
//                     margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: (Theme.of(context).brightness == Brightness.dark
//                             ? Colors.white
//                             : Colors.black)
//                             .withOpacity(_current == entry.key ? 0.9 : 0.4)),
//                   ),
//                 );
//               }).toList(),
//             ),
//                 SizedBox(
//                   height: 20,
//                 ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) => bookingtest()));
//                     },
//                     child: Container(
//                       width: 160,
//                       height: 100,
//                       decoration: const BoxDecoration(
//                           color: whiteColor,
//                           borderRadius: BorderRadius.all(Radius.circular(10),),
//                           boxShadow: [
//                             BoxShadow(
//                                 color: greyColor,
//                                 blurRadius: 5,
//                                 spreadRadius: 0.1,
//                                 offset: Offset(
//                                   2,
//                                   2,
//                                 )
//                             )]
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: 20,),
//                             Text("BOOK A TEST",style: TextStyle( fontWeight: FontWeight.w500, fontSize: 18),),
//                             SizedBox(height: 3,),
//                             Row(
//                               children: [
//                                 Text("CLICK HERE"),
//                                 SizedBox(width: 10,),
//                                 Icon(Icons.arrow_forward_outlined,size: 20),
//                               ],
//                             )
//
//                           ],
//                         ),
//                       ),
//                       ),
//                   ),
//                   Container(
//                     width: 160,
//                     height: 100,
//                     decoration: const BoxDecoration(
//                         color: whiteColor,
//                         borderRadius: BorderRadius.all(Radius.circular(10),),
//                         boxShadow: [
//                           BoxShadow(
//                               color: greyColor,
//                               blurRadius: 5,
//                               spreadRadius: 0.1,
//                               offset: Offset(
//                                 2,
//                                 2,
//                               )
//                           )]
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(10.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 20,),
//                           Text("VIEW REPORTS",style: TextStyle( fontWeight: FontWeight.w500, fontSize: 18),),
//                           SizedBox(height: 3,),
//                           Row(
//                             children: [
//                               Text("CLICK HERE"),
//                               SizedBox(width: 10,),
//                               Icon(Icons.arrow_forward_outlined,size: 20),
//                             ],
//                           )
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Container(
//                         height: 25,
//                         width: 4,
//                        // color: textColor,
//                         decoration: const BoxDecoration(
//                             color: textColor,
//                             borderRadius: BorderRadius.all(Radius.circular(20),),
//
//                         ),
//                       ),
//                       SizedBox(width: 10,),
//                       Text("Recommended Tests",style: TextStyle( fontWeight: FontWeight.bold, fontSize: 18),),
//
//
//
//                     ],
//                   ),
//                 ),
//
//                 Container(
//                   height: 130,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemCount: recommendedTestList.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           width: 110,
//                           decoration: const BoxDecoration(
//                               color: whiteColor,
//                               borderRadius: BorderRadius.all(Radius.circular(15),),
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: greyColor,
//                                     blurRadius: 5,
//                                     spreadRadius: 0.1,
//                                     offset: Offset(
//                                       2,
//                                       2,
//                                     )
//                                 )]
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.all(10.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 SizedBox(
//                                   height: 12,
//                                 ),
//                                 CircleAvatar(
//                                   radius: 20, //radius of avatar
//                                   backgroundColor: extralightBlueColor, //color
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8), // Border radius
//                                     child: ClipOval(child: Image.asset(recommendedTestList[index]['image'])),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 12,
//                                 ),
//                                 Text(recommendedTestList[index]['name'],style: TextStyle( fontWeight: FontWeight.bold, fontSize: 10),),
//                                 // SizedBox(height: 3,),
//                                 // Text("CLICK HERE"),
//                                 // SizedBox(width: 10,),
//                                 // Icon(Icons.arrow_forward_outlined,size: 10)
//
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//
//
//               ]),
//         ),
//       ),
//     );
//   }
// }
//
// final List<String> imgList = [
//   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];
//
//
// final List<Widget> imageSliders = imgList
//     .map((item) => Container(
//   child: Container(
//     margin: EdgeInsets.all(5.0),
//     child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(5.0)),
//         child: Stack(
//           children: <Widget>[
//             Image.network(item, fit: BoxFit.cover, width: 1000.0),
//             Positioned(
//               bottom: 0.0,
//               left: 0.0,
//               right: 0.0,
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color.fromARGB(200, 0, 0, 0),
//                       Color.fromARGB(0, 0, 0, 0)
//                     ],
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                   ),
//                 ),
//                 padding: EdgeInsets.symmetric(
//                     vertical: 10.0, horizontal: 20.0),
//                 child: Text(
//                   'No. ${imgList.indexOf(item)} image',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         )),
//   ),
// ))
//     .toList();
//
//
//
