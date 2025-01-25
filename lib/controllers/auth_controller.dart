
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zubi/constants.dart';
import 'package:zubi/models/auth/user.dart' as model;
import 'package:zubi/views/screens/auth/login_screen.dart';
import 'package:zubi/views/screens/videos/customized_homepage.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;
  File? get ProfilePhoto => _pickedImage.value;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if(user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const CustomizedHomepage());
    }
  }

  void pickImage() async{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage != null) {
      Get.snackbar(
      "Profile Picture",
      "You've Successfully Selected your Profile Picture!"
      );
      _pickedImage = Rx<File?>(File(pickedImage.path));
    }
  }
//   upload to FIrebase Storage
Future<String> _uploadToStorage(File image) async {
  Reference ref = firebaseStorage
      .ref()
      .child('profilePics')
      .child(firebaseAuth.currentUser!.uid);

  UploadTask uploadTask = ref.putFile(image);
  TaskSnapshot snap = await uploadTask;
  String downloadUrl = await snap.ref.getDownloadURL();
  return downloadUrl;
}

//   Registering the user
void registerUser(String username, String email,  String phoneNumber, String password, File? image) async{
  try {
    if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image != null) {
    //   Save data to firebase database
      UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );
     String downloadUrl = await _uploadToStorage(image);
     model.User user = model.User(
       name: username,
       email: email,
       phoneNumber: phoneNumber,
       uid: cred.user!.uid,
       profilePhoto: downloadUrl,
     );
     await firebaseStore
         .collection('users')
         .doc(cred.user!.uid)
         .set(user.toJson());
    } else {
      Get.snackbar(
          "Error Creating Account",
          "Please enter all fields",
      );
    }
  } catch(e){
    Get.snackbar(
        'Error Creating an Account',
        e.toString()
    );
  }
}

void loginUser(String email, String password) async {
    try {
      if(email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        print("Log Successful");
      } else {
        Get.snackbar(
          "Error Logging into Account",
          "Please enter all fields",
        );
      }
    } catch (e) {
      Get.snackbar(
          'Error Creating an Account',
          e.toString()
      );
    }
}

void signOut() async {
    await firebaseAuth.signOut();
}
}