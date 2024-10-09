import 'package:care_life/model/event_model.dart';
import 'package:care_life/model/old_home_model.dart';
import 'package:care_life/utility/toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AdminProvider extends ChangeNotifier {
  final _eventCollection = FirebaseFirestore.instance.collection('events');
  final _homesCollection = FirebaseFirestore.instance.collection('oldHomes');
  final _reference = FirebaseStorage.instance.ref();

  final ImagePicker _picker = ImagePicker();

  File? file;
  Uint8List? imageData;
  String typeOfHome = "";

  ///for getting the type
  void selectTypeOfHome(String type) {
    typeOfHome += "$type, ";
    notifyListeners();
  }

  /// for add new event
  Future<void> addEvent(EventModel event) async {
    try {
      final doc = _eventCollection.doc();
      final docId = doc.id;
      EventModel newEvent = EventModel(
        id: docId,
        title: event.title,
        venue: event.venue,
        time: event.time,
        date: event.date,
        description: event.description,
      );
      await doc.set(newEvent.toJson());
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }

  ///for delete existing event after done
  Future<void> deleteEvent(String id) async {
    try {
      await _eventCollection.doc(id).delete();
    } catch (e) {
      throw e.toString();
    }
  }

  /// for adding new old age home or orphanage
  Future<void> addOldHome(OldHomeModel home) async {
    try {
      final doc = _homesCollection.doc();
      final docId = doc.id;
      final OldHomeModel oldHomeModel = OldHomeModel(
        id: docId,
        name: home.name,
        number: home.number,
        address: home.address,
        image: await _uploadImageToServer(home.name!),
        lat: home.lat,
        long: home.long,
        mail: home.mail,
        needs: home.needs,
      );

      await doc.set(oldHomeModel.toJson());
    } catch (e) {
      sendToastMessage(message: e.toString());
    }
  }

  ///for pick image from gallery
  Future<void> pickImageFromGallery() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      if (kIsWeb) {
        imageData = await pickedImage.readAsBytes();
        notifyListeners();
      }
      file = File(pickedImage.path);
      notifyListeners();
    }
  }

  ///for upload selected image to firebase storage
  Future<String> _uploadImageToServer(String title) async {
    late UploadTask uploadTask;
    try {
      Reference path = _reference.child("homes/$title");
      if (file != null) {
        uploadTask = path.putFile(file!);
      } else if (kIsWeb && imageData != null) {
        uploadTask = path.putData(imageData!);
      }
      await uploadTask.whenComplete(() => null);
      final urlPath = await path.getDownloadURL();
      return urlPath;
    } catch (e) {
      throw e.toString();
    }
  }
}
