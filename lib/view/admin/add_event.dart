import 'package:care_life/controller/admin_provider.dart';
import 'package:care_life/controller/my_provider.dart';
import 'package:care_life/model/event_model.dart';
import 'package:care_life/utility/date_formatter.dart';
import 'package:care_life/view/components/button.dart';
import 'package:care_life/view/components/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AdminAddEvent extends StatefulWidget {
  const AdminAddEvent({super.key});

  @override
  State<AdminAddEvent> createState() => _AdminAddEventState();
}

class _AdminAddEventState extends State<AdminAddEvent> {
  final TextEditingController title = TextEditingController();
  final TextEditingController venue = TextEditingController();
  final TextEditingController time = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController date = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    venue.dispose();
    time.dispose();
    description.dispose();
    date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(
            maxHeight: double.infinity,
            maxWidth: 500,
          ),
          child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('events').get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final snap = snapshot.data!.docs[index];
                    return ListTile(
                      leading: Column(
                        children: [
                          Text('${snap['date']}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.blue)),
                          Text('${snap['time']}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.orange)),
                        ],
                      ),
                      title: Text('${snap['title']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${snap['venue']}'),
                          Text('${snap['description']}'),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          context.read<AdminProvider>().deleteEvent(snap.id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewEvent(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> addNewEvent(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(18.0),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: 500,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add New Event',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  ListTile(
                    title: const Text('Pick Date'),
                    trailing: IconButton(
                      onPressed: () async {
                        DateTime? eventDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2025),
                        );
                        date.text = dateFormatter(eventDate!);
                      },
                      icon: const Icon(Icons.calendar_month_outlined),
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(controller: title, label: 'title'),
                  const SizedBox(height: 8),
                  CustomTextField(controller: venue, label: 'venue'),
                  const SizedBox(height: 8),
                  CustomTextField(controller: time, label: 'time'),
                  const SizedBox(height: 8),
                  CustomTextField(
                      controller: description, label: 'description'),
                  const SizedBox(height: 15),
                  MyButton(
                    child: 'Add Event',
                    onTap: () {
                      context.read<MyProvider>().toggle();
                      context
                          .read<AdminProvider>()
                          .addEvent(
                            EventModel(
                              title: title.text,
                              venue: venue.text,
                              time: time.text,
                              date: date.text,
                              description: description.text,
                            ),
                          )
                          .then((value) {
                        title.clear();
                        venue.clear();
                        time.clear();
                        description.clear();
                        date.clear();
                        context.read<MyProvider>().toggle();
                        Get.back();
                      }).onError((error, stackTrace) =>
                              context.read<MyProvider>().toggle());
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
