import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/colors.dart';
import '../helper/session_manager/SessionController.dart';
import '../helper/utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileController with ChangeNotifier{

  DatabaseReference ref= FirebaseDatabase.instance.ref().child('User');
 firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;


  final picker =ImagePicker();
  XFile? _image;
  XFile? get image => _image;


  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }


  Future pickgalleryimage(BuildContext context)async{

    final pickedfile = await picker .pickImage(source: ImageSource.gallery,imageQuality: 100);
    if(pickedfile != null){
       _image= XFile(pickedfile.path);
       uploadimage(context);
       notifyListeners();
    }
  }
  Future pickCameraimage(BuildContext context)async{

    final pickedfile = await picker .pickImage(source: ImageSource.camera,imageQuality: 100);
    if(pickedfile != null){
      _image= XFile(pickedfile.path);
      uploadimage(context);
      notifyListeners();
    }
  }


  void pickimage(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () {
                    pickCameraimage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera, color: Colors.blue),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickgalleryimage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.image, color: Colors.blue),
                  title: Text('Gallery'),
                ),

                ListTile(
                  onTap: () {
                    deleteImage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text(
                    'Delete Profile Image',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  void uploadimage(BuildContext context) async {

    setLoading(true);

    File imageFile = File(image!.path).absolute;


    firebase_storage.Reference storageReference = storage.ref('/profileimage/${SessionController().userId}');

    try {

      firebase_storage.UploadTask uploadTask = storageReference.putFile(imageFile);


      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});


      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      ref.child(SessionController().userId.toString()).update({
        'profile':downloadURL.toString()
      }).then((value){
        Utils().toastmessage("image uplaoded succesflully ", Colors.lightGreen);
        _image=null;
        setLoading(true);
      }).onError((error, stackTrace){
        Utils().toastmessage("image uplaoding failed ", Colors.red);
      });

      // You can now use the downloadURL as needed (e.g., save it to the database)
      print('Download URL: $downloadURL');
    } catch (error) {
      setLoading(true);
      // Handle any errors that occur during the upload process
      print('Error uploading image: $error');
    }
  }

  Future<void> deleteImage(BuildContext context) async {
    if (SessionController().userId == null) {
      // Handle the case where the user ID is not available
      return;
    }

    // Create a reference to the Firebase Storage location of the user's profile image
    firebase_storage.Reference storageReference =
    storage.ref('/profileimage/${SessionController().userId}');

    try {
      // Delete the image from Firebase Storage
      await storageReference.delete();

      // Update the database to remove the profile image URL
      await ref
          .child(SessionController().userId.toString())
          .update({'profile': ''});

      // Notify listeners and show a success message
      Utils().toastmessage("Image deleted successfully", Colors.lightGreen);
      notifyListeners();
    } catch (error) {
      // Handle errors
      print('Error deleting image: $error');
      Utils().toastmessage("Failed to delete image", Colors.red);
    }
  }
}








  // ***********************************************************


  // void imagePickerOption(BuildContext context) {
  //   Get.bottomSheet(
  //     SingleChildScrollView(
  //       child: ClipRRect(
  //         borderRadius: const BorderRadius.only(
  //           topLeft: Radius.circular(10.0),
  //           topRight: Radius.circular(10.0),
  //         ),
  //         child: Container(
  //           color: Colors.white,
  //           height: 250,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: [
  //                 const Text(
  //                   "Pic Image From",
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 const SizedBox(
  //                   height: 0,
  //                 ),
  //                 ElevatedButton.icon(
  //                   onPressed: () {
  //                     pickImage(context, ImageSource.camera);
  //                   },
  //                   icon: const Icon(Icons.camera),
  //                   label: const Text("CAMERA"),
  //                 ),
  //                 ElevatedButton.icon(
  //                   onPressed: () {
  //                     pickImage(context, ImageSource.gallery);
  //                   },
  //                   icon: const Icon(Icons.image),
  //                   label: const Text("GALLERY"),
  //                 ),
  //                 ElevatedButton.icon(
  //                   onPressed: () {
  //                     // deleteImage(context);
  //                   },
  //                   icon: const Icon(Icons.delete),
  //                   label: const Text("DELETE"),
  //                 ),
  //                 const SizedBox(
  //                   height: 0,
  //                 ),
  //                 ElevatedButton.icon(
  //                   onPressed: () {
  //                     Get.back();
  //                   },
  //                   icon: const Icon(Icons.close),
  //                   label: const Text("CANCEL"),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // final ImagePicker _imagePicker = ImagePicker();
  //
  // void pickImage(BuildContext context, ImageSource imageType) async {
  //   XFile? res = await _imagePicker.pickImage(source: imageType);
  //   if (res != null) {
  //     // uploadtofirebase(context, File(res.path));
  //     Get.back();
  //   } else {
  //     print("Some error occurred");
  //     Utils().toastmessage("Some error occurred", greenColor);
  //   }
  // }
