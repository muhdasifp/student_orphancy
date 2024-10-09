import 'package:care_life/controller/internet_connection_service.dart';
import 'package:care_life/data/colors.dart';
import 'package:care_life/data/images.dart';
import 'package:care_life/view/auth/login_page.dart';
import 'package:care_life/view/home/bott_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkUser() async {
    await Future.delayed(const Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          Get.offAll(() => const BottNavBar());
        } else {
          Get.offAll(() => const LoginPage());
        }
      });
    });
    Get.put<ConnectivityController>(ConnectivityController());
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryAppColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(appLogo),
            const Text(
              "ORPHANCY",
              style: TextStyle(
                fontSize: 38,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
