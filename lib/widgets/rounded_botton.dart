import 'package:flutter/material.dart';

import '../constant/colors.dart';

class roundedbotton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const roundedbotton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: iconcolor, // Ensure iconcolor is defined in your constants
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
