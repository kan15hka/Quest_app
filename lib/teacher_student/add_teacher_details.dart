import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quest/constant.dart';
import 'package:quest/teacher/teacher_screen.dart';

//text editig controllers
TextEditingController _idController = TextEditingController();
TextEditingController _departmentController = TextEditingController();

final user = FirebaseAuth.instance.currentUser!;

//teacher _teacher collection reference
final CollectionReference _teacher =
    FirebaseFirestore.instance.collection('teacher');
String imageUrl = '';
bool imageFound = false;
File? imgFile;
List semail = [];

//add teacher info only if it does not exist
Future<void> AddInfo(
    String name, String email, BuildContext context, BuildContext ctx) async {
  final String id = _idController.text;
  final String department = _departmentController.text;
  bool exist = false;
  final records = await FirebaseFirestore.instance.collection('teacher').get();
  semail = records.docs.map((e) => e.data()).toList();

  if (semail.isEmpty) {
    await _teacher.add({
      "name": name,
      "email": email,
      "id": id.toString(),
      "department": department.toString(),
      "imageUrl": (user.photoURL != null)
          ? user.photoURL.toString()
          : imageUrl.toString()
    });
  } else {
    for (var i = 0; i < semail.length; i++) {
      if (semail[i]['email'].toString() == email.toString()) {
        exist = true;
      }
    }
    if (!exist) {
      await _teacher.add({
        "name": name,
        "email": email,
        "id": id.toString(),
        "department": department.toString(),
        "imageUrl": (user.photoURL != null)
            ? user.photoURL.toString()
            : imageUrl.toString()
      });
    }
  }
  Navigator.pop(ctx);
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const TeacherScreen()),
  );
}

//Pick image method
Future<void> PickImage(String name) async {
  // Step 1: Import image from library
  ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  print('${file?.path}');
  //Step 2: upload image to firebase
  //Get a reference to storage root
  if (file == null) {
    imageFound = false;
  } else {
    imageFound = true;
  }
  print(imageFound);
  Reference referenceRoot = FirebaseStorage.instance.ref();
  Reference referenceDirImages = referenceRoot.child('images/teacher');
  // //create refernce for the image to be stored
  Reference referenceImageToUpload = referenceDirImages.child(name.toString());
  imgFile = File(file!.path);
  if (imgFile == null) {
    imageFound = false;
  } else {
    imageFound = true;
  }
  print(imageFound);
  // //Store the file
  // // Step 3:get Download URL
  try {
    await referenceImageToUpload.putFile(File(file.path));
    imageUrl = await referenceImageToUpload.getDownloadURL();
  } catch (error) {
    print('Error while uploading image: $error');
  }
}

void AddTeacherDetails(String name, String email, BuildContext context) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0))),
      backgroundColor: kSecondaryColor,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  (imgFile != null)
                      ? CircleAvatar(
                          radius: 62.0,
                          backgroundColor: kOrangeColor,
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: FileImage(
                              imgFile!,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 62.0,
                          backgroundColor: kOrangeColor,
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: AssetImage(
                              'assets/profile.jpg',
                            ),
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: ClipOval(
                      child: GestureDetector(
                        onTap: () => PickImage(name),
                        child: Container(
                          padding: EdgeInsets.all(7.0),
                          child: Icon(
                            Icons.edit,
                            color: kTitleTextBlueColor,
                          ),
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                style: TextStyle(
                    color: kTitleTextBlueColor,
                    fontFamily: font,
                    fontSize: 20.0),
                controller: _idController,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kTitleTextBlueColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kTitleTextBlueColor),
                    ),
                    labelText: 'Teacher Id',
                    labelStyle: TextStyle(
                        color: kTitleTextBlueColor,
                        fontFamily: font,
                        fontSize: 17.0)),
              ),
              TextField(
                style: TextStyle(
                    color: kTitleTextBlueColor,
                    fontFamily: font,
                    fontSize: 20.0),
                controller: _departmentController,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kTitleTextBlueColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kTitleTextBlueColor),
                    ),
                    labelText: 'Department',
                    labelStyle: TextStyle(
                        color: kTitleTextBlueColor,
                        fontFamily: font,
                        fontSize: 17.0)),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                child: const Text('Add',
                    style: TextStyle(
                        color: kTitleTextBlueColor,
                        fontFamily: font,
                        fontSize: 20.0)),
                onPressed: () async {
                  await AddInfo(name, email, context, ctx);
                },
              )
            ],
          ),
        );
      });
}
