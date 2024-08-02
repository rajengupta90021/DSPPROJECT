import 'package:dspuiproject/provider/SelectedMemberProvider.dart';
import 'package:dspuiproject/services/Payment/BookingDate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/ChildMember.dart';
import '../../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../../constant/colors.dart';
import '../../provider/UserImageComtroller.dart';
import '../../repository/ChildMemberRepository.dart';
import '../Payment/SelectAnAdress.dart';
import 'AddFamilyMember2.dart';

class SelectFamilyMember extends StatefulWidget {
  @override
  _SelectFamilyMemeberState createState() => _SelectFamilyMemeberState();
}

class _SelectFamilyMemeberState extends State<SelectFamilyMember> {
  String selectedMember = '';
  childmember? memberSelected;
  final ChildMemberRepository _repository = ChildMemberRepository();
  String? userId;
  late String? _username;
  late String? _email;
  late String? _password;
  late String? _mobile;
  late String? _profileImg;
  late String? _role;
  late String? _createdAt;
  late String? _updatedAt;
  bool isLoggedIn = false;
  bool _isSelected = false;
  final SharedPreferencesService _sharedPreferencesService =
  SharedPreferencesService();

  @override
  void initState() {
    super.initState();
    _loadUserId();

    _loadUsername();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Replace 'user_name' with your actual key
    bool loggedIn = await _sharedPreferencesService.isUserLoggedIn();

    setState(() {
      isLoggedIn = loggedIn;
      userId = prefs.getString('user_id') ?? '';
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

  Future<void> _loadUserId() async {
    userId = await _sharedPreferencesService.getUserId();
    setState(() {}); // Update the UI with the retrieved userId
  }
  childmember? _selectedMember;
  void _handleSelection(childmember member) {
    setState(() {
      _selectedMember = _selectedMember == member ? null : member; // Toggle selection
    });
  }
  @override
  Widget build(BuildContext context) {

    var memberProvider = Provider.of<SelectedMemberProvider>(context, listen: false);

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.all(10.0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(8.0),

                child: IconButton(
                  icon: Icon(Icons.close_rounded, size: 30),
                  onPressed: () {

                    Navigator.of(context).pop();

                  },
                ),
              ),
            ],
          ),
          Transform.translate(
            offset: Offset(0, -50),
            child: Image.asset(
              'assets/familymember.png',
              width: 120,
              height: 120,
            ),
          ),
          Transform.translate(
            offset: Offset(0, -50),
            child: Column(
              children: [
                Text(
                  'Family Member',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black, decoration: TextDecoration.none,),
                ),
                SizedBox(height: 10),
                Text(
                  'Select your family member',
                  style: TextStyle(fontSize: 16.0, color: Colors.black, decoration: TextDecoration.none,),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder<List<childmember>>(
                future: _repository.getAllChildMembersusingFutureBuilder(userId!),
                builder: (context, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return Center(child: CircularProgressIndicator());
                  // }
                  // else
                    if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {

                      return  Expanded(

                        child: SingleChildScrollView(

                          child: Container(
                            height: 119,
                            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:  Colors.orange , // Border color changes when selected
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              color:  Colors.orange.withOpacity(0.1) ,
                            ),

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
                                      child: Consumer<UserImageController>(
            
                                          builder: (context ,imagecontorller,child){
                                            return CircleAvatar(
                                              backgroundColor: Colors.transparent,
                                              radius: 30,
                                              backgroundImage: imagecontorller.imageUrl != null && imagecontorller.imageUrl!.isNotEmpty
                                                  ? NetworkImage(imagecontorller.imageUrl!)
                                                  : NetworkImage(_profileImg!),
                                            );
                                          }
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _username ?? 'Username',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(_createdAt ?? 'Email not available'),
                                          SizedBox(height: 2),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.green,
                                            ),
                                            child: Text(
                                              "SELF",
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
                                    // Radio button
            
            
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
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
                        bool isSelected = _selectedMember == member;
                        return GestureDetector(
                          onTap: () {
            
                            setState(() {
                              selectedMember = member.data!.name!;
                              memberSelected = member;
                              print('Selected Member: $selectedMember');
                            });
                          },
                          child: Container(
                            height: 119,
                            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedMember == member.data!.name! ? iconcolor! : Colors.orange,
                                width: selectedMember == member.data!.name! ? 3 : 1, // Wider border for selected card

                              ),
                              borderRadius: BorderRadius.circular(20),
                              color:  Colors.orange.withOpacity(0.1) ,
                            ),
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
                                    if (selectedMember == member.data!.name!)
                                      Icon(Icons.check_circle, color: iconcolor, size: 30),
            
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddFamilyMember2()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(iconcolor),
                ),
                child: Text(
                  'Add Family Member',
                  style: TextStyle(color: Colors.black, fontSize: 19),
                ),
              ),
              ElevatedButton(

                onPressed: () async {
                  if (memberSelected == null && _username != null) {
                    // Store parent details in provider
                    memberProvider.updateMemberDetails(
                      name: _username,
                      email: _email,
                      phone: _mobile,
                      relation: 'SELF',
                    );
                    await    _showAlertDialog(context,
                        name: _username,
                        email: _email,
                        phone: _mobile,
                        relation: 'SELF'
                    );
                    print("No child selected. Defaulting to parent: $_username");
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingDate()));
                  } else if (memberSelected != null) {
                    // Store selected member details in provider
                    memberProvider.updateMemberDetails(
                      name: memberSelected!.data?.name,
                      email: memberSelected!.data?.email,
                      phone: memberSelected!.data?.mobile, // Ensure this field is available in `childmember`
                      relation: memberSelected!.data?.relation,
                    );
                    await    _showAlertDialog(context,
                        name: memberSelected!.data?.name,
                        email: memberSelected!.data?.email,
                        phone: memberSelected!.data?.mobile,
                        relation: memberSelected!.data?.relation
                    );
                    print("Selected Member: ${memberSelected!.data?.name ?? 'No Name'}");
                    print("Selected Member: ${memberSelected!.data?.relation ?? 'No Name'}");
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingDate()));
                  } else {
                    print("Please select a family member.");
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(iconcolor),
                ),
                child: Text(
                  'Proceed',
                  style: TextStyle(color: Colors.black, fontSize: 19),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Future<void> _showAlertDialog(
      BuildContext context, {
        String? name,
        String? email,
        String? phone,
        String? relation,
      }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Row(
            children: [
              Icon(Icons.info_outline, color: iconcolor, size: 24),
              SizedBox(width: 8),
              Text('Member Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                Text(name ?? 'Not Provided', style: TextStyle(color: Colors.grey[800])),
                SizedBox(height: 8),
                Text('Email:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                Text(email ?? 'Not Provided', style: TextStyle(color: Colors.grey[800])),
                SizedBox(height: 8),
                Text('Phone:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                Text(phone ?? 'Not Provided', style: TextStyle(color: Colors.grey[800])),
                SizedBox(height: 8),
                Text('Relation:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                Text(relation ?? 'Not Provided', style: TextStyle(color: Colors.grey[800])),
              ],
            ),
          ),
          actions: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text('Cancel', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the alert dialog
                  },
                ),
                ElevatedButton(
                  child: Text('Proceed'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: iconcolor, // Text color
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the alert dialog
                    // Trigger navigation to BookingDate after dialog is dismissed
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BookingDate()));
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _simulateDelay() async {
    await Future.delayed(Duration(seconds: 3)); // 3-second delay
  }
}
