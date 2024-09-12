import 'package:flutter/material.dart';

import '../Model/ChildMember.dart';

class SelectedMemberProvider extends ChangeNotifier {
  String? _name;
  String? _email;
  String? _phone;
  String? _relation;
  String? _dob;  // New field for Date of Birth
  String? _gender;  // New field for Gender

  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get relation => _relation;
  String? get dob => _dob;
  String? get gender => _gender;

  void updateMemberDetails({
    String? name,
    String? email,
    String? phone,
    String? relation,
    String? dob,  // New parameter for Date of Birth
    String? gender,  // New parameter for Gender
  }) {
    _name = name;
    _email = email;
    _phone = phone;
    _relation = relation;
    _dob = dob;
    _gender = gender;
    notifyListeners();
  }
  // Method to clear member details on logout
  void logout() {
    _name = null;
    _email = null;
    _phone = null;
    _relation = null;
    _dob = null;
    _gender = null;
    notifyListeners();
  }
}
