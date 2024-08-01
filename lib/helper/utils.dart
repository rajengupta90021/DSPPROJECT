import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{


  void toastmessage(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void fieldfocus(BuildContext context , FocusNode currentnode , FocusNode Nextfocus){
    currentnode.unfocus();
    FocusScope.of(context).requestFocus(Nextfocus);

  }
  static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //imported this from flush bar package
  // we will utilise this for showing errors or success messages
  static void flushBarErrorMessage(String message,Color color, BuildContext context){
    showFlushbar(context: context,
      flushbar: Flushbar(
        forwardAnimationCurve:Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,

        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: color,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(Icons.error , size: 28 , color: Colors.white,),
      )..show(context),

    );

  }


  // we will utilise this for showing errors or success messages
  static snackBar(String message, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text(message ))
    );
  }
}