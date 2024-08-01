import 'package:flutter/material.dart';

import '../Model/ChildMember.dart';

class SelectedMemberProvider extends ChangeNotifier {
  String? _name;
  String? _email;
  String? _phone;
  String? _relation;

  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get relation => _relation;

  void updateMemberDetails({
    String? name,
    String? email,
    String? phone,
    String? relation,
  }) {
    _name = name;
    _email = email;
    _phone = phone;
    _relation = relation;
    notifyListeners();
  }
}
