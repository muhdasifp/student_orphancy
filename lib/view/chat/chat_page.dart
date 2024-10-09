import 'package:care_life/controller/user_provider.dart';
import 'package:care_life/model/chat_model.dart';
import 'package:care_life/view/components/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  const ChatPage({super.key, required this.userName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();

  ScrollController scrollController = ScrollController();

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scrollController.addListener(() => scrollController.animateTo(
        double.maxFinite,
        duration: const Duration(milliseconds: 200),
        curve: Curves.decelerate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index];
                        if (data['sender'] == widget.userName) {
                          return ChatBubble(
                            alignment: Alignment.centerRight,
                            color: Colors.orange.shade50,
                            sender: data['sender'],
                            message: data['message'],
                            time: data['time'],
                          );
                        }
                        return ChatBubble(
                          alignment: Alignment.centerLeft,
                          color: Colors.blue.shade50,
                          sender: data['sender'],
                          message: data['message'],
                          time: data['time'],
                        );
                      },
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: Text('No Data Found'));
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('Request is Empty'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const Center(child: Text('Something went wrong'));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.chat),
                        hintText: 'type something',
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<UserProvider>(context, listen: false)
                          .sendMessage(ChatModel(
                            message: messageController.text,
                            sender: widget.userName,
                          ))
                          .then((value) => messageController.clear());
                    },
                    icon: const Icon(Icons.send, color: Colors.blue),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
