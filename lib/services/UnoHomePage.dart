import 'dart:convert';

import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dspuiproject/Model/ChildMember.dart';
import 'package:dspuiproject/Model/UserInfo.dart';
import 'package:dspuiproject/repository/CategoryListRepository.dart';
import 'package:dspuiproject/services/Navbar/Navbar_Subscription.dart';
import 'package:dspuiproject/widgets/loginAndLoginLater.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Add this import
import 'package:shared_preferences/shared_preferences.dart';


import '../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../constant/colors.dart';
import '../helper/session_manager/SessionController.dart';
import '../provider/CartProvider.dart';
import '../provider/InternetCheckingProvider.dart';
import '../provider/ProviderData.dart';
import 'package:shimmer/shimmer.dart';
import '../helper/utils.dart';
import '../provider/SelectedMemberProvider.dart';
import '../provider/controller/loginController.dart';
import '../widgets/HelpMeBookTest.dart';
import '../widgets/ShimmerEffect.dart';
import '../widgets/rounded_botton.dart';
import 'BookingTest3.dart';
import 'BottomNavigationfooter/NavigationMenu.dart';
import 'SingleCategoryDetailsPage/SingleCategoryDetailsPage2.dart';
import 'Testingpage.dart';
import 'auth/login_screen.dart';
import 'bookingtest2.dart';
import 'cart.dart';
import 'cart2.dart';
import 'family_member_widgets/AddFamilyMember2.dart';
import 'family_member_widgets/FamilyMember.dart';
import 'Navbar/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart' as badges;
class UnoHomePage extends StatefulWidget {
  const UnoHomePage({Key? key}) : super(key: key);

  @override
  State<UnoHomePage> createState() => _UnoHomePageState();
}

class _UnoHomePageState extends State<UnoHomePage> {
  String searchText = "";
  String searchValue = '';
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  final CarouselController _controller = CarouselController();
   final List<String> imgList = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
    'assets/6.png',
    'assets/7.png',

    ];

  late String _userId;
   String _username='';
  late String _email;
  late String _password;
  late String _mobile;
  late String _profileImg;
  late String _role;
  late String _createdAt;
  late String _updatedAt;
  bool isLoggedIn = false;
// bool connected= false;

  @override
  void initState() {
    super.initState();



    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartProvider>(context, listen: false).fetchCategories();
    });
  setState(() {
    InternetConnection().onStatusChange.listen((event) {
     bool connected= event ==InternetStatus.connected;
      Color backgroundColor = connected ? Colors.green : Colors.red;

     // Update provider with connection status
     var internetProvider = Provider.of<InternetChickingProvider>(context, listen: false);
     internetProvider.updateConnectionStatus(connected);

     // LoginandLoginLaterpage.showInternet(context, 'My internet ',isDismissible: internetProvider.isConnected);
     print("cheking ${connected}");
      showSimpleNotification(Text(  connected ? "connected to internet ": "  please connect to the Internet "),background: backgroundColor);
    });
  });
    _loadUsername();


  }
  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Replace 'user_name' with your actual key
    bool loggedIn = await _sharedPreferencesService.isUserLoggedIn();
    setState(() {
      isLoggedIn = loggedIn;
      _userId = prefs.getString('user_id') ?? '';
      _username = prefs.getString('name') ?? '';
      _email = prefs.getString('email') ?? '';
      _password = prefs.getString('password') ?? '';
      _mobile = prefs.getString('mobile') ?? '';
      _profileImg = prefs.getString('profile_img') ?? '';
      _role = prefs.getString('role') ?? '';
      _createdAt = prefs.getString('created_at') ?? '';
      _updatedAt = prefs.getString('updated_at') ?? '';

    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final provider = Provider.of<ProviderData>(context);
    final providerr = Provider.of<ProviderData>(context);
    // final loginController = Provider.of<LoginController>(context);
    final loginController = Provider.of<LoginController>(context, listen: false);
    // final ref = FirebaseDatabase.instance.ref('User');
    final internetProvider = Provider.of<InternetChickingProvider>(context);
    print(" checking from provider ${internetProvider.isConnected}");
      return PopScope(
    canPop: false,
      child: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          // backgroundColor: Colors.yellow.shade600,
          backgroundColor: iconcolor,
          shadowColor: Colors.blueGrey[100],
          title: Text(
            // _username.isEmpty ? 'Hi Guest User' : 'Hi $_username',
            _username.isNotEmpty
                ? 'Hi, $_username'
                : ' Hi ,user',
            style: TextStyle(
              fontSize: 20, // Adjust the font size as needed
              fontStyle: FontStyle.italic, // Makes the text italic
              fontWeight: FontWeight.bold, // Adjust the font weight as needed
              color: Colors.black, // Adjust the text color as needed
            ),
          ),
      
      
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0), // Adjust the height of the border
            child: Container(
              color: Colors.blueGrey[100], // Color of the bottom border
              height: 2.0, // Height of the bottom border
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cart2()),
                  );
                },
                child:  Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return badges.Badge(
                      badgeContent: Text(
                        value.getcounter().toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      position: BadgePosition.topEnd(top: -17, end: 3),
                      child: Image.asset(
                        'assets/shopping-cart.png', // Path to your image asset
                        height: 30,
                        width: 30,
                      ),
                    );
                  },
                ),
              ),
            ),
            // IconButton(
            //   icon: Image.asset(
            //     'assets/power.png',  // Replace 'assets/your_image.png' with your actual image path
            //     width: 28,
            //     height: 28,
            //     fit: BoxFit.contain,  // Adjust the fit as per your requirement
            //   ),
            //   onPressed: () async {
            //     bool isLoggedIn = await _sharedPreferencesService.isUserLoggedIn();
            //     if (isLoggedIn) {
            //       // User is logged in, perform logout
            //       auth.signOut();
            //       SessionController().userId='';
            //       print("user id before logout ${await _sharedPreferencesService.getUserId()}");
            //       await _sharedPreferencesService.remove();
            //       await loginController.remove();
            //       print("user ifd deleted ${isLoggedIn}");
            //       print("user id after logout ${await _sharedPreferencesService.getUserId()}");
            //
            //       Utils().toastmessage("logout successfully", Colors.green);
            //       Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationMenu()));
            //     } else {
            //       // User is not logged in, navigate to login screen
            //       Utils().toastmessage("please login here ", Colors.red);
            //       Navigator.push(context, MaterialPageRoute(builder: (context) => loginscreen()));
            //     }
            //   },
            // ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
      
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: browncolor2),
                    color: Colors.white, // Background color
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search Location...',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            // Handle onChanged event
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            // Handle search button tap
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: browncolor2.withOpacity(0.2), // Button background color
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.search,
                              color: browncolor2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      
                SizedBox(height: 10),
      
      
               Consumer<SelectedMemberProvider>(
                   builder: (context,provider,_){
                     return  Container(
                       height: 50,
                       // decoration: BoxDecoration(
                       //   borderRadius: BorderRadius.circular(8),
                       //   border: Border.all(color: browncolor2),
                       //   color: Colors.white,
                       // ),
                       child: Row(
                         children: [
                           InkWell(
                             onTap:(){
      
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingTest3()));
                            },
                             child: Container(
                               width: 45,
                               height: 45,
                               decoration: BoxDecoration(
                                 border: Border.all(color: browncolor2),
                                 shape: BoxShape.circle,
                                 color: browncolor3, // Change the color as needed
                               ),
                               child: Stack(
                                 children: [
                                   Center(
                                     child: Text(
                                       provider.name ?? 'User',
                                       textAlign: TextAlign.center,
                                       style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 12,fontWeight: FontWeight.bold // Adjust the font size as needed
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
      
                           SizedBox(width: 5),
                           // Container(
                           //   width: 40,
                           //   height: 40,
                           //   decoration: BoxDecoration(
                           //     border: Border.all(color: browncolor2),
                           //     shape: BoxShape.circle,
                           //     color: browncolor3, // Change the color as needed
                           //   ),
                           //   child: Stack(
                           //     children: [
                           //       Center(
                           //         child: Text(
                           //           'rajen',
                           //           style: TextStyle(
                           //               color: Colors.black,
                           //               fontSize: 12,fontWeight: FontWeight.bold // Adjust the font size as needed
                           //           ),
                           //         ),
                           //       ),
                           //     ],
                           //   ),
                           // ),
      
                           Spacer(), // This widget will push the following widgets to the rightmost side
                           InkWell(
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFamilyMember2()));
                             },
                             child: Container(
                               width: 40,
                               height: 40,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 border: Border.all(color: browncolor2),
                                 color: Colors.white, // Change the color as needed
                               ),
                               child: Icon(
                                 Icons.add,
                                 color: Colors.black,
                               ),
                             ),
                           ),
                         ],
                       ),
                     );
                   }
      
               ),
      
                SizedBox(height: 10),
                CarouselSlider.builder(
                  itemCount: imgList.length,
                  options: CarouselOptions(
                    height: 120,
      
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 1,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    return GestureDetector(
                      onTap: () {
                        // Handle onTap event
                        print('Clicked on image ${index}');
                      },
                      child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0), // Adjust margin as needed
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                      color: Colors.black, // Border color
                      width: 1.0, // Border width
                      ),
                      ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                imgList[index],
                                fit: BoxFit.cover,
                                width: 1000,
                              ),
                              // Positioned(
                              //   top: 10,
                              //   left: 10,
                              //   child: Text(
                              //     '${index + 1}',
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 24,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
      
                InkWell(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Testingpage(), // Corrected builder syntax
                      ),
                    );
      
                  },
                  child: Container(
                    height: 100,
                    width: 380,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(8),
                    //   border: Border.all(color: browncolor2),
                    //   color: Colors.black,
                    // ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.brown),
                          ),
                           color: deeporange, // Change color as per your requirement
                          child: SizedBox(
                            width: 145,
                            height: 80,
                            // Add your content here
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/searchicon.png',  // Replace 'assets/your_image.png' with your actual image path
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.contain,  // Adjust the fit as per your requirement
                                ),
      
                                Text(
                                  'Find a Center',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
      
                        InkWell(
                          onTap: () async {
                            bool isLoggedIn = await _sharedPreferencesService.isUserLoggedIn();
                            if(isLoggedIn){
      
                            //   TestRepository repository = TestRepository();
                            // CategegoryRepository cat =    CategegoryRepository();
                            //
                            //   try {
                            //     List<String> testInfos = await cat.fetchCategories();
                            //     for (var info in testInfos) {
                            //       print('Test Info: $info');
                            //
                            //       print('------------------------');
                            //     }
                            //   } catch (e) {
                            //     print('Failed to fetch test info: $e');
                            //   }
      
      
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpMeBookTestPage()));
      
                            }else{
                              // Navigator.pop(context);
      
                              LoginandLoginLaterpage.show(context, "not sure about test ");
                            }
                          },
                          child: Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.brown),
                            ),
                            color: deeporange, // Change color as per your requirement
                            child: SizedBox(
                              width: 145,
                              height: 80,
                              // Add your content here
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/notsureabouttest.png',  // Replace 'assets/your_image.png' with your actual image path
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.contain,  // Adjust the fit as per your requirement
                                  ),
      
                                  Text(
                                    'Not sure about test',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
      
      
                Container(
                  width: 600,
                  height: 140,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(20),
                  //   border: Border.all(color: Colors.grey),
                  // ),
                  child: Consumer<CartProvider>(
                    builder: (context, provider, _) {
                      if (provider.categories.isEmpty) {
                        return Center(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: ShimmerCategoryListWidget(),
                          ),
                        );
                      }
                      // List of icons corresponding to each category (example)
                      List<String> categoryImages = [
                        'assets/biopsy.png',
                        'assets/stool.png',
                        'assets/specialtest3.png',
                        'assets/electrolprosis.jpg',
                        'assets/other.png',
                        'assets/urine.png',
                        'assets/serology.png',
                        'assets/hemotology.png',
                        'assets/biochemistry.png',
                      ];
      
                      return GridView.count(
                        scrollDirection: Axis.horizontal,
                        crossAxisCount: 1, // Number of columns in the grid
                        childAspectRatio: 1.4, // Aspect ratio of each grid item
                        mainAxisSpacing: 1, // Spacing between rows
                        crossAxisSpacing: 2, // Spacing between columns
                        children: provider.categories.asMap().entries.map((entry) {
                          int index = entry.key;
                          String category = entry.value.toUpperCase();
                          String imagePath = categoryImages[index % categoryImages.length];
      
                          Offset offset;
                          if (index == 2) {
                            offset = Offset(0, 8); // Shift item at index 2 down by 8 units
                          } else if (index == 3) {
                            offset = Offset(0, 8); // Shift item at index 3 down by 16 units
                          } else {
                            offset = Offset.zero; // No offset for other items
                          }
                          return GestureDetector(
                            onTap: () {
                              // Handle onTap event for the card
                              print('Clicked on $category');
                              // provider.fetchSingleCategories(category);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleCategoryDetailsPage2(category),
                                ),
                              );
                            },
                            child: Transform.translate(
                              offset: offset,
                              child: Card(
                                // elevation: 20, // Shadow elevation
                                // shape: RoundedRectangleBorder(
                                //   borderRadius: BorderRadius.circular(20),
                                //   side: BorderSide(color: Colors.brown), // Border color
                                // ),
                                // color: iconcolor, // Card color
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      imagePath,
                                      width: 50, // Adjust image width as needed
                                      height: 50, // Adjust image height as needed
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      category,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                              
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
      
      
      
      
      
      
      
      
                SizedBox(height: 2),
      
                Container(
      
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                  ),
                  height: 100,
                  width: 400,
                  // margin: EdgeInsets.only(left: 1),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // bool isLoggedIn = await _sharedPreferencesService.isUserLoggedIn();
                            // if(isLoggedIn) {
                              // showModalBottomSheet(context: context,isScrollControlled: true, builder: (BuildContext context) {
                                // return FractionallySizedBox(
                                    // heightFactor: 0.99,
                                    // child: CustomBottomSheet());
                              // },);
                            // } else {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookingTest3()),);
                            // }
                          },
                          child: Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.brown),
                            ),
                            color: deeporange,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Book a Test \n Click Here',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  SizedBox(width: 2),
                                  Image.asset(
                                    'assets/bookatesthome.png',  // Replace 'assets/your_image.png' with your actual image path
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.contain,  // Adjust the fit as per your requirement
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle "View Report" button tap
                            // fetchData();
                          },
                          child: Card(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.brown),
                            ),
                            color: deeporange,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'View Report \n click here ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  SizedBox(width: 2),
                                  Image.asset(
                                    'assets/viewreports.png',  // Replace 'assets/your_image.png' with your actual image path
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.contain,  // Adjust the fit as per your requirement
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
      
      
      
      
      
                // SizedBox(height: 10),
      
      
      
      
              ],
            ),
          ),
        ),
      ),
    );
  }







}

