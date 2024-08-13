import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/UserInfo.dart';
import '../data/app_exception.dart';
import '../repository/AuthRepository.dart';

class Testingpage extends StatefulWidget {
  @override
  _TestingpageState createState() => _TestingpageState();
}

class _TestingpageState extends State<Testingpage> {
  final TextEditingController _phoneController = TextEditingController();
  UserData? _userData;
  String? _errorMessage;
  final UserRepository _userRepository = UserRepository();

  Future<void> _loginWithPhoneNumber() async {
    final phoneno = _phoneController.text.trim();

    if (phoneno.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a phone number';
      });
      return;
    }

    setState(() {
      _userData = null;
      _errorMessage = null;
    });

    try {
      final userData = await _userRepository.loginwithphoneNumber(phoneno);
      setState(() {
        _userData = userData;
      });
    } on NoInternetException catch (e) {
      setState(() {
        _errorMessage = e as String?;
      });
    } on FetchDataException catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loginWithPhoneNumber,
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            if (_userData != null) ...[
              Text('Name: ${_userData?.data?.name}'),
              Text('id: ${_userData?.id}'),
            ],
            if (_errorMessage != null)
              Text(_errorMessage!, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}