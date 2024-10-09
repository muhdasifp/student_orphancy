import 'package:care_life/controller/launcher_service.dart';
import 'package:care_life/data/images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminRequestPage extends StatelessWidget {
  const AdminRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LauncherService launcher = LauncherService();
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 500,
          maxHeight: double.infinity,
        ),
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('requests').get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final snap = snapshot.data!.docs[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snap['user']['name']}".toUpperCase(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      Text("${snap['user']['phone']}"),
                      Text("${snap['old_home']}"),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              child: Text(
                                "\"${snap['message']}\"",
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  launcher.launchPhoneCall(
                                      "${snap['user']['number']}");
                                },
                                child: Image.asset(
                                  callIcon,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  launcher
                                      .launchEmail("${snap['user']['email']}");
                                },
                                child: Image.asset(
                                  mailIcon,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  launcher.launchGoogleMap(
                                    "${snap['user']['lat']}",
                                    "${snap['user']['long']}",
                                  );
                                },
                                child: Image.asset(
                                  mapIcon,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider()
                    ],
                  );
                },
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('No Data Found'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }
}
