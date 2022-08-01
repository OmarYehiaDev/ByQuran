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
      Get.offAll(() => LoginScreen());
    } else {
      // Get.offAll(() => WelcomePage( email: user.email ?? 'Not Found',));
      Get.offAll(() => HomeScreen());
    }
  }

  void register(String email, password) async {
    try {
      UserCredential cred = await authFirebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final accountData = GetStorage();
      accountData.write('email', cred.user!.email);
      accountData.write('displayName', cred.user!.displayName);
      accountData.write('photoUrl', cred.user!.photoURL);
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

  void loginAnon() async {
    try {
      await authFirebase.signInAnonymously();
      final accountData = GetStorage();
      accountData.write('email', null);
      accountData.write('displayName', "مستخدم مجهول");
      accountData.write('photoUrl', null);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void login(String email, password) async {
    try {
      await authFirebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Get.snackbar(
        'About User',
        'User Message',
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
        ),
      );
    }
  }

  void logOut() async {
    await authFirebase.signOut();
    await googleSignIn.signOut();
  }

  void googleSignUp() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential cred = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    /// Save User Data
    final accountData = GetStorage();
    accountData.write('email', cred.user!.email);
    accountData.write('displayName', cred.user!.displayName);
    accountData.write('photoUrl', cred.user!.photoURL);
  }
}

  // auth2 is initialized with gapi.auth2.init() and a user is signed in.

