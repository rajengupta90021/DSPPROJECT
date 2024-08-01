import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCategoryListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Adjust based on your design needs
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: Container(
              width: 48.0,
              height: 48.0,
              color: Colors.white, // Adjust container color as per your design
            ),
            title: Container(
              height: 16.0,
              color: Colors.white, // Adjust container color as per your design
            ),
          ),
        );
      },
    );
  }
}
