import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:zubi/controllers/auth_controller.dart';
import 'package:zubi/views/screens/profile/profile_Screen.dart';
import 'package:zubi/views/screens/videos/custompage.dart';
import 'package:zubi/views/screens/videos/search_music_page(2).dart';
import 'package:zubi/views/screens/videos/search_screen.dart';
import 'package:zubi/views/screens/videos/video_screen.dart';


// Page
List pages = [
  const CustomPageScreen(),
  SearchScreen(),
  VideoScreen(),
  const SearchForMusicPage(),
  const Text("Messages Screen"),
  ProfileScreen(uid: authController.user.uid),
];
//COLORS
const customHeaderBg = Colors.deepPurpleAccent;
const backgroundColor = Colors.black;
var buttonColor = Colors.deepPurpleAccent;
var cameraColor = Colors.red[700];
const borderColor = Colors.grey;

//FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firebaseStore = FirebaseFirestore.instance;

//CONTROLLER
var authController = AuthController.instance;