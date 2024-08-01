// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../constant/colors.dart';
//
//
// class UserAccountPage extends StatefulWidget {
//   const UserAccountPage({Key? key}) : super(key: key);
//
//   @override
//   State<UserAccountPage> createState() => _UserAccountPageState();
// }
//
// class _UserAccountPageState extends State<UserAccountPage> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController gradeController = TextEditingController();
//   TextEditingController schoolController = TextEditingController();
//   Uint8List? _image;
//   String selectedCategory = '';
//   String selectedGrade = '';
//   String selectedStream = '';
//   bool gradeVisible = false;
//   bool streamVisible = false;
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     nameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     schoolController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     print('Build UserAccount Page');
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: () {},
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Row(children: [
//               // Icon(
//               //   Icons.arrow_back,
//               //   color: textColor,
//               //   size: 24,
//               // ),
//               const SizedBox(
//                 width: 20,
//               ),
//               const Text(
//                 'Account',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ]),
//           ),
//         ),
//         Flexible(
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 width: double.infinity,
//               ),
//               Positioned(
//                 top: 60,
//                 child: Container(
//                   width: size.width - 20,
//                   height: size.height - 180,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: bgColor.withOpacity(0.1),
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(30.0),
//                       topRight: Radius.circular(30.0),
//                       bottomLeft: Radius.circular(30.0),
//                       bottomRight: Radius.circular(30.0),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(top: 60.0, bottom: 20.0),
//                         child: Text(
//                           "Change Profile",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ),
//                       Container(
//                         height: size.height - 300,
//                         padding: const EdgeInsets.only(
//                             left: 20.0, right: 20.0, bottom: 20.0),
//                         child: SingleChildScrollView(
//                           physics: const BouncingScrollPhysics(),
//                           child: Consumer<ProviderData>(builder:
//                               (BuildContext context, value, Widget? child) {
//                             // if (value.userData != null) {
//                             //   nameController.text = value.userData?['username'];
//                             //   emailController.text = value.userData?['email'];
//                             //   phoneController.text = value.userData?['phone'];
//                             // }
//                             // selectedCategory = value.userData!['category'];
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 AppTextField(
//                                   title: 'Full Name',
//                                   isRequired: false,
//                                   isEnabled: value.isEditable,
//                                   controller: nameController,
//                                   validator: (String? val) {
//                                     if (val == null ||
//                                         val.isEmpty ||
//                                         !val.isValidName) {
//                                       return 'Please Enter a Valid User Name.';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 AppTextField(
//                                   title: 'Phone Number',
//                                   isRequired: false,
//                                   isEnabled: false,
//                                   controller: phoneController,
//                                   // validator: (String? val) {
//                                   //   if (val == null ||
//                                   //       val.isEmpty ||
//                                   //       !val.isValidPhone) {
//                                   //     return 'Please Enter a Valid Phone Number with country code as prefix.';
//                                   //   }
//                                   //   return null;
//                                   // },
//                                 ),
//                                 AppTextField(
//                                   title: 'Email Address',
//                                   isRequired: false,
//                                   isEnabled: value.isEditable,
//                                   controller: emailController,
//                                   validator: (String? val) {
//                                     if (val == null ||
//                                         val.isEmpty ||
//                                         val.isValidEmail) {
//                                       return 'Please Enter a Valid Email.';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Padding(
//                                       padding: EdgeInsets.all(5.0),
//                                       child: Text(
//                                         'Category',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color: greyColor,
//                                         ),
//                                       ),
//                                     ),
//                                     if (value.isEditable)
//                                       Consumer<DropDownProvider>(
//                                         builder: (context, provider, child) {
//                                           // selectedCategory = categoryList.firstWhere((element) => element.name == value.userData!['category']).id;
//                                           selectedCategory = provider
//                                                   .selectUpdatedCategoryDropDownValue ??
//                                               '';
//                                           print(
//                                               'selectedCategory: $selectedCategory');
//                                           return AppDropDown(
//                                             selectedValue: provider
//                                                 .selectUpdatedCategoryDropDownValue,
//                                             onChanged: (String? text) {
//                                               setState(() {
//                                                 //This ID is for General Quiz
//                                                 if (text ==
//                                                     "dasvPH3EDAcViJdarrnw") {
//                                                   gradeVisible = false;
//                                                   streamVisible = false;
//                                                 } else {
//                                                   gradeVisible = true;
//                                                 }
//                                               });
//                                               if (text != null) {
//                                                 provider
//                                                     .setUpdatedCategoryDropDownValue(
//                                                         text);
//                                                 //Filtering gradeList according to categoryList
//                                                 tempGradeList = level2List
//                                                     .where((element) =>
//                                                         element.level1Id
//                                                             .toString() ==
//                                                         provider
//                                                             .selectUpdatedCategoryDropDownValue
//                                                             .toString())
//                                                     .toList();
//                                                 //For Sorting
//                                                 tempGradeList.sort((a, b) {
//                                                   if (a.name.contains('t')) {
//                                                     int gradeA = int.parse(
//                                                         a.name.split('t')[0]);
//                                                     int gradeB = int.parse(
//                                                         b.name.split('t')[0]);
//                                                     return gradeA
//                                                         .compareTo(gradeB);
//                                                   } else {
//                                                     return a.name
//                                                         .compareTo(b.name);
//                                                   }
//                                                 });
//                                               }
//                                             },
//                                             backgroundColor: whiteColor,
//                                             items: level1List
//                                                 .map<DropdownMenuItem<String>>(
//                                                     (val) {
//                                               return DropdownMenuItem<String>(
//                                                 value: val.id.toString(),
//                                                 child: Text(
//                                                   val.name,
//                                                 ),
//                                               );
//                                             }).toList(),
//                                           );
//                                         },
//                                       ),
//                                     if (!value.isEditable)
//                                       Container(
//                                         width: double.infinity,
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 15, vertical: 18),
//                                         decoration: BoxDecoration(
//                                           color: whiteColor,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                         ),
//                                         child: value.userData != null
//                                             ? Text(
//                                                 '${value.userData!['category']}',
//                                                 style: const TextStyle(
//                                                   color: greyColor,
//                                                 ),
//                                               )
//                                             : const Text(
//                                                 'category',
//                                                 style: TextStyle(
//                                                   color: greyColor,
//                                                 ),
//                                               ),
//                                       ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     // Visibility(
//                                     //   visible: selectedCategory != "General Quiz"? true: false ,
//                                     //   child: const Padding(
//                                     //     padding: EdgeInsets.all(5.0),
//                                     //     child: Text(
//                                     //       'Grade',
//                                     //       style: TextStyle(
//                                     //         fontSize: 16,
//                                     //         color: greyColor,
//                                     //       ),
//                                     //     ),
//                                     //   ),
//                                     // ),
//                                     if (value.isEditable)
//                                       Visibility(
//                                         visible: gradeVisible,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             const Padding(
//                                               padding: EdgeInsets.all(5.0),
//                                               child: Text(
//                                                 'Grade',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: greyColor,
//                                                 ),
//                                               ),
//                                             ),
//                                             Consumer<DropDownProvider>(
//                                               builder:
//                                                   (context, provider, child) {
//                                                 // selectedGrade = gradeList.firstWhere((element) => element.name == value.userData!['grade']).id;
//                                                 selectedGrade = provider
//                                                         .selectUpdatedGradeDropDownValue ??
//                                                     '';
//                                                 print(
//                                                     'selectedGrade: $selectedGrade');
//                                                 return AppDropDown(
//                                                   selectedValue: provider
//                                                       .selectUpdatedGradeDropDownValue,
//                                                   onChanged: (String? text) {
//                                                     setState(() {
//                                                       //This ID is for General Quiz
//                                                       if (text ==
//                                                               "IBa080KxWohb6KbgcmSG" ||
//                                                           text ==
//                                                               "LmFJFca7iNhBjQ4edje9") {
//                                                         streamVisible = true;
//                                                       } else {
//                                                         streamVisible = false;
//                                                       }
//                                                     });
//
//                                                     if (text != null) {
//                                                       provider
//                                                           .setUpdatedGradeDropDownValue(
//                                                               text);
//
//                                                       tempStreamList = level3List
//                                                           .where((element) =>
//                                                               element.level2Id
//                                                                   .toString() ==
//                                                               provider
//                                                                   .selectUpdatedGradeDropDownValue
//                                                                   .toString())
//                                                           .toList();
//                                                     }
//                                                   },
//                                                   backgroundColor: whiteColor,
//                                                   items: tempGradeList.map<
//                                                       DropdownMenuItem<
//                                                           String>>((val) {
//                                                     return DropdownMenuItem<
//                                                         String>(
//                                                       value: val.id.toString(),
//                                                       child: Text(
//                                                         val.name,
//                                                       ),
//                                                     );
//                                                   }).toList(),
//                                                 );
//                                               },
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     if (!value.isEditable)
//                                       Visibility(
//                                         visible: value.userData!['category'] ==
//                                                 "General Quiz"
//                                             ? false
//                                             : true,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             const Padding(
//                                               padding: EdgeInsets.all(5.0),
//                                               child: Text(
//                                                 'Grade',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: greyColor,
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                               width: double.infinity,
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 15,
//                                                       vertical: 18),
//                                               decoration: BoxDecoration(
//                                                 color: whiteColor,
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                               child: value.userData != null
//                                                   ? Text(
//                                                       '${value.userData!['grade']}',
//                                                       style: const TextStyle(
//                                                         color: greyColor,
//                                                       ),
//                                                     )
//                                                   : const Text(
//                                                       'grade',
//                                                       style: TextStyle(
//                                                         color: greyColor,
//                                                       ),
//                                                     ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     if (value.isEditable)
//                                       Visibility(
//                                         visible: streamVisible,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             const Padding(
//                                               padding: EdgeInsets.all(5.0),
//                                               child: Text(
//                                                 'Stream',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: greyColor,
//                                                 ),
//                                               ),
//                                             ),
//                                             Consumer<DropDownProvider>(
//                                               builder:
//                                                   (context, provider, child) {
//                                                 // selectedGrade = gradeList.firstWhere((element) => element.name == value.userData!['grade']).id;
//                                                 selectedStream = provider
//                                                         .selectUpdatedStreamSubjectDropDownValue ??
//                                                     '';
//                                                 print(
//                                                     'selectedGrade: $selectedStream');
//                                                 // print(tempStreamList);
//                                                 return AppDropDown(
//                                                   selectedValue: provider
//                                                       .selectUpdatedStreamSubjectDropDownValue,
//                                                   onChanged: (String? text) {
//                                                     if (text != null) {
//                                                       provider
//                                                           .setUpdatedStreamSubjectDropDownValue(
//                                                               text);
//                                                     }
//                                                   },
//                                                   backgroundColor: whiteColor,
//                                                   items: tempStreamList.map<
//                                                       DropdownMenuItem<
//                                                           String>>((val) {
//                                                     return DropdownMenuItem<
//                                                         String>(
//                                                       value: val.id.toString(),
//                                                       child: Text(
//                                                         val.name,
//                                                       ),
//                                                     );
//                                                   }).toList(),
//                                                 );
//                                               },
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     if (!value.isEditable)
//                                       Visibility(
//                                         visible: value.userData!['grade'] ==
//                                                     "11th" ||
//                                                 value.userData!['grade'] ==
//                                                     "12th"
//                                             ? true
//                                             : false,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             const Padding(
//                                               padding: EdgeInsets.all(5.0),
//                                               child: Text(
//                                                 'Stream',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: greyColor,
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                               width: double.infinity,
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 15,
//                                                       vertical: 18),
//                                               decoration: BoxDecoration(
//                                                 color: whiteColor,
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                               child: value.userData != null
//                                                   ? Text(
//                                                       '${value.userData!['stream']}',
//                                                       style: const TextStyle(
//                                                         color: greyColor,
//                                                       ),
//                                                     )
//                                                   : const Text(
//                                                       'Stream',
//                                                       style: TextStyle(
//                                                         color: greyColor,
//                                                       ),
//                                                     ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 40,
//                                 ),
//                                 if (value.isEditable)
//                                   Align(
//                                     alignment: Alignment.center,
//                                     child: AppTextButton(
//                                       text: 'Update',
//                                       onPressed: () {
//                                         value.updateUser(
//                                             fullName: nameController.text,
//                                             phone: phoneController.text,
//                                             email: emailController.text,
//                                             category: level1List
//                                                 .firstWhere((element) =>
//                                                     element.id.toString() ==
//                                                     selectedCategory)
//                                                 .name,
//                                             grade: selectedCategory ==
//                                                     "dasvPH3EDAcViJdarrnw"
//                                                 ? ""
//                                                 : tempGradeList
//                                                     .firstWhere((element) =>
//                                                         element.id.toString() ==
//                                                         selectedGrade)
//                                                     .name,
//                                             stream: selectedGrade ==
//                                                 "LmFJFca7iNhBjQ4edje9" || selectedGrade ==
//                                                 "IBa080KxWohb6KbgcmSG"
//                                                 ? tempStreamList
//                                                 .firstWhere((element) =>
//                                             element.id.toString() ==
//                                                 selectedStream)
//                                                 .name
//                                                 : "",
//                                             image: _image);
//                                         _showDialog();
//                                       },
//                                     ),
//                                   ),
//                               ],
//                             );
//                           }),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 0,
//                 child: Consumer<LoginProvider>(
//                   builder: (BuildContext context, LoginProvider value,
//                       Widget? child) {
//                     _image = value.pickedImage;
//                     return Stack(
//                       children: [
//                         GestureDetector(
//                           onTap: () async {
//                             if (value.isEditable) {
//                               Uint8List image =
//                                   await pickImage(ImageSource.gallery);
//                               value.setImage(image);
//                             }
//                           },
//                           child: value.userData == null
//                               ? const Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: CircleAvatar(
//                                     radius: 50,
//                                     backgroundImage: NetworkImage(
//                                         'https://images.unsplash.com/photo-1513542789411-b6a5d4f31634?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80'),
//                                   ),
//                                 )
//                               : _image != null
//                                   ? Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: CircleAvatar(
//                                         radius: 50,
//                                         backgroundImage: MemoryImage(_image!),
//                                       ),
//                                     )
//                                   : CircleAvatar(
//                                       radius: 50,
//                                       backgroundImage: value
//                                                   .userData!['imageurl'] == ""
//                                           ? const NetworkImage(
//                                               'https://images.unsplash.com/photo-1513542789411-b6a5d4f31634?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80')
//                                           : NetworkImage(
//                                               '${value.userData!['imageurl']}'),
//                                       backgroundColor: whiteColor,
//                                     ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: -5,
//                           child: InkWell(
//                             onTap: () {
//                               value.setEditableValue(!value.isEditable);
//                             },
//                             child: const Icon(
//                               Icons.edit,
//                               size: 35,
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _showDialog() {
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return Consumer<LoginProvider>(
//             builder:
//                 (BuildContext context, LoginProvider value, Widget? child) {
//               return AlertDialog(
//                 // backgroundColor: whiteColor.withOpacity(0.5),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     if (value.isLoading == true)
//                       const SizedBox(
//                         height: 50,
//                         width: 50,
//                         child: CircularProgressIndicator(
//                           color: bgColor,
//                         ),
//                       ),
//                     if (value.isLoading == false)
//                       const CircleAvatar(
//                         radius: 20,
//                         backgroundColor: greenColor,
//                         child: Icon(
//                           Icons.done_all,
//                           color: whiteColor,
//                         ),
//                       ),
//                     if (value.isLoading == false)
//                       const SizedBox(
//                         height: 15,
//                       ),
//                     if (value.isLoading == false)
//                       AppTextButton(
//                           onPressed: () {
//                             value.setEditableValue(false);
//                             Navigator.pop(context);
//                             if (value.created == true) {
//                               showToastMessage('Updated Successfully');
//                             }
//                           },
//                           text: 'Done'),
//                   ],
//                 ),
//               );
//             },
//           );
//         });
//   }
// }
