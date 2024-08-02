import 'package:dspuiproject/services/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dspuiproject/services/home_page2.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../provider/controller/loginController.dart';
import '../../services/BottomNavigationfooter/NavigationMenu.dart';
import '../../helper/utils.dart';
import '../../widgets/rounded_botton.dart';
import 'forgot_password.dart';
import 'login_withphone_number.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {

  final  emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  final _auth= FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Login",
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
                            Utils.flushBarErrorMessage("enter email ",Colors.red, context);

                            return "enter email ";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller:  passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "password ",
                          prefixIcon: Icon(Icons.password_rounded),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            Utils.flushBarErrorMessage("enter passwword ",Colors.red, context);

                            return "enter password ";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: (){

                        print("tab");
                        Fluttertoast.showToast(
                          msg: "We are working on this",
                          toastLength: Toast.LENGTH_SHORT, // You can use Toast.LENGTH_LONG for a longer duration
                          gravity: ToastGravity.BOTTOM, // You can adjust the position if needed
                          timeInSecForIosWeb: 1, // iOS web duration
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                      },
                      child: Text('forgot password',style: TextStyle(fontSize: 15,decoration: TextDecoration.underline),)),

                ),
                SizedBox(height: 10,),
                ChangeNotifierProvider(
                  create: (_) => LoginController(),
                  child: Consumer<LoginController>(
                    builder: (context, provider, child) {
                      return roundedbotton(
                        title: "login ",
                        loading: provider.loading,
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            // provider.login(context, emailcontroller.text, passwordcontroller.text.toString());
                            provider.loginWithApi(context, emailcontroller.text, passwordcontroller.text.toString());
                          }
                        },
                      );
                    },
                  ),
                ),

                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>signupscreen()),
                        );
                      },
                      child: Text("Sign Up"),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: (){
                    Fluttertoast.showToast(
                      msg: "We are working on this",
                      toastLength: Toast.LENGTH_SHORT, // You can use Toast.LENGTH_LONG for a longer duration
                      gravity: ToastGravity.BOTTOM, // You can adjust the position if needed
                      timeInSecForIosWeb: 1, // iOS web duration
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>loginwithphonenumber()));

                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                      child: Text("Login With Phone Number "),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
