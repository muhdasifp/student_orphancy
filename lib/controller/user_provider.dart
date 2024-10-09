import 'package:care_life/model/chat_model.dart';
import 'package:care_life/model/event_model.dart';
import 'package:care_life/model/old_home_model.dart';
import 'package:care_life/model/request_model.dart';
import 'package:care_life/model/user_model.dart';
import 'package:care_life/utility/date_formatter.dart';
import 'package:care_life/utility/toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final _userCollection = FirebaseFirestore.instance.collection('users');
  final _eventCollection = FirebaseFirestore.instance.collection('events');
  final _messageCollection = FirebaseFirestore.instance.collection('messages');
  final _requestCollection = FirebaseFirestore.instance.collection('requests');
  final _oldHomesCollection = FirebaseFirestore.instance.collection('oldHomes');
  final _donationCollection =
      FirebaseFirestore.instance.collection('donations');
  final _currentUser = FirebaseAuth.instance.currentUser!.uid;

  late UserModel currentUser;
  List<EventModel> allEvents = [];

  List<OldHomeModel> allOldHomes = [];
  List<OldHomeModel> tempOldHomes = [];

  ///for getting current user info
  Future<UserModel> getUserProfile() async {
    try {
      final snap = await _userCollection.doc(_currentUser).get();
      if (snap.exists) {
        final user = UserModel.fromJson(snap);
        currentUser = user;
        notifyListeners();
        return user;
      } else {
        throw "user not found";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///for getting all events
  Future<List<EventModel>> getAllEvents() async {
    try {
      final snap = await _eventCollection.get();
      final events = snap.docs.map((doc) => EventModel.fromJson(doc)).toList();
      allEvents = events;
      notifyListeners();
      return events;
    } catch (e) {
      throw e.toString();
    }
  }

  /// to send message to send admin
  Future<void> sendMessage(ChatModel chat) async {
    try {
      if (chat.message!.isNotEmpty) {
        final doc = _messageCollection.doc();
        final docId = doc.id;
        await doc.set(
          ChatModel(
            id: docId,
            message: chat.message,
            sender: chat.sender,
            time: Timestamp.now(),
          ).toJson(),
        );
      }
    } catch (e) {
      throw e.toString();
    }
  }

  /// for sending request to admin
  Future<void> sendRequestToAdmin(String message, String home) async {
    try {
      final doc = _requestCollection.doc();
      final docId = doc.id;
      await doc.set(
        RequestModel(
          id: docId,
          message: message,
          oldHome: home,
          user: currentUser,
        ).toJson(),
      );
    } catch (e) {
      throw e.toString();
    }
  }

  /// for getting all old home and orphanage
  Future<void> getAllOldHome() async {
    try {
      var snap = await _oldHomesCollection.get();
      allOldHomes = snap.docs.map((e) => OldHomeModel.fromJson(e)).toList();
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  /// for search old homes
  Future<void> searchOldHome(String title) async {
    try {
      var snap = await _oldHomesCollection.get();
      List<OldHomeModel> tempList =
          snap.docs.map((e) => OldHomeModel.fromJson(e)).toList();
      tempOldHomes = tempList
          .where((element) =>
              element.name!.toLowerCase().startsWith(title.toLowerCase()))
          .toList();

      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  ///for send the donations to particular home
  Future<void> sendDonations(String amount, String home) async {
    try {
      await _donationCollection.add({
        "user": currentUser.name,
        "amount": amount,
        "home": home,
        "date": dateFormatter(DateTime.now())
      });
      sendToastMessage(message: 'Donated Successfully', color: Colors.green);
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }
}
