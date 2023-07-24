import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quest/constant.dart';
import 'package:quest/teacher/teacher_screen.dart';
import 'package:quest/teacherquest/teacher_quest.dart';

//text editig controllers
TextEditingController _topicController = TextEditingController();
TextEditingController _qcountController = TextEditingController();
TextEditingController _descController = TextEditingController();

final user = FirebaseAuth.instance.currentUser!;

//teacher _teacher collection reference
final firestoreInstance = FirebaseFirestore.instance;
Future AddQuestInfo(String email, String name, String topic, String desc,
    String qcount, BuildContext context, BuildContext ctx) async {
  firestoreInstance.collection('teacherquest').add({
    "name": name,
    "email": email,
    "topic": topic,
    "desc": desc,
    "qcount": qcount,
    "qimageUrl": imageUrl.toString()
  });
  Navigator.pop(ctx);
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => TeacherQuest(
            email: email,
            topic: topic,
            desc: desc,
            qcount: qcount,
            qimageUrl: imageUrl.toString())),
  );
}

String imageUrl = '';
bool imageFound = false;
File? imgFile;
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
  Reference referenceDirImages = referenceRoot.child('images/questLogo');
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

void AddQuizDetails(String name, String email, BuildContext context) {
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
                              'assets/lblogo.png',
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
                controller: _topicController,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kTitleTextBlueColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kTitleTextBlueColor),
                    ),
                    labelText: 'Topic',
                    labelStyle: TextStyle(
                        color: kOrangeColor, fontFamily: font, fontSize: 17.0)),
              ),
              TextField(
                style: TextStyle(
                    color: kTitleTextBlueColor,
                    fontFamily: font,
                    fontSize: 20.0),
                controller: _descController,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kTitleTextBlueColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kTitleTextBlueColor),
                    ),
                    labelText: 'Quest Description',
                    labelStyle: TextStyle(
                        color: kOrangeColor, fontFamily: font, fontSize: 17.0)),
              ),
              TextField(
                style: TextStyle(
                    color: kTitleTextBlueColor,
                    fontFamily: font,
                    fontSize: 20.0),
                controller: _qcountController,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kTitleTextBlueColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kTitleTextBlueColor),
                    ),
                    labelText: 'Questions Count',
                    labelStyle: TextStyle(
                        color: kOrangeColor, fontFamily: font, fontSize: 17.0)),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    side:
                        const BorderSide(width: 2, color: kTitleTextBlueColor)),
                child: const Text('Add',
                    style: TextStyle(
                        color: kOrangeColor, fontFamily: font, fontSize: 20.0)),
                onPressed: () async {
                  await AddQuestInfo(
                      email,
                      name,
                      _topicController.text.toString(),
                      _descController.text.toString(),
                      _qcountController.text.toString(),
                      context,
                      ctx);
                },
              )
            ],
          ),
        );
      });
}
