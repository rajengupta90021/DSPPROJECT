import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;

  const LoadingOverlay({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(0.3), // Semi-transparent background
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    )
        : SizedBox.shrink(); // Returns an empty widget when not loading
  }
}
