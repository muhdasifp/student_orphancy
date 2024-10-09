import 'package:care_life/data/colors.dart';
import 'package:care_life/view/admin/add_event.dart';
import 'package:care_life/view/admin/add_new_home.dart';
import 'package:care_life/view/admin/admin_chat_page.dart';
import 'package:care_life/view/admin/admin_donation_display.dart';
import 'package:care_life/view/admin/request_page.dart';
import 'package:care_life/view/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: 500,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Admin Panel',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.offAll(() => const LoginPage());
                  },
                  icon: const Icon(Icons.logout_outlined, color: Colors.red))
            ],
            bottom: PreferredSize(
              preferredSize: Size(
                  double.infinity, MediaQuery.of(context).size.height * 0.04),
              child: TabBar(
                isScrollable: true,
                dividerColor: primaryAppColor,
                labelColor: Colors.white,
                indicatorColor: primaryAppColor,
                unselectedLabelColor: Colors.white38,
                tabs: [
                  headerText(text: 'Requests'),
                  headerText(text: 'Donations'),
                  headerText(text: 'Events'),
                  headerText(text: 'Supports'),
                  headerText(text: 'Add New'),
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              AdminRequestPage(),
              AdminDonationDisplay(),
              AdminAddEvent(),
              AdminChatPage(),
              AdminAddNew(),
            ],
          ),
        ),
      ),
    );
  }

  Container headerText({required String text}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primaryAppColor,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text),
    );
  }
}
