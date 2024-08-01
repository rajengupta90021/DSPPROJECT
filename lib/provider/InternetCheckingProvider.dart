import 'package:flutter/cupertino.dart';

class InternetChickingProvider with ChangeNotifier{


  bool _isConnected = false;

  bool get isConnected => _isConnected;

  void updateConnectionStatus(bool isConnected) {
    _isConnected = isConnected;
    notifyListeners();
  }
}