import 'package:care_life/controller/launcher_service.dart';
import 'package:care_life/controller/user_provider.dart';
import 'package:care_life/data/images.dart';
import 'package:care_life/model/old_home_model.dart';
import 'package:care_life/model/request_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCard extends StatelessWidget {
  final OldHomeModel oldHome;

  const HomeCard({super.key, required this.oldHome});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: size.height * 0.15,
          width: size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: oldHome.image == ""
                ? const DecorationImage(
                    image: AssetImage(appLogo), fit: BoxFit.cover)
                : DecorationImage(
                    image: NetworkImage(oldHome.image!), fit: BoxFit.cover),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${oldHome.name}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on_outlined),
                  Expanded(child: Text('${oldHome.address}')),
                ],
              ),
              Text("${oldHome.type}"),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      LauncherService().launchPhoneCall("${oldHome.number}");
                    },
                    child: const Card(
                      color: Colors.green,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.call, color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      LauncherService().launchEmail("${oldHome.mail}");
                    },
                    child: const Card(
                      color: Colors.blue,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.mail_outline, color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      LauncherService()
                          .launchGoogleMap("${oldHome.lat}", "${oldHome.long}");
                    },
                    child: const Card(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.map_outlined, color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      enquiryDialogBox(context);
                    },
                    child: const Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(Icons.chat),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
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
                decoration: InputDecoration(
                    hintText: "Type to send Enquiry",
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
                  context.read<UserProvider>().sendRequestToAdmin(
                      message.text, oldHome.name.toString());
                },
                child: const Text("Enquire"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
