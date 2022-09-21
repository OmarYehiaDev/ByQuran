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

  late Rx<bool?> _logged;
  final FirebaseAuth authFirebase = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final twitterLogin = new TwitterLogin(
    redirectURI: dotenv.env["TWITTER_SCHEME"]!,
    apiKey: dotenv.env["TWITTER_API_KEY"]!,
    apiSecretKey: dotenv.env["TWITTER_API_SECRET"]!,
  );

  @override
  void onInit() {
    loginAnon();
    super.onInit();
  }

  @override
  void onReady() {
    GetStorage storage = GetStorage();

    super.onReady();
    _logged = Rx<bool?>(storage.read("logged"));
    _logged.bindStream(
      Stream.value(
        storage.read("logged"),
      ),
    );
    ever(_logged, _startScreen);
  }

  _startScreen(bool? logged) {
    loginAnon();
    Get.offAll(() => HomeScreen());
    // if (logged != null && logged) {
    //   Get.offAll(() => HomeScreen());
    // } else {
    //   Get.offAll(() => LoginScreen());
    // }
  }

  void register(String email, password) async {
    try {
      UserCredential cred = await authFirebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final accountData = GetStorage();
      await accountData.write('email', cred.user!.email);
      await accountData.write('displayName', cred.user!.displayName);
      await accountData.write('photoUrl', cred.user!.photoURL);
      await accountData.write("logged", true);
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
      await accountData.write('email', null);
      await accountData.write('displayName', "مستخدم مجهول");
      await accountData.write('photoUrl', null);
      await accountData.write("logged", true);
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
    GetStorage accountData = GetStorage();
    accountData.write("logged", false);

    await authFirebase.signOut();
    await googleSignIn.signOut();
    await facebookAuth.logOut();
    Get.offAll(
      () => LoginScreen(),
    );
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
    await accountData.write(
      'email',
      cred.user!.email ?? accountData.read('email'),
    );
    await accountData.write(
      'displayName',
      cred.user!.displayName ?? accountData.read('displayName'),
    );
    await accountData.write(
      'photoUrl',
      cred.user!.photoURL,
    );
    await accountData.write("logged", true);
    Get.offAll(() => HomeScreen());
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
    await accountData.write(
      'email',
      cred.user!.email ?? accountData.read('email'),
    );
    await accountData.write(
      'displayName',
      cred.user!.displayName ?? accountData.read('displayName'),
    );
    await accountData.write(
      'photoUrl',
      cred.user!.photoURL,
    );
    await accountData.write("logged", true);
    Get.offAll(() => HomeScreen());
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
    await accountData.write(
      'email',
      cred.user!.email ?? accountData.read('email'),
    );
    await accountData.write(
      'displayName',
      cred.user!.displayName ?? accountData.read('displayName'),
    );
    await accountData.write(
      'photoUrl',
      cred.user!.photoURL,
    );
    await accountData.write("logged", true);
    Get.offAll(() => HomeScreen());
  }
}
