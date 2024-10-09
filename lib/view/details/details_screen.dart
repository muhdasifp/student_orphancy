import 'package:care_life/controller/user_provider.dart';
import 'package:care_life/data/colors.dart';
import 'package:care_life/data/images.dart';
import 'package:care_life/model/old_home_model.dart';
import 'package:care_life/model/request_model.dart';
import 'package:care_life/view/details/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  final OldHomeModel home;

  const DetailsScreen({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            flexibleSpace: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(25)),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 5, offset: Offset(2, 3))
                ],
                image: home.image!.isNotEmpty
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(home.image.toString()))
                    : const DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(appLogo)),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    home.name!,
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(home.address!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.merge_type),
                      const SizedBox(width: 10),
                      Text(home.type!),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.phone_android),
                      const SizedBox(width: 10),
                      Text(home.number!),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.note_alt_outlined),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          home.needs!,
                          style: const TextStyle(
                              fontStyle: FontStyle.italic, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildElevatedButton(
                    text: 'Donate',
                    icon: Icons.currency_rupee,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              PaymentScreen(home: home.name!));
                    },
                  ),
                  buildElevatedButton(
                    text: 'Donate Cloths',
                    icon: Icons.checkroom,
                    onTap: () {
                      enquiryDialogBox(context);
                    },
                  ),
                  buildElevatedButton(
                    text: 'Donate Foods',
                    icon: Icons.fastfood,
                    onTap: () {
                      enquiryDialogBox(context);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildElevatedButton({
    required String text,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            elevation: 6,
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: primaryAppColor,
            foregroundColor: Colors.white),
        onPressed: onTap,
        label: Text(text),
        icon: Icon(icon),
      ),
    );
  }

  Future<dynamic> enquiryDialogBox(BuildContext context) {
    TextEditingController message = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: message,
                decoration: InputDecoration(
                    hintText: "Type your message",
                    suffixIcon: const Icon(Icons.message_outlined),
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: Colors.black,
                textColor: Colors.white,
                onPressed: () {
                  context
                      .read<UserProvider>()
                      .sendRequestToAdmin(message.text, home.name!)
                      .then((value) => Get.back());
                },
                child: const Text("Send Message"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
