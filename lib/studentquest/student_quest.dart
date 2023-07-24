import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quest/studentquest/result_box.dart';
import 'package:quest/constant.dart';

import 'ques_model.dart';

class StudentQuest extends StatefulWidget {
  final String qtopic;
  const StudentQuest({super.key, required this.qtopic});

  @override
  State<StudentQuest> createState() => _StudentQuestState();
}

class _StudentQuestState extends State<StudentQuest> {
  //collection reference
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference _teacherquest =
      FirebaseFirestore.instance.collection('teacherquest');
  final CollectionReference _studentquest =
      FirebaseFirestore.instance.collection('studentquest');
  final firestoreInstance = FirebaseFirestore.instance;

  // get documnet id
  String teacherquestDocumentId = '';
  String topic = '';
  String desc = '';
  String email = '';
  String name = '';
  String qimageUrl = '';
  String qcount = '';

  void documentId() async {
    DocumentSnapshot documentSnapshot;
    CollectionReference teacherquestCollection =
        firestoreInstance.collection('teacherquest');
    var querySnapshot = await teacherquestCollection.get();
    querySnapshot.docs.forEach((doc) async {
      var docId = doc.id;
      await teacherquestCollection.doc(docId).get().then((value) {
        documentSnapshot = value;
        if (documentSnapshot['topic'] == widget.qtopic) {
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

  bool answerCorrect = false;

  int index = 0;
  bool isPressed = false;
  int score = 0;
  void StartOver() {
    setState(() {
      isPressed = false;
      isPressedA = false;
      isPressedB = false;
      isPressedC = false;
      isPressedD = false;
      answerCorrectA = false;
      answerCorrectB = false;
      answerCorrectC = false;
      answerCorrectD = false;
      index = 0;
      isPressed = false;
      score = 0;
      second = 0;
      startTimer();
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    startTimer();
  }

  static int maxseconds = 60;
  int second = 0;
  late Timer timer;
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (second < 60) {
        setState(() {
          second++;
        });
      } else {
        setState(() {
          timer.cancel();
          showDialog(
              context: context,
              builder: ((ctx) => ResultBox(
                    mark: score * 5,
                    score: score,
                    total_question: int.parse(qcount),
                    onPressed: StartOver,
                  )));
        });
      }
    });
  }

  List rows = [];
  getData() async {
    // Get docs from collection reference
    final CollectionReference _qna =
        _teacherquest.doc(teacherquestDocumentId).collection('qna');
    final records = await _qna.get();

    setState(() {
      rows = records.docs.map((e) => e.data()).toList();
    });
  }

  bool isPressedA = false;
  bool isPressedB = false;
  bool isPressedC = false;
  bool isPressedD = false;
  bool answerCorrectA = false;
  bool answerCorrectB = false;
  bool answerCorrectC = false;
  bool answerCorrectD = false;
  void CheckCorrectAnswer(int i) {
    if (rows[i]['answera'] == rows[i]['answer']) {
      setState(() {
        answerCorrectA = true;
        answerCorrectB = false;
        answerCorrectC = false;
        answerCorrectD = false;
      });
    } else if (rows[i]['answerb'] == rows[i]['answer']) {
      setState(() {
        answerCorrectA = false;
        answerCorrectB = true;
        answerCorrectC = false;
        answerCorrectD = false;
      });
    } else if (rows[i]['answerc'] == rows[i]['answer']) {
      setState(() {
        answerCorrectA = false;
        answerCorrectB = false;
        answerCorrectC = true;
        answerCorrectD = false;
      });
    } else if (rows[i]['answerd'] == rows[i]['answer']) {
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
    documentId();

    getData();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "GRAB YOUR QUEST",
          style: TextStyle(
              color: kYellowColor,
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
              fontFamily: font),
        ),
        elevation: 0,
        backgroundColor: kSecondaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: kPrimaryColor,
          child: Column(children: [
            Container(
              height: size.height * 0.13,
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.13,
                    decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0))),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          topic,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kTitleTextPurpleColor,
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: font),
                        ),
                        Text(
                          desc,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kTitleTextBlueColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: font),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                      ],
                    ),
                  ),
                  //Progress Bar
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: LinearPercentIndicator(
                        width: size.width * 0.9,
                        animation: true,
                        lineHeight: 30.0,
                        animationDuration: 60000,
                        percent: 1,
                        barRadius: const Radius.circular(16),
                        backgroundColor: kTitleTextBlueColor,
                        progressColor: second <= 50 ? kGreenColor : kRedColor,
                        center: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer_outlined, color: kPrimaryColor),
                            Text(
                              second < 60 ? "$second" + ' s' : "Time Over",
                              style: TextStyle(
                                  fontFamily: font,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Question ${index + 1}/${int.parse(qcount)}:",
                    style: kquizTextStyle),
                Text("Score: ${score}", style: kquizTextStyle),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            //QnA Container
            Column(children: [
              Container(
                height: size.height * 0.51,
                width: size.width * 0.9,
                child: Card(
                  color: kSecondaryColor,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: kTitleTextBlueColor, width: 2.0),
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
                            rows[index]['question'],
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
                            "A)  " + rows[index]['answera'],
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
                            isPressed = true;
                            isPressedA = true;
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
                            "B)  " + rows[index]['answerb'],
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
                            isPressed = true;
                            isPressedB = true;
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
                            "C)  " + rows[index]['answerc'],
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
                            isPressed = true;
                            isPressedC = true;
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
                            "D)  " + rows[index]['answerd'],
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
                            isPressed = true;
                            isPressedD = true;
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
              width: size.width * 0.35,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      side: BorderSide(color: kTitleTextBlueColor, width: 2.0)),
                  onPressed: () {
                    setState(() {
                      if (answerCorrectA == true && isPressedA == true) {
                        score++;
                      } else if (answerCorrectB == true && isPressedB == true) {
                        score++;
                      } else if (answerCorrectC == true && isPressedC == true) {
                        score++;
                      } else if (answerCorrectC == true && isPressedC == true) {
                        score++;
                      }
                      isPressed = false;
                      isPressedA = false;
                      isPressedB = false;
                      isPressedC = false;
                      isPressedD = false;
                      answerCorrectA = false;
                      answerCorrectB = false;
                      answerCorrectC = false;
                      answerCorrectD = false;
                      if (index == int.parse(qcount) - 1) {
                        _studentquest.add({
                          "topic": topic,
                          "desc": desc,
                          "temail": email,
                          "tname": name,
                          "qcount": qcount,
                          "semail": user.email.toString(),
                          "score": score.toString(),
                          "qimageUrl": qimageUrl,
                        });
                        timer.cancel();
                        showDialog(
                            context: context,
                            builder: ((ctx) => ResultBox(
                                score: score,
                                total_question: int.parse(qcount),
                                onPressed: StartOver,
                                mark: score * 5)));
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
          ]),
        ),
      ),
    );
  }
}
