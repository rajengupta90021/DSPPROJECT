import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Model/ChildMember.dart';
import '../../../../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../../../../constant/colors.dart';
import '../../../../provider/UserImageComtroller.dart';
import '../../../../repository/ChildMemberRepository.dart';
import '../../../family_member_widgets/AddFamilyMember2.dart';
import 'Report.dart';


class FamilyMemeberReport extends StatefulWidget {
  @override
  _FamilyMemeberReportState createState() => _FamilyMemeberReportState();
}

class _FamilyMemeberReportState extends State<FamilyMemeberReport> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: iconcolor,
        title: Text('Family Members',style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder<List<childmember>>(
                  future: _repository.getAllChildMembersusingFutureBuilder(userId!),
                  builder: (context ,snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No child members found'));
                    }else{
                      final childMembers = snapshot.data!;
                      return  ListView.builder(
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
                          String formattedDate = DateFormat('dd-MM-yyyy').format(createdAt);
                          bool isSelected = _selectedMember == member;
                          return GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                              height: 119,
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
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

                )
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle add new family member action
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddFamilyMember2(),
                    ),
                  );
                },
                child: Text(
                  'ADD NEW FAMILY MEMBER',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: iconcolor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyMemberItem extends StatelessWidget {
  final String name;
  final String relation;
  final String gender;
  final String dob;
  final String role;
  final String abhaId;
  final VoidCallback onTap;

  const FamilyMemberItem({
    required this.name,
    required this.relation,
    required this.gender,
    required this.dob,
    required this.role,
    required this.abhaId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOH2aZnIHWjMQj2lQUOWIL2f4Hljgab0ecZQ&usqp=CAU'), // Dummy image URL
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('$relation | $gender | $dob'),
                    SizedBox(height: 5),
                    Text(
                      role,
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('ABHA ID: $abhaId'),
                  ],
                ),
              ),
              Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}
