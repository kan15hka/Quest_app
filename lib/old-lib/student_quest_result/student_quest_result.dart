import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quest/constant.dart';
import 'package:quest/student/completed_quest.dart';
import 'package:quest/student/incomplete_quest.dart';
import 'package:quest/student_quest_result/quest_result_end.dart';

class StudentQuestResult extends StatefulWidget {
  final String topic;
  final String desc;
  final String score;
  const StudentQuestResult(
      {super.key,
      required this.topic,
      required this.desc,
      required this.score});

  @override
  State<StudentQuestResult> createState() => _StudentQuestResultState();
}

class _StudentQuestResultState extends State<StudentQuestResult> {
  final firestoreInstance = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference _teacherquest =
      FirebaseFirestore.instance.collection('teacherquest');
  final CollectionReference _student =
      FirebaseFirestore.instance.collection('student');

  String userName = '';
  String userEmail = '';
  String imageUrl = '';
  String rollno = '';
  String department = '';

  List krows = [];
  int inde = 0;
  int findex = 0;
  int i = 0;
  FetchIndex(String email) async {
    bool exist = false;
    final records =
        await FirebaseFirestore.instance.collection('student').get();
    krows = records.docs.map((e) => e.data()).toList();
    if (krows.isEmpty) {
      print('Databse Empty!!');
    } else {
      for (i = 0; i < krows.length; i++) {
        if (krows[i]['email'].toString() == email.toString()) {
          exist = true;
          inde = i;
        }
      }
      if (exist) {
        setState(() {
          findex = inde;
          userName = krows[findex]['name'].toString();
          userEmail = krows[findex]['email'].toString();
          imageUrl = krows[findex]['imageUrl'].toString();
          department = krows[findex]['department'].toString();
          rollno = krows[findex]['rollno'].toString();
        });
      }
    }
  }

  String teacherquestDocumentId = '';
  String topic = '';
  String desc = '';
  String email = '';
  String name = '';
  String qimageUrl = '';
  String qcount = '';
  int index = 0;
  void documentId() async {
    DocumentSnapshot documentSnapshot;
    CollectionReference teacherquestCollection =
        firestoreInstance.collection('teacherquest');
    var querySnapshot = await teacherquestCollection.get();
    querySnapshot.docs.forEach((doc) async {
      var docId = doc.id;
      await teacherquestCollection.doc(docId).get().then((value) {
        documentSnapshot = value;
        if (documentSnapshot['topic'] == widget.topic) {
          setState(() {
            teacherquestDocumentId = docId;
            topic = documentSnapshot['topic'];
            desc = documentSnapshot['desc'];
            email = documentSnapshot['email'];
            name = documentSnapshot['name'];
            qimageUrl = documentSnapshot['qimageUrl'];
            qcount = documentSnapshot['qcount'];
          });
        }
      });

      // do something with the document ID
    });
  }

  List qrows = [];
  getData() async {
    // Get docs from collection reference
    final CollectionReference _qna =
        _teacherquest.doc(teacherquestDocumentId).collection('qna');
    final qrecords = await _qna.get();

    setState(() {
      qrows = qrecords.docs.map((e) => e.data()).toList();
    });
  }

  bool isPressed = false;
  bool answerCorrectA = false;
  bool answerCorrectB = false;
  bool answerCorrectC = false;
  bool answerCorrectD = false;
  void CheckCorrectAnswer(int i) {
    if (qrows[i]['answera'] == qrows[i]['answer']) {
      setState(() {
        answerCorrectA = true;
        answerCorrectB = false;
        answerCorrectC = false;
        answerCorrectD = false;
      });
    } else if (qrows[i]['answerb'] == qrows[i]['answer']) {
      setState(() {
        answerCorrectA = false;
        answerCorrectB = true;
        answerCorrectC = false;
        answerCorrectD = false;
      });
    } else if (qrows[i]['answerc'] == qrows[i]['answer']) {
      setState(() {
        answerCorrectA = false;
        answerCorrectB = false;
        answerCorrectC = true;
        answerCorrectD = false;
      });
    } else if (qrows[i]['answerd'] == qrows[i]['answer']) {
      setState(() {
        answerCorrectA = false;
        answerCorrectB = false;
        answerCorrectC = false;
        answerCorrectD = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //tab controllers for tab bar
    documentId();
    getData();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Stream Bulder one Profile
              StreamBuilder(
                stream: _student.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot1) {
                  if (streamSnapshot1.hasData) {
                    FetchIndex(user.email!);

                    final DocumentSnapshot documentSnapshot1 =
                        streamSnapshot1.data!.docs[findex];
                    Size size = MediaQuery.of(context).size;
                    return Column(
                      children: [
                        Container(
                          height: size.height * 0.15,
                          child: Stack(
                            children: [
                              Container(
                                height: size.height * 0.15,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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

              Column(children: [
                Text(
                  widget.topic,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kTitleTextPurpleColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: font),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  widget.desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kTitleTextBlueColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: font),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  color: kTitleTextBlueColor,
                  thickness: 2.0,
                ),
                Text(
                  userName +
                      'answered ${int.parse(widget.score)} out of ${int.parse(qcount)} and secured ${int.parse(widget.score) * 5} marks with ${(int.parse(widget.score) / int.parse(qcount)) * 100}%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kTitleTextBlueColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: font),
                ),

                SizedBox(
                  height: 10.0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Question ${index + 1}/${int.parse(qcount)}:",
                        style: kquizTextStyle),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                // QnA Container
                Column(children: [
                  Container(
                    height: size.height * 0.51,
                    width: size.width * 0.9,
                    child: Card(
                      color: kSecondaryColor,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: kTitleTextBlueColor, width: 2.0),
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              alignment: Alignment.center,
                              child: Text(
                                qrows[index]['question'],
                                style: TextStyle(
                                    fontSize: 19.0,
                                    fontFamily: font,
                                    fontWeight: FontWeight.w500,
                                    color: kTitleTextBlueColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ////////////////////////////////////////////////////////////////
                            //Answer A
                            ListTile(
                              trailing: isPressed
                                  ? (answerCorrectA == true)
                                      ? ClipOval(
                                          child: Container(
                                              color: kGreenColor,
                                              padding: EdgeInsets.all(1.0),
                                              child: Icon(Icons
                                                  .check_circle_outline_rounded)),
                                        )
                                      : ClipOval(
                                          child: Container(
                                              color: kRedColor,
                                              padding: EdgeInsets.all(1.0),
                                              child: Icon(Icons.close_rounded)),
                                        )
                                  : Icon(
                                      Icons.circle,
                                      size: 2.0,
                                    ),
                              title: Text(
                                "A)  " + qrows[index]['answera'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: font,
                                  fontSize: 17.0,
                                  color: isPressed
                                      ? kPrimaryColor
                                      : kTitleTextBlueColor,
                                ),
                              ),
                              tileColor: isPressed
                                  ? (answerCorrectA)
                                      ? kGreenColor.withOpacity(0.5)
                                      : kRedColor.withOpacity(0.5)
                                  : kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                    color: isPressed
                                        ? (answerCorrectA)
                                            ? kGreenColor
                                            : kRedColor
                                        : kTitleTextBlueColor,
                                    width: 2.0),
                              ),
                              onTap: () {
                                CheckCorrectAnswer(index);
                              },
                            ),
                            ////////////////////////////////////////////////////////////////
                            //Answer B
                            ListTile(
                              trailing: isPressed
                                  ? (answerCorrectB == true)
                                      ? ClipOval(
                                          child: Container(
                                              color: kGreenColor,
                                              padding: EdgeInsets.all(1.0),
                                              child: Icon(Icons
                                                  .check_circle_outline_rounded)),
                                        )
                                      : ClipOval(
                                          child: Container(
                                              color: kRedColor,
                                              padding: EdgeInsets.all(1.0),
                                              child: Icon(Icons.close_rounded)),
                                        )
                                  : Icon(
                                      Icons.circle,
                                      size: 2.0,
                                    ),
                              title: Text(
                                "B)  " + qrows[index]['answerb'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: font,
                                  fontSize: 17.0,
                                  color: isPressed
                                      ? kPrimaryColor
                                      : kTitleTextBlueColor,
                                ),
                              ),
                              tileColor: isPressed
                                  ? (answerCorrectB)
                                      ? kGreenColor.withOpacity(0.5)
                                      : kRedColor.withOpacity(0.5)
                                  : kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                    color: isPressed
                                        ? (answerCorrectB)
                                            ? kGreenColor
                                            : kRedColor
                                        : kTitleTextBlueColor,
                                    width: 2.0),
                              ),
                              onTap: () {
                                CheckCorrectAnswer(index);
                              },
                            ),
                            ////////////////////////////////////////////////////////////////
                            //Answer C
                            ListTile(
                              trailing: isPressed
                                  ? (answerCorrectC == true)
                                      ? ClipOval(
                                          child: Container(
                                              color: kGreenColor,
                                              padding: EdgeInsets.all(1.0),
                                              child: Icon(Icons
                                                  .check_circle_outline_rounded)),
                                        )
                                      : ClipOval(
                                          child: Container(
                                              color: kRedColor,
                                              padding: EdgeInsets.all(1.0),
                                              child: Icon(Icons.close_rounded)),
                                        )
                                  : Icon(
                                      Icons.circle,
                                      size: 2.0,
                                    ),
                              title: Text(
                                "C)  " + qrows[index]['answerc'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: font,
                                  fontSize: 17.0,
                                  color: isPressed
                                      ? kPrimaryColor
                                      : kTitleTextBlueColor,
                                ),
                              ),
                              tileColor: isPressed
                                  ? (answerCorrectC)
                                      ? kGreenColor.withOpacity(0.5)
                                      : kRedColor.withOpacity(0.5)
                                  : kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                    color: isPressed
                                        ? (answerCorrectC)
                                            ? kGreenColor
                                            : kRedColor
                                        : kTitleTextBlueColor,
                                    width: 2.0),
                              ),
                              onTap: () {
                                CheckCorrectAnswer(index);
                              },
                            ),
                            ////////////////////////////////////////////////////////////////
                            //Answer D
                            ListTile(
                              trailing: isPressed
                                  ? (answerCorrectD == true)
                                      ? ClipOval(
                                          child: Container(
                                              color: kGreenColor,
                                              padding: EdgeInsets.all(1.0),
                                              child: Icon(Icons
                                                  .check_circle_outline_rounded)),
                                        )
                                      : ClipOval(
                                          child: Container(
                                              color: kRedColor,
                                              padding: EdgeInsets.all(1.0),
                                              child: Icon(Icons.close_rounded)),
                                        )
                                  : Icon(
                                      Icons.circle,
                                      size: 2.0,
                                    ),
                              title: Text(
                                "D)  " + qrows[index]['answerd'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: font,
                                  fontSize: 17.0,
                                  color: isPressed
                                      ? kPrimaryColor
                                      : kTitleTextBlueColor,
                                ),
                              ),
                              tileColor: isPressed
                                  ? (answerCorrectD)
                                      ? kGreenColor.withOpacity(0.5)
                                      : kRedColor.withOpacity(0.5)
                                  : kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                    color: isPressed
                                        ? (answerCorrectD)
                                            ? kGreenColor
                                            : kRedColor
                                        : kTitleTextBlueColor,
                                    width: 2.0),
                              ),
                              onTap: () {
                                CheckCorrectAnswer(index);
                              },
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            //Answers
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  //padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.35,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kSecondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                side: BorderSide(
                                    color: kTitleTextBlueColor, width: 2.0)),
                            onPressed: () {
                              setState(() {
                                isPressed = true;
                                CheckCorrectAnswer(index);
                              });
                            },
                            child: Text(
                              "View Result",
                              style: kquizTextStyle,
                            )),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Container(
                        width: size.width * 0.35,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kSecondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                side: BorderSide(
                                    color: kTitleTextBlueColor, width: 2.0)),
                            onPressed: () {
                              setState(() {
                                isPressed = false;
                                answerCorrectA = false;
                                answerCorrectB = false;
                                answerCorrectC = false;
                                answerCorrectD = false;
                                if (index == int.parse(qcount) - 1) {
                                  showDialog(
                                      context: context,
                                      builder: ((ctx) => QuestResultEnd(
                                            semail: userEmail,
                                            sname: userName,
                                            topic: topic,
                                            desc: desc,
                                          )));
                                } else {
                                  index = (index + 1);
                                }
                              });
                            },
                            child: Text(
                              "Next Quest",
                              style: kquizTextStyle,
                            )),
                      ),
                    ],
                  ),
                ),
              ]),
              SizedBox(
                height: 30.0,
              ),
              Divider(
                color: kTitleTextBlueColor,
                thickness: 2.0,
              ),
            ],
          ),
        ));
  }
}
