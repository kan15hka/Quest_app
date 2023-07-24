import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quest/constant.dart';
import 'package:quest/teacher/answer_quest_teacher.dart';
import 'package:quest/teacher/create_quest_teacher.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen>
    with TickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference _teacherquiz =
      FirebaseFirestore.instance.collection('teacherquiz');
  final CollectionReference _teacher =
      FirebaseFirestore.instance.collection('teacher');

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  String userName = '';
  String userEmail = '';
  String imageUrl = '';
  String id = '';
  String department = '';

  List rows = [];
  int inde = 0;
  int index = 0;
  int i = 0;
  void signUserOut(BuildContext context) {
    // Navigator.pop(context);
    setState(() {
      userName = '';
      userEmail = '';
      imageUrl = '';
      id = '';
      department = '';
    });
    FirebaseAuth.instance.signOut();
  }

  FetchIndex(String email) async {
    bool exist = false;
    final records =
        await FirebaseFirestore.instance.collection('teacher').get();
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
          imageUrl = rows[index]['imageUrl'].toString();
          department = rows[index]['department'].toString();
          id = rows[index]['id'].toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //tab controllers for tab bar

    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => signUserOut(context),
                icon: Icon(
                  Icons.logout,
                  color: kTitleTextBlueColor,
                ))
          ],
          elevation: 0.0,
          title: Text(
            "TEACHER PROFILE",
            style: TextStyle(
                color: kOrangeColor,
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                fontFamily: font),
          ),
          centerTitle: true,
          backgroundColor: kSecondaryColor,
        ),
        body: Column(
          children: [
            // Stream Bulder one Profile
            StreamBuilder(
              stream: _teacher.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot1) {
                if (streamSnapshot1.hasData) {
                  FetchIndex(user.email!);

                  final DocumentSnapshot documentSnapshot1 =
                      streamSnapshot1.data!.docs[index.toInt()];
                  Size size = MediaQuery.of(context).size;
                  return Column(
                    children: [
                      Container(
                        height: size.height * 0.2 - 35,
                        child: Stack(
                          children: [
                            Container(
                              height: size.height * 0.2 - 35,
                              decoration: BoxDecoration(
                                  color: kSecondaryColor,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(40.0),
                                      bottomRight: Radius.circular(40.0))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40.0, right: 40.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 52.0,
                                    backgroundColor: kOrangeColor,
                                    child: CircleAvatar(
                                      backgroundColor: kSecondaryColor,
                                      backgroundImage: NetworkImage(imageUrl),
                                      radius: 50.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.1,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        documentSnapshot1['name'],
                                        style: kTeacherTextStyle,
                                      ),
                                      Text(
                                        documentSnapshot1['email'],
                                        style: kTeacherTextStyle,
                                      ),
                                      Text(
                                        documentSnapshot1['id'],
                                        style: kTeacherTextStyle,
                                      ),
                                      Text(
                                        documentSnapshot1['department'],
                                        style: kTeacherTextStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),

            SizedBox(
              height: 5.0,
            ),
            // Tab Bar
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              elevation: 0.0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kTitleTextBlueColor, width: 2.0),
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(12)),
                child: TabBar(
                    indicator: BoxDecoration(
                        border:
                            Border.all(color: kTitleTextBlueColor, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                        color: kSecondaryColor),
                    controller: _tabController,
                    isScrollable: true,
                    labelPadding: EdgeInsets.symmetric(horizontal: 40.0),
                    tabs: [
                      Tab(
                          child: Text(
                        'Quest Created',
                        style: kTeacherTitleTextStyle,
                      )),
                      Tab(
                          child: Text(
                        'Quest Answered',
                        style: kTeacherTitleTextStyle,
                      ))
                    ]),
              ),
            ),

            //Tab bar view
            Flexible(
                child: TabBarView(
              controller: _tabController,
              children: [
                //First TabBarView
                //Quest craeted by teachers
                CreateQuestTeacher(
                    name: userName, email: userEmail, imageUrl: imageUrl),
                //Second TabBarView
                //quiz answered students
                AnswerQuestTeacher(userEmail: userEmail)
              ],
            ))
          ],
        ));
  }
}
