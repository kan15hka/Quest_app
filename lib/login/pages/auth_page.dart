import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quest/login/pages/add_email.dart';
import 'package:quest/login/pages/home_page.dart';
import 'package:quest/login/pages/login_or_register_page.dart';
import 'package:quest/student/student_screen.dart';
import 'package:quest/teacher/teacher_screen.dart';
import 'package:quest/teacher_student/teacher_student.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String userName = '';
  String userEmail = '';
  String userStatus = '';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in

          if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser!;
            FetchIndex(user.email.toString());
            if (userStatus.toString() == 'student') {
              return StudentScreen();
            } else if (userStatus.toString() == 'teacher') {
              return TeacherScreen();
            } else {
              return TeacherStudentPage();
            }
          }
          //useris not logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
