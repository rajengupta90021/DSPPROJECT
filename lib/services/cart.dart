// import 'package:dspuiproject/Model/TestInfo.dart';
// import 'package:dspuiproject/constant/colors.dart';
// import 'package:dspuiproject/services/auth/login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:dspuiproject/provider/ProviderData.dart'; // Import your provider class
// import 'package:dspuiproject/services/bookingtest2.dart';
//
// import '../Model/CategorySingleTestinfo2.dart';
// import '../Model/TestInformation.dart';
// import '../SharedPreferecneService/SharedPreferenceSerivice.dart';
// import 'Payment/SelectAnAdress.dart'; // Assuming this is where BookingTest2 is defined
//  // Adjust this import as per your project structure
//
// class AddCart extends StatefulWidget {
//   const AddCart({Key? key}) : super(key: key);
//
//   @override
//   State<AddCart> createState() => _AddCartState();
// }
//
// class _AddCartState extends State<AddCart> {
//   final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
//   bool _isLoggedIn = false; // Track user login status
//
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus(); // Check initial login status when the widget initializes
//   }
//
//   // Method to check user login status
//   void _checkLoginStatus() async {
//     bool isLoggedIn = await _sharedPreferencesService.isUserLoggedIn();
//     setState(() {
//       _isLoggedIn = isLoggedIn;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ProviderData>(context);
//     final auth = FirebaseAuth.instance;
//     final user = auth.currentUser;
//     final ref = FirebaseDatabase.instance.ref('User');
//
//
//     // Calculate totalValue
//     num totalValue = 0;
//     if (provider.addCart.isNotEmpty) {
//       for (int i = 0; i < provider.addCart.length; i++) {
//         totalValue += provider.addCart[i]['Rates(Rs)'] ?? 0;
//       }
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Cart",
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context); // Use pop instead of push to go back
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//       ),
//       body: provider.addCart.isEmpty
//           ? Container(
//         width: MediaQuery.of(context).size.width,
//         color: lightBink,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 200,
//             ),
//             CircleAvatar(
//               radius: 30,
//               backgroundColor: extralightBlueColor,
//               child: ClipOval(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Image.asset('assets/empty-cart.png'),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text("Find some tests", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
//             SizedBox(
//               height: 5,
//             ),
//             Text("Looks like there are no tests in your cart."),
//             SizedBox(
//               height: 20,
//             ),
//             Text("Please try some of our tests exclusively recommended for you."),
//             SizedBox(height: 40,),
//
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingTest2()));
//               },
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.black,
//                 backgroundColor: iconcolor, // Text color of the button
//                 minimumSize: Size(200, 50), // Set the minimum size of the button
//               ),
//               child: Text(
//                 'Explore Tests',
//                 style: TextStyle(
//                   fontSize: 18, // Text size
//                   fontWeight: FontWeight.bold, // Text weight
//                 ),
//               ), // Add your button text here
//             ),
//
//           ],
//         ),
//       )
//           : Column(
//         children: [
//
//           Text("Text Selected - ${provider.addCart.length}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: navyBlueColor)),
//           Expanded(
//             child: ListView.builder(
//               itemCount: provider.addCart.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final Map<String, dynamic> cartItem = provider.addCart[index];
//                 final TestInformation testInfo = TestInformation.fromJson(cartItem); // Convert Map to testinfo
//                 final TestInformation singletest = TestInformation.fromJson(cartItem); // Convert Map to testinfo
//
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   elevation: 2,
//                   shadowColor: Colors.red, // Shadow color
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   color: Colors.white,
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.all(10.0),
//                     title: Text(
//                       testInfo.tests ?? '',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: navyBlueColor,
//                       ),
//                     ),
//                     subtitle: Text(
//                       'Rs. ${testInfo.rates ?? ''}',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[700],
//                           fontWeight: FontWeight.bold
//                       ),
//                     ),
//                     trailing: IconButton(
//                       icon: Icon(Icons.clear),
//                       onPressed: () {
//                         provider.removeFromCart(testInfo);
//                         provider.removeFromCartCategory(singletest);
//
//                         print('Removed item: ${testInfo.tests}');
//                         setState(() {
//                           // Remove item from the local list used by ListView.builder
//                           provider.addCart.removeAt(index);
//                         });
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//
//
//           Container(
//             width: 390, // Set a fixed width
//             // height: 50, // Set a fixed height
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => BookingTest2()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.grey, // Background color
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10), // Rounded corners
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Add More Tests',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   Icon(Icons.add_circle_outline), // Icon on the right
//                 ],
//               ),
//             ),
//           ),
//
//
//
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Total:",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//                 Text(
//                   "Rs. $totalValue",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                 ),
//               ],
//             ),
//           ),
//       Container(
//         width: 390,
//         child: ElevatedButton(
//           onPressed: () {
//             final auth = FirebaseAuth.instance;
//             final user = auth.currentUser;
//
//             if (_isLoggedIn) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ChangeAnAdress()),
//               );
//             } else {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => loginscreen()),
//               );
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             padding: EdgeInsets.symmetric(vertical: 8), // Adjust vertical padding as needed
//             backgroundColor: iconcolor,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//
//               Text(
//                 _isLoggedIn ? 'Proceed' : 'Proceed to Login',
//                 // FirebaseAuth.instance.currentUser != null ? 'Proceed' : 'Proceed to Login',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(width: 8), // Add space between text and icon
//               Icon(Icons.arrow_forward),
//             ],
//           ),
//         ),
//       ),
//           SizedBox(height: 10,)
//
//
//
//       ],
//       ),
//     );
//   }
// }
