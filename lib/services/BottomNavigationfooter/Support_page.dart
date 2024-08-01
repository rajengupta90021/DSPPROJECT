import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../SharedPreferecneService/SharedPreferenceSerivice.dart';
import '../../constant/colors.dart';
import '../auth/login_screen.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    _isLoggedIn = await _sharedPreferencesService.isUserLoggedIn();
    setState(() {
      // Update UI based on login status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('DSP Support')),
        backgroundColor: iconcolor,
        elevation: 0,
      ),
      body: _isLoggedIn ? _buildTawkWidget() : _buildLoginPrompt(),
    );
  }

  Widget _buildTawkWidget() {
    return Tawk(
      directChatLink: 'https://tawk.to/chat/66530df09a809f19fb35477a/1huq6stps',
      visitor: TawkVisitor(
        name: 'Anonymous',
        email: 'example@example.com',
      ),
      onLoad: () {
        print('Hello Tawk!');
      },
      onLinkTap: (String url) {
        print(url);
      },
      placeholder: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildLoginPrompt() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            'Please log in to access support',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => loginscreen()));
          },
          child: const Text(
            'Log In',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: browncolor2, // Adjust the button color
            minimumSize: const Size(100, 50), // Adjust the button size
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Adjust the button border radius
            ),
          ),
        ),
      ],
    );
  }
}
