import 'dart:convert';
import 'dart:io';

import 'package:dspuiproject/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/ChildMember.dart';
import '../../Model/UserProfileImage.dart';
import '../../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../../provider/UserImageComtroller.dart';
import '../../repository/ChildMemberRepository.dart';
import '../family_member_widgets/EditFamilyMemeber.dart';
import 'UserProfileEditPage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;



class Userprofile extends StatefulWidget {
  final String username;
  final String email;
  final String mobile;
  final String profileimg;
  final String dob;
  final String gender;

  const Userprofile( {
    required this.username,
    required this.email,
    required this.mobile,
    required this.profileimg,
    required this.dob,
    required this.gender,
    Key? key,
  }) : super(key: key);

  @override
  _UserprofileState createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  final ChildMemberRepository _repository = ChildMemberRepository();
  final SharedPreferencesService _sharedPreferencesService =
  SharedPreferencesService();
  String? userId;
  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    userId = await _sharedPreferencesService.getUserId();
    setState(() {}); // Update the UI with the retrieved userId
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 29),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: iconcolor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              height: 310,
              decoration: BoxDecoration(
                color: iconcolor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                 Consumer<UserImageController>(
                     builder: (context,imagecontroller,child){
                       return  Stack(
                         children: [
                           InkWell(
                             onTap: (){

                               imagecontroller.idnameemail(userId!, widget.username, widget.email);
                               imagecontroller.pickiamge(context);
                             },

                             child: CircleAvatar(
                               backgroundImage: imagecontroller.imageUrl != null && imagecontroller.imageUrl!.isNotEmpty
                                   ? NetworkImage(imagecontroller.imageUrl!)
                                   : NetworkImage(widget.profileimg),
                               radius: 50,
                             ),
                           ),
                           if (imagecontroller.isLoading)
                             Positioned.fill(
                               child: Center(
                                 child: Container(
                                   decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                     color: Colors.black.withOpacity(0.5),
                                   ),
                                   child: Padding(
                                     padding: const EdgeInsets.all(12.0), // Adjust padding as needed
                                     child: CircularProgressIndicator(
                                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                           Positioned(
                             bottom: 0.0,
                             right: 0.0,
                             child: Container(
                               padding: EdgeInsets.all(4),
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: Colors.white,
                               ),
                               child: Icon(Icons.edit, color: Colors.purpleAccent),
                             ),
                           )
                         ],
                       );
                     }

                 ),

                  SizedBox(height: 10),
                  Text(
                    "${widget.username}",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.list_alt_rounded),
                            onPressed: () {
                              // Handle report action
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Report',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return FractionallySizedBox(
                                    heightFactor: 0.99,
                                    child: UserProflieEditPage(
                                      username: widget.username,
                                      email: widget.email,
                                      mobile: widget.mobile,
                                      profileimg: widget.profileimg,
                                      dob: widget.dob,
                                      gender: widget.gender,
                                    ),
                                  );
                                },
                              );
                              // Handle edit action
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Edit',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Family Members",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            StreamBuilder<List<childmember>>(
              stream: userId == null ? Stream.empty() : _repository.getAllChildMembers(userId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No child members found'));
                } else {
                  List<childmember> childMembers = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: childMembers.length,
                    itemBuilder: (context, index) {
                      childmember member = childMembers[index];

                      DateTime? createdAt;
                      try {
                        createdAt = DateTime.parse(member.data?.createdAt ?? '');
                      } catch (e) {
                        createdAt = DateTime.now(); // Default value if parsing fails
                      }

                      // Format createdAt DateTime to string
                      String formattedDate = DateFormat('dd-MM-yyyy').format(createdAt);

                      return Container(
                        height: 115,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: Card(
                          elevation: 2,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbMWwCck2JKqm9H8t53puxSlKZ9mi2SuVdEEk48k6LtA&s',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        member.data!.name!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text("${member.data?.relation} ${formattedDate}"),
                                      SizedBox(height: 2),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.purple,
                                        ),
                                        child: Text(
                                          "Regular",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text('ABHA Id: Not available'),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: IconButton(
                                    color: Colors.black,
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      print('Name: ${member.data?.parentId}');
                                      print('name: ${member.data?.name}');
                                      print('email: ${member.data?.email}');
                                      print('moblie: ${member.data?.mobile}');
                                      print('relation: ${member.data?.relation}');
                                      print('address: ${member.data?.address}');
                                      print('child id : ${member.id}');
                                      print('child id : ${member.data?.dob}');
                                      print('child id : ${member.data?.gender}');

                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditFamilyMemeber(
                                        parentId: member.data?.parentId ?? '',
                                        username: member.data?.name ?? '',
                                        email: member.data?.email ?? '',
                                        mobile: member.data?.mobile ?? '',
                                        relation: member.data?.relation ?? '',
                                        address: member.data?.address ?? '',
                                        id: member.id ?? '',
                                        dob: member.data?.dob ?? '', // Pass dob
                                        gender: member.data?.gender ?? '', // Pass gender
                                      )));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
