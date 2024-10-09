import 'package:care_life/controller/my_provider.dart';
import 'package:care_life/data/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyButton extends StatelessWidget {
  final String child;
  final VoidCallback onTap;

  const MyButton({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: primaryAppColor,
        ),
        child: provider.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                child,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
