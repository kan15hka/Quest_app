import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quest/constant.dart';
import 'package:quest/student/completed_quest.dart';
import 'package:quest/student/incomplete_quest.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

void signUserOut(BuildContext context) {
  // Navigator.pop(context);
  FirebaseAuth.instance.signOut();
}

class _StudentScreenState extends State<StudentScreen>
    with TickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;

  final CollectionReference _student =
      FirebaseFirestore.instance.collection('student');

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
  String rollno = '';
  String department = '';

  List rows = [];
  int inde = 0;
  int index = 0;
  int i = 0;
  FetchIndex(String email) async {
    bool exist = false;
    final records =
        await FirebaseFirestore.instance.collection('student').get();
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
          rollno = rows[index]['rollno'].toString();
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
            "STUDENT PROFILE",
            style: TextStyle(
                color: kYellowColor,
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
              stream: _student.snapshots(),
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
                                    backgroundColor: kYellowColor,
                                    child: CircleAvatar(
                                      backgroundColor: kSecondaryColor,
                                      backgroundImage: NetworkImage(imageUrl),
                                      radius: 50.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        documentSnapshot1['name'],
                                        style: kStudentTextStyle,
                                      ),
                                      Text(
                                        documentSnapshot1['email'],
                                        style: kStudentTextStyle,
                                      ),
                                      Text(
                                        documentSnapshot1['rollno'],
                                        style: kStudentTextStyle,
                                      ),
                                      Text(
                                        documentSnapshot1['department'],
                                        style: kStudentTextStyle,
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
                        'Grab your Quest ',
                        style: kStudentTitleTextStyle,
                      )),
                      Tab(
                          child: Text(
                        'Quest Answered',
                        style: kStudentTitleTextStyle,
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
                IncompleteQuest(),
                //Second TabBarView
                //quiz answered students
                CompletedQuest(semail: userEmail, sname: userName)
              ],
            ))
          ],
        ));
  }
}
