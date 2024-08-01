import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dspuiproject/services/home_page2.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../provider/controller/ForgotpasswordController.dart';
import '../../services/BottomNavigationfooter/NavigationMenu.dart';
import '../../helper/utils.dart';
import '../../widgets/rounded_botton.dart';

import 'login_withphone_number.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final  emailcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  final _auth= FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Forgot Password",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true, // Center the title
          leading: IconButton( // Add back button
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/login.png',
                  width: 150,
                  height: 150,
                ),
                Text(
                  "enter your email to recover your password ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller:  emailcontroller,
                        decoration: InputDecoration(
                          hintText: "email ",
                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "enter email ";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20,),


                    ],
                  ),
                ),


                SizedBox(height: 10,),
                ChangeNotifierProvider(
                  create: (_) => ForgotPasswordController(),
                  child: Consumer<ForgotPasswordController>(
                    builder: (context, provider, child) {
                      return roundedbotton(
                        title: "recover ",
                        loading: provider.loading,
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            provider.forgot(context, emailcontroller.text,);
                          }
                        },
                      );
                    },
                  ),
                ),

                SizedBox(height: 50,),

                SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
