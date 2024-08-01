// import 'package:flutter/material.dart';
// import '../Model/ChildMemeberWithParent.dart';
// import '../repository/ChildMemberRepositoryWithParent.dart';
//
// class ChildMemberScreen extends StatefulWidget {
//   @override
//   _ChildMemberScreenState createState() => _ChildMemberScreenState();
// }
//
// class _ChildMemberScreenState extends State<ChildMemberScreen> {
//   late final ChildMemberRepositoryWithParent _repository;
//   String? _selectedChildId; // Track selected child ID
//   bool _isParentSelected = false; // Track if parent is selected
//
//   @override
//   void initState() {
//     super.initState();
//     _repository = ChildMemberRepositoryWithParent();
//   }
//
//   void _selectParent() {
//     setState(() {
//       _isParentSelected = !_isParentSelected; // Toggle parent selection
//       if (_isParentSelected) {
//         _selectedChildId = null; // Deselect child if parent is selected
//       }
//     });
//   }
//
//   void _selectChild(String childId) {
//     setState(() {
//       _selectedChildId = _selectedChildId == childId ? null : childId;
//       _isParentSelected = false; // Deselect parent if child is selected
//     });
//   }
//
//   void _showProceedDialog(List<childmemberWithParent> childMembers) {
//     final allChildren = childMembers.expand((member) => member.child ?? []).toList();
//     final parent = childMembers.isNotEmpty ? childMembers.first.parent : null;
//
//     if (_selectedChildId == null && !_isParentSelected) {
//       // If neither is selected, select parent by default
//       _selectParent(); // Automatically select parent if nothing is selected
//     }
//
//     final content = _selectedChildId != null
//         ? 'Selected Child Details:\nName: ${allChildren.firstWhere((child) => child.id == _selectedChildId).data?.name ?? 'No Name'}\nEmail: ${allChildren.firstWhere((child) => child.id == _selectedChildId).data?.email ?? 'No Email'}\nMobile: ${allChildren.firstWhere((child) => child.id == _selectedChildId).data?.mobile ?? 'No Mobile'}\nRelation: ${allChildren.firstWhere((child) => child.id == _selectedChildId).data?.relation ?? 'No Relation'}'
//         : parent != null
//         ? 'Would you like to proceed with ${parent.data?.name ?? 'No Name'}?\nEmail: ${parent.data?.email ?? 'No Email'}\nMobile: ${parent.data?.mobile ?? 'No Mobile'}'
//         : 'Loading parent details...';
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(_selectedChildId != null ? 'Child Selected' : 'Confirm Parent'),
//         content: Text(content),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               // Handle the proceed action
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Proceeding...'),
//                 ),
//               );
//             },
//             child: Text('Proceed'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Child Members'),
//       ),
//       body: StreamBuilder<List<childmemberWithParent>>(
//         stream: _repository.getAllChildMembers("UtlJZZ6ZKMGJNoyVlBqn"),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No data available'));
//           }
//
//           final childMembers = snapshot.data!;
//           final allChildren = childMembers.expand((member) => member.child ?? []).toList();
//           final parent = childMembers.isNotEmpty ? childMembers.first.parent : null;
//
//           return Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: allChildren.length + 1, // Add one for the parent details
//                   itemBuilder: (context, index) {
//                     if (index == 0) {
//                       // Parent Details Row
//                       return GestureDetector(
//                         onTap: _selectParent,
//                         child: Container(
//                           padding: EdgeInsets.all(16.0),
//                           margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//                           decoration: BoxDecoration(
//                             color: _isParentSelected
//                                 ? Colors.blue.withOpacity(0.1) // Background color for selected parent
//                                 : Colors.blueAccent.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(8.0),
//                             border: Border.all(color: Colors.blueAccent, width: 2),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Parent Details',
//                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                               ),
//                               SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   CircleAvatar(
//                                     backgroundColor: Colors.grey[300],
//                                     child: Text(
//                                       parent?.data?.name?.substring(0, 1) ?? 'A', // Placeholder for Parent's Profile Picture or Initial
//                                       style: TextStyle(color: Colors.black),
//                                     ),
//                                     radius: 30,
//                                   ),
//                                   SizedBox(width: 16.0),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           parent?.data?.name ?? 'No Name',
//                                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                                         ),
//                                         SizedBox(height: 4),
//                                         Text('Email: ${parent?.data?.email ?? 'No Email'}'),
//                                         Text('Mobile: ${parent?.data?.mobile ?? 'No Mobile'}'),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     } else {
//                       // Child Details Row
//                       final child = allChildren[index - 1]; // Adjust index for child data
//                       final childData = child.data;
//
//                       return GestureDetector(
//                         onTap: () {
//                           _selectChild(child.id); // Select child and deselect parent
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: _selectedChildId == child.id
//                                   ? Colors.blue // Highlight color for the selected item
//                                   : Colors.transparent,
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(4),
//                             color: _selectedChildId == child.id
//                                 ? Colors.blue.withOpacity(0.1) // Background color for the selected item
//                                 : Colors.transparent,
//                           ),
//                           padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                           margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
//                           child: Row(
//                             children: [
//                               childData?.profileImg != null
//                                   ? CircleAvatar(
//                                 backgroundImage: NetworkImage(childData!.profileImg!),
//                                 radius: 20,
//                               )
//                                   : CircleAvatar(child: Icon(Icons.person)),
//                               SizedBox(width: 16.0),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       childData?.name ?? 'No Name',
//                                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text('Email: ${childData?.email ?? 'No Email'}'),
//                                     Text('Mobile: ${childData?.mobile ?? 'No Mobile'}'),
//                                     Text('Relation: ${childData?.relation ?? 'No Relation'}'),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   onPressed: () => _showProceedDialog(childMembers),
//                   child: Text('Proceed'),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
