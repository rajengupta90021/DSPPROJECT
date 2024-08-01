import 'package:dspuiproject/Model/UserInfo.dart';
import 'package:dspuiproject/services/home_page2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../provider/controller/SignUpcontroller.dart';
import '../../repository/AuthRepository.dart';
import '../../services/BottomNavigationfooter/NavigationMenu.dart';
import '../../helper/utils.dart';
import '../../widgets/rounded_botton.dart';

import 'login_screen.dart';

class signupscreen extends StatefulWidget {
  const signupscreen({super.key});

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {

  final  usernamecontroller = TextEditingController();
  final  emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  bool loading = false;

  List<UserData> userdata= [];


  FirebaseAuth _auth= FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  // void signup(){
  //
  //   _auth.createUserWithEmailAndPassword(email: emailcontroller.text.toString(),
  //       password: passwordcontroller.text.toString()).then((value)
  //   {
  //     // Utils().toastmessage(value.toString(),Colors.red);
  //     Utils().toastmessage("signup succesfully Welcome you !!",Colors.green);
  //     setState(() {
  //       loading= false;
  //     });
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationMenu()));
  //
  //   }).onError((error, stackTrace){
  //
  //     Utils().toastmessage(error.toString(),Colors.red);
  //     print(error.toString());
  //
  //     setState(() {
  //       loading= false;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(

        title: Text("sign up screen screen"),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ChangeNotifierProvider(
          create: (_)=>SignUpController(),
          child:Consumer<SignUpController>(
            builder: (context, provider ,child){
              return SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Image.asset(
                        'assets/login.png',
                        width: 150, // Adjust the width as needed
                        height: 150, // Adjust the height as needed
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: formkey,
                      child: Column(
                        children: [

                          TextFormField(

                            keyboardType: TextInputType.emailAddress,
                            controller:  usernamecontroller,
                            decoration: InputDecoration(
                                hintText: "username ",

                                prefixIcon: Icon(Icons.supervised_user_circle)
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "enter username ";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20,),
                          // TextFormField(
                          //
                          //   keyboardType: TextInputType.emailAddress,
                          //   controller:  emailcontroller,
                          //   decoration: InputDecoration(
                          //       hintText: "email ",
                          //
                          //       prefixIcon: Icon(Icons.alternate_email)
                          //   ),
                          //   validator: (value){
                          //     if(value!.isEmpty){
                          //       return "enter email ";
                          //     }
                          //     return null;
                          //   },
                          // ),
                          TextFormField(
                            controller: emailcontroller,
                            decoration: InputDecoration(

                              labelText: 'email',
                                prefixIcon: Icon(Icons.alternate_email)
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter an email address";
                              }

                              // Regular expression to validate email format
                              RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                              if (!emailRegex.hasMatch(value)) {
                                return "Please enter a valid email address";
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

                                hintText: "paswword ",

                                prefixIcon: Icon(Icons.password_rounded)
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "enter password ";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 50,),

                        ],
                      ),
                    ),

                    roundedbotton(title: "sign up ",
                      loading: provider.loading,
                      onTap: () async {

                        if(formkey.currentState!.validate()){

                          setState(() {
                            loading= true;
                          });
                          var userData = {
                            'name': usernamecontroller.text.toString(),
                            'email': emailcontroller.text.toString(),
                            'password': passwordcontroller.text.toString(),
                            'mobile': '9999999999', // You can add user mobile number here if needed
                            // 'role': '', // Assuming default role is 'User'
                          };
                          provider.signUpAndCreateUserOnAPI(context,userData);


                          // provider.signup(context,usernamecontroller.text, emailcontroller.text, passwordcontroller.text);
                        }

                      },),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("already  have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>loginscreen()));

                            // Add your navigation logic here
                          },
                          child: Text("login "),
                        ),
                      ],
                    )

                  ],
                ),
              );
            },
          ) ,
        ),
      ),
    );
  }
}
