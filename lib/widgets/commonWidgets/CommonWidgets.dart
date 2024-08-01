import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/colors.dart';
import '../../provider/ProviderData.dart';


class CustomCardforprofile extends StatelessWidget {
  final String name;
  final String details;

  const CustomCardforprofile({Key? key, required this.name, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.blue, width: 1),
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
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbMWwCck2JKqm9H8t53puxSlKZ9mi2SuVdEEk48k6LtA&s"),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(details),
                    SizedBox(height: 2),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: navyBlueColor,
                      ),
                      child: Text(
                        'Regular',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text('ABHA Id: Not Available'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Handle edit action
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// class CustomCardforfamilymember extends StatefulWidget {
//   final String name;
//   final String details;
//
//   const CustomCardforfamilymember({Key? key, required this.name, required this.details}) : super(key: key);
//
//   @override
//   _CustomCardforfamilymemberState createState() => _CustomCardforfamilymemberState();
// }

// class _CustomCardforfamilymemberState extends State<CustomCardforfamilymember> {
//   bool isFavorite = false;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           isFavorite = !isFavorite;
//           print('Name: ${widget.name}, Details: ${widget.details}, isFavorite: $isFavorite');
//         });
//       },
//       child: Container(
//         height: 120,
//         child: Card(
//           elevation: 3,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//             side: BorderSide(color: Colors.blue, width: 1),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: CircleAvatar(
//                     radius: 30,
//                     backgroundImage: NetworkImage(
//                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbMWwCck2JKqm9H8t53puxSlKZ9mi2SuVdEEk48k6LtA&s"),
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.name,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                       SizedBox(height: 2),
//                       Text(widget.details),
//                       SizedBox(height: 2),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: navyBlueColor,
//                         ),
//                         child: Text(
//                           'Regular',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 2),
//                       Text('ABHA Id: Not Available'),
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       isFavorite = !isFavorite;
//                       print('Favourite button pressed: ${widget.name}, isFavorite: $isFavorite');
//                     });
//                   },
//                   icon: Icon(
//                     isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: isFavorite ? Colors.black : Colors.blue,
//                     size: 30,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
