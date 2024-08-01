// import 'package:flutter/material.dart';
// import 'package:dspuiproject/constant/colors.dart';
// import 'package:dspuiproject/provider/ProviderData.dart';
// import 'package:dspuiproject/services/details.dart';
//  // Adjust import path as per your project
// import 'package:provider/provider.dart';
//
// import '../Model/TestInfo.dart';
// import '../Model/TestInformation.dart';
// import 'Detailspage.dart';
// import 'cart.dart';
//
// class BookingTest2 extends StatefulWidget {
//   const BookingTest2({Key? key}) : super(key: key);
//
//   @override
//   State<BookingTest2> createState() => _BookingTest2State();
// }
//
// class _BookingTest2State extends State<BookingTest2> {
//   TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//   }
//
//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   void _onSearchChanged() {
//     setState(() {}); // Trigger rebuild when text changes
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProviderData>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: iconcolor,
//         title: const Text(
//           "Book A Test",
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//         actions: [
//           InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AddCart()),
//               );
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
//               child: Stack(
//                 children: [
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Icon(
//                       Icons.shopping_cart_rounded,
//                       color: navyBlueColor,
//                       size: 30,
//                     ),
//                   ),
//                   if (provider.addIdValue.isNotEmpty)
//                     Positioned(
//                       top: 2,
//                       left: 6,
//                       right: 0,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: redColor,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(6.0),
//                           child: Text(
//                             provider.addIdValue.length.toString(),
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 13,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//       body: Container(
//         child: Column(
//
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
//               child: TextField(
//                 controller: _searchController,
//                 style: TextStyle(fontSize: 16.0),
//                 decoration: InputDecoration(
//                   labelText: 'Search by test name',
//                   prefixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(color: navyBlueColor, width: 2.0),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(color: Colors.grey[400]!, width: 1.0),
//                   ),
//                   labelStyle: TextStyle(color: navyBlueColor),
//                 ),
//               ),
//             ),
//
//             Expanded(
//               child: Consumer<ProviderData>(
//                 builder: (context, providerData, child) {
//                   List<TestInformation> filteredList = provider.searchTestInfos(_searchController.text);
//
//                   if (filteredList.isEmpty) {
//                     return Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.info_outline,
//                               size: 80,
//                               color: Colors.grey[400],
//                             ),
//                             SizedBox(height: 20),
//                             Text(
//                               "No tests found.",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey[600],
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//
//                   } else {
//                     return ListView.builder(
//                       itemCount: filteredList.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         final testInfo = filteredList[index];
//                         bool isInCart = provider.addIdValue.contains(testInfo.id ?? '');
//
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Card(
//                             elevation: 5,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//
//                             child: Padding(
//                               padding: const EdgeInsets.all(15.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Image.asset(
//                                         'assets/logo.jpg',
//                                         height: 30,
//                                         width: 30,
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Expanded(
//                                         child: Text(
//                                           testInfo.tests ?? '',
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16,
//                                             color: navyBlueColor,
//                                           ),
//                                         ),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           // Implement compare functionality
//                                         },
//                                         child: const Text(
//                                           "Compare",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 14,
//                                             color: textColor,
//                                           ),
//                                         ),
//                                       ),
//                                       const Icon(
//                                         Icons.compare,
//                                         color: Colors.black,
//                                         size: 25,
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10),
//                                   Row(
//                                     children: [
//                                       const Icon(Icons.info_outline,
//                                           color: Colors.black, size: 30),
//                                       const SizedBox(width: 10),
//                                       Expanded(
//                                         child: Text(
//                                           testInfo.reporting ?? '',
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 14,
//                                             color: textColor,
//                                           ),
//                                         ),
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                               builder: (context) => DetailsPage(),
//                                             ),
//                                           );
//                                         },
//                                         child: const Text(
//                                           "DETAILS",
//                                           style: TextStyle(
//                                             decoration: TextDecoration.underline,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 14,
//                                             color: navyBlueColor,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10),
//                                   Row(
//                                     children: [
//                                       const Icon(Icons.settings,
//                                           color: Colors.black, size: 30),
//                                       const SizedBox(width: 10),
//                                       Expanded(
//                                         child: Text(
//                                           testInfo.rates != null
//                                               ? 'Rs. ${testInfo.rates}'
//                                               : '',
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 14,
//                                             color: textColor,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10),
//                                   Row(
//                                     children: [
//                                       const Icon(Icons.text_snippet_outlined,
//                                           color: Colors.black, size: 30),
//                                       const SizedBox(width: 10),
//                                       Expanded(
//                                         child: Text(
//                                           testInfo.sNo != null
//                                               ? 'S No. ${testInfo.sNo}'
//                                               : '',
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 14,
//                                             color: textColor,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 20),
//                                   Container(
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: isInCart ? tealGreenColor : navyBlueColor,
//                                       ),
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: InkWell(
//                                       onTap: () {
//                                         if (isInCart) {
//                                           provider.removeFromCart(testInfo);
//                                         } else {
//                                           provider.addToCart(testInfo);
//                                         }
//                                       },
//                                       child: Center(
//                                         child: Text(
//                                           isInCart ? "REMOVE FROM CART" : "ADD TO CART",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16,
//                                             color: isInCart ? redColor : navyBlueColor,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
