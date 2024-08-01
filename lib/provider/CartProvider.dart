import 'dart:io';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dspuiproject/Model/TestInformation.dart';
import 'package:dspuiproject/dbHelper/DbHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/utils.dart';
import '../repository/CategoryListRepository.dart';
import '../repository/SingleCategroyTestRepository.dart';
import '../repository/TestInformationRepository.dart';

class CartProvider with ChangeNotifier{

  List<String> addIdValue = [];
  DbHelper db = DbHelper() ;
  int _counter = 0;
  int get counter => _counter;

  bool _isNavigating = false;

  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  late Future<List<TestCart>> _cart ;
  Future<List<TestCart>> get cartt => _cart ;

  Future<List<TestCart>> getData () async {
     _cart =  db.getCartList();
    return _cart;
  }
  CartProvider() {
    // Initialize CartProvider and load addIdValue from SharedPreferences
    _loadAddIdValue();
  }

  Future<void> _loadAddIdValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    addIdValue = prefs.getStringList('addIdValue') ?? []; // Load addIdValue from SharedPreferences
    notifyListeners();
  }

  void _saveAddIdValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('addIdValue', addIdValue); // Save addIdValue to SharedPreferences
  }
  // List<TestCart> cartItems = [];

  void updateAddIdValue(String id) {
    if (!addIdValue.contains(id)) {
      addIdValue.add(id);
      _saveAddIdValue();
      print("add id value 1  ${addIdValue}");
      notifyListeners();
      print("add id value 2  ${addIdValue}");
    } else {
      print("add id value 2 2 ${addIdValue}");
      addIdValue.remove(id);
      _saveAddIdValue();
      print("add id value 4  ${addIdValue}");
      notifyListeners();
    }
  }

  bool isInCart(String id) {
    print("get id value   ${addIdValue}");
    return addIdValue.contains(id);
  }
  Future<void> clearCart() async {
    // Clear in-memory data
    addIdValue.clear();
    _counter = 0;
    _totalPrice = 0;

    // Clear SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('addIdValue');
    await prefs.remove('cart_item');
    await prefs.remove('total_price');

    // Clear database
    await db.clearCart();

    // Notify listeners
    notifyListeners();
  }

  void _setprefItem()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.setInt("cart_item", _counter);
    prefs.setInt("total_price", totalPrice);
    notifyListeners();
  }


  void _getprefItem()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    _counter=prefs.getInt("cart_item") ?? 0;
    _totalPrice=prefs.getInt("total_price") ?? 0;
    notifyListeners();
  }

  void addTotalPrice (int  productPrice){
    _totalPrice = _totalPrice +productPrice ;
// _totalPrice=0;
    _setprefItem();
    notifyListeners();
  }

  void removeTotalPrice (int productPrice){
    _totalPrice = _totalPrice  - productPrice ;
    _setprefItem();
    notifyListeners();
  }

  int getTotalPrice (){
    _getprefItem();
    return  _totalPrice ;
  }

  void addcounter(){

    _counter++;
  // _counter=0;
    _setprefItem();
    notifyListeners();
  }
  void removeCounter(){
    _counter--;
    _setprefItem();
    notifyListeners();
  }
  int getcounter(){
    _getprefItem();
    return _counter;
  }

  List<TestInformation> testInfos = [];
  TestInformationRepository _repository = TestInformationRepository();




  Future<void> loadTestInfos() async {
    try {
      // testInfos = await _repository.getAllTestInfo2();
      testInfos = await _repository.getAllTestInfo2();
      notifyListeners();
    } catch (SocketException) {
      Utils().toastmessage("Network error: Please check your internet connection", Colors.red);

      print('Error loading test info: ');
    }
  }
//   *************************************Category ********************

  // TestRepository _repository = TestRepository();
  CategegoryRepository _repositoryy = CategegoryRepository();
  List<String> _categories = [];


  List<String> get categories => _categories;
  bool _isLoading = false;
  bool get isLoading => _isLoading;


  List<TestInformation> _Singlecategories = [];

  List<TestInformation> get singlecategories => _Singlecategories;

  Future<void> fetchCategories() async {
    try {

      _isLoading = true;
      notifyListeners();
      _categories = await _repositoryy.fetchCategories();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      // Handle errors here

      print('Error fetching categories: $e');
    }finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners after async operation completes
    }
  }



  Future<void> fetchSingleCategories(String category) async {
    try {


      _isLoading = true; // Set loading to true before fetching data
      notifyListeners();

      SingleCategoryTestRepository repository = SingleCategoryTestRepository(category);
      _Singlecategories = await repository.fetchSingleCategoriesdetails();
      _isLoading = false; // Set loading to false after data is fetched
      notifyListeners();

    } catch (error) {
      // Handle errors as needed, e.g., logging or showing an error message
      _isLoading = false;
      print('Error fetching categories: $error');
    }finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners after async operation completes
    }
  }




  
}