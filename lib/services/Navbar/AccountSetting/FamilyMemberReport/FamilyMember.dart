import 'package:flutter/material.dart';
import '../../../../constant/colors.dart';
import '../../../family_member_widgets/AddFamilyMember2.dart';
import 'Report.dart';


class FamilyMemeberReport extends StatefulWidget {
  @override
  _FamilyMemeberReportState createState() => _FamilyMemeberReportState();
}

class _FamilyMemeberReportState extends State<FamilyMemeberReport> {
  final List<Map<String, String>> familyMembers = [
    {
      'name': 'testing',
      'relation': 'Son',
      'gender': 'Male',
      'dob': '16-05-2024',
      'role': 'Regular',
      'abhaId': 'Not Available'
    },
    {
      'name': 'Adarsh',
      'relation': 'Father',
      'gender': 'Male',
      'dob': '15-05-1999',
      'role': 'Regular',
      'abhaId': 'Not Available'
    },
    {
      'name': 'Rajen',
      'relation': 'Self',
      'gender': 'Male',
      'dob': '15-05-2000',
      'role': 'Regular',
      'abhaId': 'Not Available'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Members'),
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
              child: ListView.builder(
                itemCount: familyMembers.length,
                itemBuilder: (context, index) {
                  return FamilyMemberItem(
                    name: familyMembers[index]['name']!,
                    relation: familyMembers[index]['relation']!,
                    gender: familyMembers[index]['gender']!,
                    dob: familyMembers[index]['dob']!,
                    role: familyMembers[index]['role']!,
                    abhaId: familyMembers[index]['abhaId']!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoReportsPage(
                            name: familyMembers[index]['name']!,
                          ),
                        ),
                      );
                    },
                  );
                },
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
