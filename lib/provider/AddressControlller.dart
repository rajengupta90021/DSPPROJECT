import 'package:flutter/foundation.dart';

class AddressProvider with ChangeNotifier {
  String _address = '';
  String _houseNo = '';
  String _phoneNo = '';
  String _pinCode = '';
  String _cityName = '';
  String _stateName = '';
  String _locality = '';

  // Getters
  String get address => _address;
  String get houseNo => _houseNo;
  String get phoneNo => _phoneNo;
  String get pinCode => _pinCode;
  String get cityName => _cityName;
  String get stateName => _stateName;
  String get locality => _locality;

  // Setters
  void setAddress(String address) {
    _address = address;
    notifyListeners();
  }

  void setHouseNo(String houseNo) {
    _houseNo = houseNo;
    notifyListeners();
  }

  void setPhoneNo(String phoneNo) {
    _phoneNo = phoneNo;
    notifyListeners();
  }

  void setPinCode(String pinCode) {
    _pinCode = pinCode;
    notifyListeners();
  }

  void setCityName(String cityName) {
    _cityName = cityName;
    notifyListeners();
  }

  void setStateName(String stateName) {
    _stateName = stateName;
    notifyListeners();
  }

  void setLocality(String locality) {
    _locality = locality;
    notifyListeners();
  }
}
