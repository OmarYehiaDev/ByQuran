import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Views/home_screen.dart';
import '../Views/login_screen.dart';


class AuthController extends GetxController {

  static AuthController instance = Get.find();

  late Rx<User?> _user;
  FirebaseAuth authFirebase = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authFirebase.currentUser);
    _user.bindStream(authFirebase.userChanges());
    ever(_user, _startScreen);
  }

  _startScreen(User? user) {
    if (user == null) {
      Get.offAll(() =>  LoginScreen());
    } else {
      // Get.offAll(() => WelcomePage( email: user.email ?? 'Not Found',));
      Get.offAll(()=>HomeScreen());
    }
  }

  void register(String email, password) async {
    try {
      await authFirebase.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar(
        'About User',
        'User Message',
        backgroundColor: Colors.lightBlueAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          'Account creation failed',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void login(String email, password) async {
    try {
      await authFirebase.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar('About User', 'User Message',
          backgroundColor: Colors.lightBlueAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            'login failed',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ));
    }
  }

  void logOut() async {
    await authFirebase.signOut();
    await googleSignIn.signOut();
  }

  void googleSignUp() async {
    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();

    if (googleAccount != null) {
      GoogleSignInAuthentication signInAuthentication =
          await googleAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: signInAuthentication.idToken,
          accessToken: signInAuthentication.accessToken);

      await authFirebase.signInWithCredential(credential);

      /// Save User Data
      final accountData = GetStorage();
      accountData.write('email', googleSignIn.currentUser!.email);
      accountData.write('displayName', googleSignIn.currentUser!.displayName);
      accountData.write('photoUrl', googleSignIn.currentUser!.photoUrl);
    }
  }

  // auth2 is initialized with gapi.auth2.init() and a user is signed in.



  ////
}
