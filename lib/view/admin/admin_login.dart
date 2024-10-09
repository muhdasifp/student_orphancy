import 'package:care_life/view/admin/admin_home.dart';
import 'package:care_life/view/components/button.dart';
import 'package:care_life/view/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: 500,
          ),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Admin Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          validator: (value) {
                            if (value != 'admin') {
                              return 'invalid user name';
                            }
                            return null;
                          },
                          controller: emailController,
                          label: 'email',
                          prefix: const Icon(Icons.person_outline),
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          validator: (value) {
                            if (value != 'admin') {
                              return 'invalid password';
                            }
                            return null;
                          },
                          controller: passwordController,
                          label: 'password',
                          prefix: const Icon(Icons.lock_outline),
                        ),
                        const SizedBox(height: 25),
                        MyButton(
                          child: 'Login',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              Get.off(() => const AdminHome());
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
