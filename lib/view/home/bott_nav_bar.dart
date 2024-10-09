import 'package:care_life/controller/user_provider.dart';
import 'package:care_life/view/event/event_page.dart';
import 'package:care_life/view/home/home_page.dart';
import 'package:care_life/view/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

ValueNotifier<int> currentPage = ValueNotifier(0);

class BottNavBar extends StatelessWidget {
  const BottNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserProvider>().getAllEvents();
    context.read<UserProvider>().getUserProfile();
    context.read<UserProvider>().getAllOldHome();

    List<Widget> pages = const [
      HomePage(),
      EventPage(),
      ProfilePage(),
    ];
    return ValueListenableBuilder(
      valueListenable: currentPage,
      builder: (context, value, _) {
        return Scaffold(
          body: pages[value],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BottomNavigationBar(
                backgroundColor: Colors.black,
                currentIndex: value,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                onTap: (val) {
                  currentPage.value = val;
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.event), label: 'Events'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Profile')
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
