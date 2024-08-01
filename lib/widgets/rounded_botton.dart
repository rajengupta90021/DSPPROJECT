import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';

class roundedbotton extends StatelessWidget {

  final String title ;
  final VoidCallback onTap;
  final bool loading ;
  const roundedbotton({super.key,required this.title,required this.onTap, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: iconcolor,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: loading ? CircularProgressIndicator(strokeWidth: 3,color: Colors.black,) :
        Text(title, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),),
      ),
    );
  }
}






