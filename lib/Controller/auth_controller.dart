// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

import '../Views/home_screen.dart';
import '../Views/login_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  final FirebaseAuth authFirebase = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final twitterLogin = new TwitterLogin(
    redirectURI: dotenv.env["TWITTER_SCHEME"]!,
    apiKey: dotenv.env["TWITTER_API_KEY"]!,
    apiSecretKey: dotenv.env["TWITTER_API_SECRET"]!,
  );

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authFirebase.currentUser);
    _user.bindStream(authFirebase.userChanges());
    ever(_user, _startScreen);
  }

  _startScreen(User? user) {
    if (user?.email! != GetStorage().read("email")) {
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
    await facebookAuth.logOut();
  }

  void googleSignUp() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

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
    accountData.write(
      'email',
      cred.user!.email ?? accountData.read('email'),
    );
    accountData.write(
      'displayName',
      cred.user!.displayName ?? accountData.read('displayName'),
    );
    accountData.write(
      'photoUrl',
      cred.user!.photoURL,
    );
  }

  void facebookSignIn() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await facebookAuth.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    UserCredential cred = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    /// Save User Data
    final accountData = GetStorage();
    accountData.write(
      'email',
      cred.user!.email ?? accountData.read('email'),
    );
    accountData.write(
      'displayName',
      cred.user!.displayName ?? accountData.read('displayName'),
    );
    accountData.write(
      'photoUrl',
      cred.user!.photoURL,
    );
  }

  void signInWithTwitter() async {
    // Trigger the sign-in flow
    final authResult = await twitterLogin.loginV2(forceLogin: true);

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    // Once signed in, return the UserCredential
    UserCredential cred = await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    final accountData = GetStorage();
    accountData.write(
      'email',
      cred.user!.email ?? accountData.read('email'),
    );
    accountData.write(
      'displayName',
      cred.user!.displayName ?? accountData.read('displayName'),
    );
    accountData.write(
      'photoUrl',
      cred.user!.photoURL,
    );
  }
}

  // auth2 is initialized with gapi.auth2.init() and a user is signed in.

