




import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../Model/UserProfileImage.dart';
import '../repository/AuthRepository.dart';

class UserImageController with ChangeNotifier{

  UserRepository UserRepositoryy =UserRepository();
  File? _image;
  String? _imageUrl;
  bool _isLoading = false;
  final _picker = ImagePicker();

  File? get image => _image;
  String? get imageUrl => _imageUrl;
  bool get isLoading => _isLoading;
  String _id ="";
  String  get id =>_id;

  String _name ="";
  String  get name =>_name;

  String _email ="";
  String  get email =>_email;



  void idnameemail(String id,String name,String email ){

    _id=id;
    _name=name;
    _email=email;
    notifyListeners();

    print("id  ${_id}");
    print("name  ${_name}");
    print("email  ${_email}");

    print("id  get ${this.id}");
    print("name get ${this.name}");
    print("email  get  ${this.email}");
    print("${image?.path}");

  }

  Future<void> pickimagefromgalerry() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
     await uploadImageToServer();
    } else {
      print("No image selected");
    }
  }

  Future<void> pickimagefromcamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    await  uploadImageToServer();
    } else {
      print("No image selected");
    }
  }

    void pickiamge(context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: Container(
              height: 120,
              child:  Column(
                children: [
                 ListTile(
                   onTap: (){
                     pickimagefromcamera();
                    Navigator.pop(context);
                   },
                   leading: Icon(Icons.camera,color: Colors.black,),
                   title: Text("camera"),
                 ), ListTile(
                   onTap: (){
                     pickimagefromgalerry();
                   Navigator.pop(context);
                   },
                   leading: Icon(Icons.image,color: Colors.black,),
                   title: Text("gallery"),
                 ),
                ],
              ),
            ),
          );
        }
    );
  }

  Future<void> uploadImageToServer() async {
    _isLoading = true; // Set loading to true before upload
    notifyListeners();

    try {
      var stream = http.ByteStream(_image!.openRead());
      var length = await _image!.length();

      var uri = Uri.parse("https://us-central1-dsp-backend.cloudfunctions.net/api/uploadUserImage");
      var request = http.MultipartRequest('POST', uri);

      // Replace these with actual fields you want to send to the server
      request.fields['id'] = id; // Replace with actual user ID
      request.fields['name'] = name; // Replace with actual username
      request.fields['email'] = email; // Replace with actual email

      var multipartFile = http.MultipartFile(
        'file',
        stream,
        length,
        filename: path.basename(_image!.path),
      );
      request.files.add(multipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var parsedJson = jsonDecode(responseBody);
        var result = UserProfileImage.fromJson(parsedJson);
        _imageUrl = result.url;
        notifyListeners();
        // Update imageUrl with the uploaded URL
        print("Uploaded successfully. Result URL: $imageUrl");
       await updateuserprofilecontroller(_imageUrl!);

      } else {
        print("Failed to upload. Status code: ${response.statusCode}");
        print("Response body: ${await response.stream.bytesToString()}");
        // Handle the error appropriately
      }
    } catch (e) {
      print("Error uploading image: $e");
      // Handle exceptions or errors here
    }finally{
    _isLoading = false; // Set loading to false after upload completes or fails
    notifyListeners();
  }
  }


Future<void> updateuserprofilecontroller(String imageurl)async{

  try {
    // Call the updateUserProfile method from UserRepositoryy or any other service class
    var updatedUserData = await UserRepositoryy.updateUserProfile(profile_img: imageurl);

    if (updatedUserData != null) {
      // Handle successful update
      print('User profile updated successfully');

    } else {
      // Handle update failure
      print('Failed to update user profile');

    }
  } catch (error) {
    // Handle errors
    print('Error updating user profile: $error');
   // Complete with error if there's an exception
  }

}
  void clearImage() {
    _image = null;
    _imageUrl = null;
    notifyListeners();
  }



// ***********************************************************************************************




// final picker = ImagePicker();
// XFile? _image;
// XFile? get image => _image ;
//
//
// String _id ="";
// String  get id =>_id;
//
// String _name ="";
// String  get name =>_name;
//
// String _email ="";
// String  get email =>_email;
//
//
//
// void idnameemail(String id,String name,String email ){
//
//   _id=id;
//   _name=name;
//   _email=email;
//   notifyListeners();
//
//   print("id  ${_id}");
//   print("name  ${_name}");
//   print("email  ${_email}");
//
//   print("id  get ${this.id}");
//   print("name get ${this.name}");
//   print("email  get  ${this.email}");
//   print("${image?.path}");
//
// }
//
// Future<void> uploadimagetoserver()async{
//   var stream = new http.ByteStream(image!.openRead());
//   stream.cast();
//   var length= await image!.length();
//   var uri= Uri.parse("https://us-central1-dsp-backend.cloudfunctions.net/api/uploadUserImage");
//   var request = new http.MultipartRequest('POST', uri);
//   request.fields['id']=id;
//   request.fields['name']=name;
//   request.fields['email']=email;
// var multiport= new  http.MultipartFile(
//     "file",
//     stream,
//     length);
// request.files.add(multiport);
// try{
//   var response = await request.send();
//   if(response.statusCode==200){
//     print("upladed succesfully ");
//     var responseBody = await response.stream.bytesToString();
//     var parsedJson = jsonDecode(responseBody);
//     var result = UserProfileImage.fromJson(parsedJson);
//     print(" result is ${result}");
//     // return UserProfileImage.fromJson(parsedJson);
//   }else{
//
//     // return UserProfileImage(success: false, message: "Failed to upload image", url: null);
//   }
// }catch(e){
//
//   print("Exception occurred while uploading image: $e");
//   // return UserProfileImage(success: false, message: "Exception occurred", url: null);
//
// }
// }
//
//
// Future pickGallerImage()async{
//
//   final pickfile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);
//   if(pickfile != null){
//     _image= XFile(pickfile.path);
//     notifyListeners();
//     print("image url ${_image?.path}");
//     print("image url ${image?.path}");
//
//   }
//
// }
// Future pickGallerCamera()async{
//
//   final pickfile = await picker.pickImage(source: ImageSource.camera,imageQuality: 100);
//   if(pickfile != null){
//     _image= XFile(pickfile.path);
//     notifyListeners();
//     print("image url ${_image?.path}");
//     print("image url ${image}");
//   }
//
// }
//
//   void pickiamge(context){
//     showDialog(
//         context: context,
//         builder: (BuildContext context){
//           return AlertDialog(
//             content: Container(
//               height: 120,
//               child:  Column(
//                 children: [
//                  ListTile(
//                    onTap: (){
//                     pickGallerCamera();
//                     Navigator.pop(context);
//                    },
//                    leading: Icon(Icons.camera,color: Colors.black,),
//                    title: Text("camera"),
//                  ), ListTile(
//                    onTap: (){
//                    pickGallerImage();
//                    Navigator.pop(context);
//                    },
//                    leading: Icon(Icons.image,color: Colors.black,),
//                    title: Text("gallery"),
//                  ),
//                 ],
//               ),
//             ),
//           );
//         }
//     );
//   }
}