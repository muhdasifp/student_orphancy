import 'package:care_life/controller/admin_provider.dart';
import 'package:care_life/controller/my_provider.dart';
import 'package:care_life/data/images.dart';
import 'package:care_life/model/old_home_model.dart';
import 'package:care_life/utility/toast_message.dart';
import 'package:care_life/view/components/button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminAddNew extends StatefulWidget {
  const AdminAddNew({super.key});

  @override
  State<AdminAddNew> createState() => _AdminAddNewState();
}

class _AdminAddNewState extends State<AdminAddNew> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController needsController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    needsController.dispose();
    numberController.dispose();
    mailController.dispose();
    latController.dispose();
    longController.dispose();
    addressController.dispose();
    typeController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final admin = Provider.of<AdminProvider>(context);
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15.0),
              constraints: const BoxConstraints(
                maxHeight: double.infinity,
                maxWidth: 500,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    kIsWeb
                        ? InkWell(
                            onTap: () {
                              admin.pickImageFromGallery();
                            },
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: admin.imageData != null
                                  ? Image.memory(admin.imageData!)
                                  : Image.asset(noImagePng),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              admin.pickImageFromGallery();
                            },
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: admin.file != null
                                  ? Image.file(admin.file!)
                                  : Image.asset(noImagePng),
                            ),
                          ),
                    TextFormField(
                      validator: validation,
                      controller: nameController,
                      decoration: const InputDecoration(hintText: 'name'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: validation,
                      controller: needsController,
                      maxLines: 3,
                      decoration: const InputDecoration(hintText: 'needs'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: validation,
                      controller: numberController,
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(hintText: 'contact number'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: validation,
                      controller: mailController,
                      decoration: const InputDecoration(hintText: 'contact mail'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: validation,
                      controller: typeController,
                      decoration: InputDecoration(
                        hintText: 'type..',
                        suffixIcon: IconButton(
                            onPressed: () {
                              admin.selectTypeOfHome(typeController.text);
                            },
                            icon: const Icon(Icons.add)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: validation,
                      controller: latController,
                      decoration: const InputDecoration(hintText: 'latitude'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: validation,
                      controller: longController,
                      decoration: const InputDecoration(hintText: 'longitude'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: validation,
                      controller: addressController,
                      maxLines: 2,
                      decoration: const InputDecoration(hintText: 'address'),
                    ),
                    const SizedBox(height: 20),
                    MyButton(
                      child: 'Save',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<MyProvider>().toggle();
                          admin
                              .addOldHome(OldHomeModel(
                            name: nameController.text,
                            number: numberController.text,
                            address: addressController.text,
                            lat: latController.text,
                            long: longController.text,
                            needs: needsController.text,
                            mail: mailController.text,
                            type: typeController.text,
                          ))
                              .then((value) {
                            context.read<MyProvider>().toggle();
                            nameController.clear();
                            needsController.clear();
                            numberController.clear();
                            mailController.clear();
                            latController.clear();
                            longController.clear();
                            addressController.clear();
                            typeController.clear();
                          }).onError((error, stackTrace) {
                            sendToastMessage(message: error.toString());
                            context.read<MyProvider>().toggle();
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String? validation(String? value) {
    if (value!.isEmpty) {
      return 'Field is required';
    } else {
      return null;
    }
  }
}
