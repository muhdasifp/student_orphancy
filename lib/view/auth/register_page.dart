import 'package:care_life/controller/authentication_service.dart';
import 'package:care_life/controller/my_provider.dart';
import 'package:care_life/view/components/button.dart';
import 'package:care_life/view/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    controller: nameController,
                    label: 'name',
                    prefix: const Icon(Icons.person_outline),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: emailController,
                    label: 'email',
                    prefix: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: passwordController,
                    label: 'password',
                    prefix: const Icon(Icons.lock_outline),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: phoneController,
                    label: 'number',
                    prefix: const Icon(Icons.call_outlined),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Already have an account'),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  MyButton(
                    child: 'Register',
                    onTap: () {
                      context.read<MyProvider>().toggle();
                      AuthenticationService.registerUser(
                              emailController.text,
                              passwordController.text,
                              nameController.text,
                              phoneController.text)
                          .then((value) {
                        context.read<MyProvider>().toggle();
                        phoneController.clear();
                        emailController.clear();
                        passwordController.clear();
                        nameController.clear();
                      }).onError((error, stackTrace) {
                        context.read<MyProvider>().toggle();
                      });
                    },
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
