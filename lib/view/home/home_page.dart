import 'package:care_life/controller/user_provider.dart';
import 'package:care_life/data/colors.dart';
import 'package:care_life/view/details/details_screen.dart';
import 'package:care_life/view/home/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Consumer<UserProvider>(builder: (context, user, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "ORPHANCY",
            style: TextStyle(
                color: primaryAppColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: TextField(
                onChanged: (value) {
                  user.searchOldHome(searchController.text);
                },
                controller: searchController,
                decoration: InputDecoration(
                    hintText: "Search here ...",
                    suffixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.all(12),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none)),
              ),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: user.tempOldHomes.isEmpty
              ? user.allOldHomes.length
              : user.tempOldHomes.length,
          itemBuilder: (context, index) {
            var data = user.tempOldHomes.isEmpty
                ? user.allOldHomes[index]
                : user.tempOldHomes[index];
            return InkWell(
              onTap: () {
                Get.to(() => DetailsScreen(home: data),
                    transition: Transition.topLevel);
              },
              child: HomeCard(
                oldHome: data,
              ),
            );
          },
        ),
      );
    });
  }
}
