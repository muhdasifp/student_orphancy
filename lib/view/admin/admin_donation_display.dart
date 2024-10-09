import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminDonationDisplay extends StatelessWidget {
  const AdminDonationDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 500,
          maxHeight: double.infinity,
        ),
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('donations').get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final snap = snapshot.data!.docs[index];
                  return Card(
                    child: ListTile(
                      leading: Text('₹${snap['amount']}'),
                      title: Text("${snap['user']}".toUpperCase()),
                      subtitle: Text("${snap['home']}"),
                      trailing: Text('${snap['data']}'),
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
    );
  }
}
