import 'package:care_life/model/user_model.dart';
import 'package:care_life/utility/toast_message.dart';
import 'package:care_life/view/auth/login_page.dart';
import 'package:care_life/view/home/bott_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationService {
  static final _auth = FirebaseAuth.instance;
  static final _collection = FirebaseFirestore.instance.collection('users');

  ///to register new user to firebase
  static Future<void> registerUser(
      String email, String password, String name, String phone) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user;
      if (user != null) {
        saveUserProfile(UserModel(
          uid: user.uid,
          name: name,
          email: email,
          password: password,
          phone: phone,
        ));
        Get.offAll(() => const BottNavBar());
      }
    } on FirebaseAuthException catch (e) {
      sendToastMessage(message: e.code);
    }
  }

  ///to login registered user
  static Future<void> loginUser(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user;
      if (user != null) {
        Get.offAll(() => const BottNavBar());
      }
    } on FirebaseAuthException catch (e) {
      sendToastMessage(message: e.code);
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }

  ///to logout user
  static Future<void> logoutUser() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const LoginPage());
    } on FirebaseAuthException catch (e) {
      sendToastMessage(message: e.code);
    }
  }

  ///save user details while register
  static Future<void> saveUserProfile(UserModel user) async {
    try {
      await _collection.doc(user.uid).set(user.toJson());
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }
}
