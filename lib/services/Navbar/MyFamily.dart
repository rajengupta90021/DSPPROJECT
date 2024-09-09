import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Model/ChildMember.dart';
import '../../../../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../../../../constant/colors.dart';
import '../../../../repository/ChildMemberRepository.dart';
import '../../widgets/ShimmerEffect.dart';
import '../family_member_widgets/AddFamilyMember2.dart';

class MyFamily extends StatefulWidget {
  @override
  _MyFamilyState createState() => _MyFamilyState();
}

class _MyFamilyState extends State<MyFamily> {
  final ChildMemberRepository _repository = ChildMemberRepository();
  late Future<List<childmember>> _futureMembers;
  String? userId;

  @override
  void initState() {
    super.initState();
    _futureMembers = Future.value([]); // Initialize with an empty future
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    userId = await SharedPreferencesService().getUserId();
    if (userId != null) {
      setState(() {
        _futureMembers = _repository.getAllChildMembersusingFutureBuilder(userId!);
      });
    } else {
      setState(() {
        _futureMembers = Future.value([]);
      });
    }
  }

  void _refreshData() {
    if (userId != null) {
      setState(() {
        _futureMembers = _repository.getAllChildMembersusingFutureBuilder(userId!);
      });
    } else {
      setState(() {
        _futureMembers = Future.value([]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: iconcolor,
        title: Text(
          'Family Members',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<childmember>>(
                future: _futureMembers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: ShimmerCategoryListWidget());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 100,
                              color: Colors.grey.shade400,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No family Members Found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'It looks like you don\'t have any family members added yet.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddFamilyMember2(),
                                  ),
                                );
                                _refreshData(); // Refresh data after adding a member
                              },
                              child: Text('Add Member'),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    final childMembers = snapshot.data!;
                    return ListView.builder(
                      itemCount: childMembers.length,
                      itemBuilder: (context, index) {
                        final member = childMembers[index];
                        final createdAt = member.data?.createdAt != null
                            ? DateTime.tryParse(member.data!.createdAt!) ?? DateTime.now()
                            : DateTime.now();
                        final formattedDate = DateFormat('dd-MM-yyyy').format(createdAt);

                        return GestureDetector(
                          onTap: () {
                            // Handle tap here
                          },
                          child: Container(
                            height: 119,
                            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.orange.withOpacity(0.1),
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
                                            member.data?.name ?? 'Name not available',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text("${member.data?.relation ?? ''} ${formattedDate}"),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
