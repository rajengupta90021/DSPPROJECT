import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../Model/TestInformation.dart';
import '../repository/CategoryListRepository.dart';
import '../repository/SingleCategroyTestRepository.dart';

class ProviderData extends ChangeNotifier {

  // List<Map<String, dynamic>> addCart = [];
  // List<String> addIdValue = [];
  // List<TestInformation> testInfos = [];

  // TestRepository _repository = TestRepository();
  // CategegoryRepository _repositoryy = CategegoryRepository();
  // List<String> _categories = [];
  //
  //
  // List<String> get categories => _categories;
  // bool _isLoading = false;
  // bool get isLoading => _isLoading;
  //
  //
  // List<TestInformation> _Singlecategories = [];
  //
  // List<TestInformation> get singlecategories => _Singlecategories;

  // ProviderData() {
  //   loadTestInfos();
  // }
  // Future<void> loadTestInfos() async {
  //   try {
  //     testInfos = await _repository.getAllTestInfo();
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error loading test info: $e');
  //   }
  // }
  // void addToCartCategory(TestInformation TestInformation) {
  //   addCart.add(TestInformation.toJson()); // Assuming toJson() returns a Map<String, dynamic>
  //   addIdValue.add(TestInformation.id ?? '');
  //   print('addcart: ${addCart}');
  //   print('add id value : ${addIdValue}');
  //   notifyListeners();
  // }
  //
  // void removeFromCartCategory(TestInformation TestInformation) {
  //   addCart.removeWhere((item) => item['id'] == TestInformation.id);
  //   addIdValue.remove(TestInformation.id ?? '');
  //   print('addcart: ${addCart}');
  //   print('add id value : ${addIdValue}');
  //   notifyListeners();
  // }

  //
  // void addToCart(TestInformation testInfo) {
  //   addCart.add(testInfo.toJson()); // Assuming toJson() returns a Map<String, dynamic>
  //   addIdValue.add(testInfo.id ?? '');
  //   print('Added to Cart: ${testInfo.tests}');
  //   print('Cart Items: ${addCart}');
  //   print('Id Values: ${addIdValue}');
  //   notifyListeners();
  // }
  //
  // void removeFromCart(TestInformation testInfo) {
  //   addCart.removeWhere((item) => item['id'] == testInfo.id);
  //   addIdValue.remove(testInfo.id ?? '');
  //   print('Removed from Cart: ${testInfo.tests}');
  //   print('Cart Items: ${addCart}');
  //   print('Id Values: ${addIdValue}');
  //   notifyListeners();
  // }


  // List<TestInformation> searchTestInfos(String query) {
  //   if (query.isEmpty) {
  //     return testInfos;
  //   } else {
  //     return testInfos.where((test) =>
  //     test.tests?.toLowerCase().contains(query.toLowerCase()) ?? false).toList();
  //   }
  // }


  // Future<void> fetchCategories() async {
  //   try {
  //
  //     _isLoading = true;
  //     notifyListeners();
  //     _categories = await _repositoryy.fetchCategories();
  //
  //     _isLoading = false;
  //     notifyListeners();
  //   } catch (e) {
  //     // Handle errors here
  //
  //     print('Error fetching categories: $e');
  //   }finally {
  //     _isLoading = false;
  //     notifyListeners(); // Notify listeners after async operation completes
  //   }
  // }



  // Future<void> fetchSingleCategories(String category) async {
  //   _isLoading = true; // Set loading to true before fetching data
  //   notifyListeners();
  //
  //   try {
  //     SingleCategoryTestRepository repository = SingleCategoryTestRepository(category);
  //     _Singlecategories = await repository.fetchSingleCategoriesdetails();
  //   } catch (error) {
  //     // Handle errors as needed, e.g., logging or showing an error message
  //     print('Error fetching categories: $error');
  //   } finally {
  //     _isLoading = false; // Set loading to false after data is fetched or error handled
  //     notifyListeners(); // Notify listeners after async operation completes
  //   }
  // }



  notifyListeners();

  String? _imageUrl;

  String? get imageUrl => _imageUrl;

  void setImageUrl(String url) {
    _imageUrl = url;
    notifyListeners();
  }

  void resetImageUrl() {
    _imageUrl = null;
    notifyListeners();
  }

  // // Constructor
  // ProviderData() {
  //   // Load image URL from SharedPreferences when ProviderData is initialized
  //   _loadImageUrl();
  // }
  //
  // // Load image URL from SharedPreferences
  // Future<void> _loadImageUrl() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _imageUrl = prefs.getString('imageUrl');
  //   notifyListeners();
  // }
  //
  // // Set image URL and save it to SharedPreferences
  // Future<void> setImageUrl(String url) async {
  //   _imageUrl = url;
  //   notifyListeners();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('imageUrl', url);
  // }
  //
  // // Reset image URL and remove it from SharedPreferences
  // Future<void> resetImageUrl() async {
  //   _imageUrl = null;
  //   notifyListeners();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('imageUrl');
  // }


  // bool _isFavorite = false;
  //
  // bool get isFavorite => _isFavorite;
  //
  // void toggleFavorite() {
  //   _isFavorite = !_isFavorite;
  //   notifyListeners();
  // }



}
