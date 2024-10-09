import 'package:care_life/controller/authentication_service.dart';
import 'package:care_life/controller/location_service.dart';
import 'package:care_life/controller/my_provider.dart';
import 'package:care_life/controller/user_provider.dart';
import 'package:care_life/model/user_model.dart';
import 'package:care_life/view/chat/chat_page.dart';
import 'package:care_life/view/components/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, value, _) {
          final UserModel user = value.currentUser;
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      child: Text(user.email![0].toString().toUpperCase(),
                          style: const TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: Text(user.name.toString().toUpperCase()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email_outlined),
                      title: Text("${user.email}"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.call_outlined),
                      title: Text("${user.phone}"),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('fetch my current location'),
                        Provider.of<MyProvider>(context).isLoading
                            ? const SizedBox()
                            : IconButton(
                                onPressed: () {
                                  context.read<MyProvider>().toggle();
                                  final LocationService location =
                                      LocationService();
                                  location
                                      .getCurrentLocation()
                                      .then((value) =>
                                          context.read<MyProvider>().toggle())
                                      .onError((error, stackTrace) =>
                                          context.read<MyProvider>().toggle());
                                },
                                icon: const Icon(Icons.my_location_rounded),
                              )
                      ],
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_on_outlined),
                      title: Text("${user.lat}, ${user.long} "),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home_outlined),
                      title: Text("${user.address}"),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                      userName: user.name!,
                                    )));
                      },
                      leading: const Icon(Icons.chat),
                      title: const Text("Contact us"),
                    ),
                    const SizedBox(height: 20),
                    MyButton(
                      child: 'Logout',
                      onTap: () {
                        context.read<MyProvider>().toggle();
                        AuthenticationService.logoutUser().then((value) {
                          context.read<MyProvider>().toggle();
                        }).onError((error, stackTrace) {
                          context.read<MyProvider>().toggle();
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
