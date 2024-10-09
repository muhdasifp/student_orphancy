import 'package:care_life/controller/user_provider.dart';
import 'package:care_life/data/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, event, _) {
          if (event.allEvents.isEmpty) {
            return const Center(
              child: Text('No Event Found'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: event.allEvents.length,
            itemBuilder: (context, index) {
              final events = event.allEvents[index];
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: primaryAppColor)),
                elevation: 3,
                child: ListTile(
                  leading: const FlutterLogo(),
                  title: Text('${events.title}',
                      style: const TextStyle(fontSize: 20)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${events.venue}'),
                      Text(
                        '${events.description}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${events.date}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.blue)),
                      Text('${events.time}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.orange)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
