import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quest/constant.dart';
import 'package:quest/student/student_screen.dart';
import 'package:quest/teacher/teacher_screen.dart';
import 'package:quest/teacher_student/add_student_details.dart';
import 'package:quest/teacher_student/add_teacher_details.dart';

class TeacherStudentPage extends StatefulWidget {
  TeacherStudentPage({super.key});

  @override
  State<TeacherStudentPage> createState() => _TeacherStudentPageState();
}

class _TeacherStudentPageState extends State<TeacherStudentPage> {
  final user = FirebaseAuth.instance.currentUser!;
  String userName = '';
  String userEmail = '';
  String userStatus = '';
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  //intialise the methods on Paage start

  //intialise collectionvariable
  final CollectionReference _teachstu =
      FirebaseFirestore.instance.collection('teachstu');

  //Fetch name from the database
  List rows = [];
  int inde = 0;
  int index = 0;
  int i = 0;

  FetchIndex(String email) async {
    bool exist = false;
    final records =
        await FirebaseFirestore.instance.collection('teachstu').get();
    rows = records.docs.map((e) => e.data()).toList();
    if (rows.isEmpty) {
      print('Databse Empty!!');
    } else {
      for (i = 0; i < rows.length; i++) {
        if (rows[i]['email'].toString() == email.toString()) {
          exist = true;
          inde = i;
        }
      }
      if (exist) {
        setState(() {
          index = inde;
          userName = rows[index]['name'].toString();
          userEmail = rows[index]['email'].toString();
          userStatus = rows[index]['status'].toString();
        });
      }
    }
  }

  // Student on tap method
  Future<void> OnTapStudent([DocumentSnapshot? documentSnapshot]) async {
    await _teachstu.doc(documentSnapshot!.id).update(
      {
        "name": rows[index]['name'].toString(),
        "email": rows[index]['email'].toString(),
        "status": 'student',
      },
    );
    AddStudentDetails(userName, userEmail, context);
  }

  Future<void> OnTapTeacher([DocumentSnapshot? documentSnapshot]) async {
    await _teachstu.doc(documentSnapshot!.id).update(
      {
        "name": rows[index]['name'].toString(),
        "email": rows[index]['email'].toString(),
        "status": 'teacher',
      },
    );
    AddTeacherDetails(userName, userEmail, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kSecondaryColor,
        actions: [
          IconButton(
              onPressed: signUserOut,
              icon: Icon(
                Icons.logout,
                color: kTitleTextBlueColor,
              ))
        ],
      ),
      body: StreamBuilder(
        stream: _teachstu.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            FetchIndex(user.email!);
            final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index.toInt()];
            Size size = MediaQuery.of(context).size;

            return Column(
              children: [
                Container(
                  height: size.height * 0.2,
                  child: Stack(
                    children: [
                      Container(
                        height: size.height * 0.2 - 20,
                        decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 40.0, top: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Welcome, " + userName,
                                style: TextStyle(
                                    color: kTitleTextBlueColor,
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: font),
                              ),
                            ),
                            ImageIcon(
                              AssetImage("assets/blogo.png"),
                              color: kTitleTextBlueColor,
                              size: 75.0,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0,
                        right: 0,
                        child: Container(
                          child: Center(
                            child: Text(
                              'Logged in as ' + userEmail,
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: font),
                            ),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 30.0),
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: kTitleTextBlueColor,
                            borderRadius: BorderRadius.circular(20.0),
                            border:
                                Border.all(color: kPrimaryColor, width: 3.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 70.0,
                ),
                Text(
                  'Select your role',
                  style: TextStyle(
                      color: kTitleTextBlueColor,
                      fontSize: 20.0,
                      fontFamily: font),
                ),
                SizedBox(
                  height: 60.0,
                ),
                GestureDetector(
                  onTap: () => OnTapTeacher(documentSnapshot),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: kSecondaryColor,
                      border:
                          Border.all(color: kTitleTextBlueColor, width: 2.0),
                    ),
                    padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                    child: Text(
                      'TEACHER',
                      style: TextStyle(
                          color: kTitleTextBlueColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: font),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                GestureDetector(
                  onTap: () => OnTapStudent(documentSnapshot),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border:
                            Border.all(color: kTitleTextBlueColor, width: 2.0),
                        color: kSecondaryColor),
                    padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                    child: Text(
                      'STUDENT',
                      style: TextStyle(
                          color: kTitleTextBlueColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: font),
                    ),
                  ),
                ),
              ],
            );
          }
          //
          //}
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
