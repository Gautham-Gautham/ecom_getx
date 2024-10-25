import 'package:ecom_getx/Features/Login/Screens/login_screen.dart';
import 'package:ecom_getx/Features/Login/Screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../HomeScreen/Screens/home_screen.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signUp(
      String email, String password, BuildContext context) async {
    print("object");
    try {
      print("object");
      print(email);
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("object");
      print("User signed up: ${userCredential.user?.email}");
      Get.to(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password is too weak.');
        showSnackBarDialogue(
            context: context, message: "Password must have 6 characters");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        showSnackBarDialogue(
            context: context,
            message: "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User logged in: ${userCredential.user?.email}");
      Get.to(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        showSnackBarDialogue(
            context: context, message: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        showSnackBarDialogue(
            context: context, message: "Wrong password provided.");
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    await auth.signOut().then(
      (value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
          (route) => false,
        );
      },
    );
  }
}
