import 'package:care_life/controller/authentication_service.dart';
import 'package:care_life/controller/my_provider.dart';
import 'package:care_life/data/images.dart';
import 'package:care_life/view/admin/admin_login.dart';
import 'package:care_life/view/auth/register_page.dart';
import 'package:care_life/view/components/button.dart';
import 'package:care_life/view/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Get.off(() => const AdminLogin());
                },
                icon: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.red,
                ),
              )
            ],
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    controller: emailController,
                    label: 'email',
                    prefix: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    isPassword: true,
                    controller: passwordController,
                    label: 'password',
                    prefix: const Icon(Icons.lock_outline),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.to(() => const RegisterPage(),
                              transition: Transition.leftToRightWithFade);
                        },
                        child: const Text('New User ?'),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  MyButton(
                    child: 'Login',
                    onTap: () {
                      context.read<MyProvider>().toggle();
                      AuthenticationService.loginUser(
                              emailController.text, passwordController.text)
                          .then((value) {
                        context.read<MyProvider>().toggle();
                        emailController.clear();
                        passwordController.clear();
                      }).onError((error, stackTrace) =>
                              context.read<MyProvider>().toggle());
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(googleLogoIcon),
                        Image.asset(facebookLogoIcon),
                        Image.asset(appleLogoIcon),
                        Image.asset(linkedinLogoIcon),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
