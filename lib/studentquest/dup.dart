// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:quest/studentquest/result_box.dart';
// import 'package:quest/constant.dart';

// import 'ques_model.dart';

// class StudentQuest extends StatefulWidget {
//   final String qtopic;
//   const StudentQuest({super.key, required this.qtopic});

//   @override
//   State<StudentQuest> createState() => _StudentQuestState();
// }

// class _StudentQuestState extends State<StudentQuest> {
//   //collection reference
//   final CollectionReference _teacherquest =
//       FirebaseFirestore.instance.collection('teacherquest');
//   final firestoreInstance = FirebaseFirestore.instance;

//   // get documnet id
//   String teacherquestDocumentId = '';
//   String topic = '';
//   String desc = '';
//   String email = '';
//   String name = '';
//   String qimageUrl = '';
//   String qcount = '';

//   void documentId() async {
//     DocumentSnapshot documentSnapshot;
//     CollectionReference teacherquestCollection =
//         firestoreInstance.collection('teacherquest');
//     var querySnapshot = await teacherquestCollection.get();
//     querySnapshot.docs.forEach((doc) async {
//       var docId = doc.id;
//       await teacherquestCollection.doc(docId).get().then((value) {
//         documentSnapshot = value;
//         if (documentSnapshot['topic'] == widget.qtopic) {
//           setState(() {
//             teacherquestDocumentId = docId;
//             topic = documentSnapshot['topic'];
//             desc = documentSnapshot['desc'];
//             email = documentSnapshot['email'];
//             name = documentSnapshot['name'];
//             qimageUrl = documentSnapshot['qimageUrl'];
//             qcount = documentSnapshot['qcount'];
//           });
//         }
//       });

//       // do something with the document ID
//     });
//   }

//   bool answerCorrect = false;

//   int index = 0;
//   bool isPressed = false;
//   int score = 0;
//   void StartOver() {
//     setState(() {
//       index = 0;
//       isPressed = false;
//       score = 0;
//       second = 0;
//       startTimer();
//     });
//     Navigator.pop(context);
//   }

//   @override
//   void initState() {
//     startTimer();
//   }

//   static int maxseconds = 60;
//   int second = 0;
//   late Timer timer;
//   void startTimer() {
//     timer = Timer.periodic(Duration(seconds: 1), (_) {
//       if (second < 60) {
//         setState(() {
//           second++;
//         });
//       } else {
//         setState(() {
//           timer.cancel();
//           showDialog(
//               context: context,
//               builder: ((ctx) => ResultBox(
//                     score: score,
//                     total_question: int.parse(qcount),
//                     onPressed: StartOver,
//                   )));
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     documentId();
//     final CollectionReference _qna =
//         _teacherquest.doc(teacherquestDocumentId).collection('qna');
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: kPrimaryColor,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "GRAB YOUR QUEST",
//           style: TextStyle(
//               color: kYellowColor,
//               fontSize: 23.0,
//               fontWeight: FontWeight.bold,
//               fontFamily: font),
//         ),
//         elevation: 0,
//         backgroundColor: kSecondaryColor,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           color: kPrimaryColor,
//           child: Column(children: [
//             Container(
//               height: size.height * 0.13,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: size.height * 0.13,
//                     decoration: BoxDecoration(
//                         color: kSecondaryColor,
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(40.0),
//                             bottomRight: Radius.circular(40.0))),
//                   ),
//                   Container(
//                     alignment: Alignment.topCenter,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           topic,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: kTitleTextPurpleColor,
//                               fontSize: 23.0,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: font),
//                         ),
//                         Text(
//                           desc,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: kTitleTextBlueColor,
//                               fontSize: 17.0,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: font),
//                         ),
//                         SizedBox(
//                           height: 25.0,
//                         ),
//                       ],
//                     ),
//                   ),
//                   //Progress Bar
//                   Container(
//                     alignment: Alignment.bottomCenter,
//                     margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
//                     child: Container(
//                       margin:
//                           EdgeInsets.symmetric(horizontal: size.width * 0.02),
//                       child: LinearPercentIndicator(
//                         width: size.width * 0.9,
//                         animation: true,
//                         lineHeight: 30.0,
//                         animationDuration: 60000,
//                         percent: 1,
//                         barRadius: const Radius.circular(16),
//                         backgroundColor: kTitleTextBlueColor,
//                         progressColor: second <= 50 ? kGreenColor : kRedColor,
//                         center: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.timer_outlined, color: kPrimaryColor),
//                             Text(
//                               second < 60 ? "$second" + ' s' : "Time Over",
//                               style: TextStyle(
//                                   fontFamily: font,
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: kPrimaryColor),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text("Question ${index + 1}/${int.parse(qcount)}:",
//                     style: kquizTextStyle),
//                 Text("Score: ${score}", style: kquizTextStyle),
//               ],
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             //QnA Container
//             Column(children: [
//               Container(
//                 height: size.height * 0.51,
//                 width: size.width * 0.9,
//                 child: Card(
//                   color: kSecondaryColor,
//                   shape: RoundedRectangleBorder(
//                       side: BorderSide(color: kTitleTextBlueColor, width: 2.0),
//                       borderRadius: BorderRadius.circular(30)),
//                   child: Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 15.0),
//                           alignment: Alignment.center,
//                           child: Text(
//                             "qqqqqqqqqqqqqq",
//                             style: TextStyle(
//                                 fontSize: 19.0,
//                                 fontFamily: font,
//                                 fontWeight: FontWeight.w500,
//                                 color: kTitleTextBlueColor),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),

//                         SizedBox(
//                           height: 20,
//                         ),
//                         //Answers
//                         StreamBuilder(
//                             stream: _qna.snapshots(),
//                             builder: (context,
//                                 AsyncSnapshot<QuerySnapshot> streamSnapshot2) {
//                               if (streamSnapshot2.hasData) {
//                                 return Flexible(
//                                   child: Container(
//                                     height: size.height * 0.4,
//                                     child: ListView.builder(
//                                       shrinkWrap: true,
//                                       itemCount: 4,
//                                       itemBuilder: ((context, indexx) {
//                                         Color color = (answerCorrect == true)
//                                             ? kGreenColor
//                                             : kRedColor;
//                                         return Container(
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10.0)),
//                                           child: Column(
//                                             children: [
//                                               Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal:
//                                                         size.width * 0.08),
//                                                 child: ListTile(
//                                                   trailing: isPressed
//                                                       ? (answerCorrect == true)
//                                                           ? ClipOval(
//                                                               child: Container(
//                                                                   color:
//                                                                       kGreenColor,
//                                                                   padding:
//                                                                       EdgeInsets
//                                                                           .all(
//                                                                               1.0),
//                                                                   child: Icon(Icons
//                                                                       .check_circle_outline_rounded)),
//                                                             )
//                                                           : ClipOval(
//                                                               child: Container(
//                                                                   color:
//                                                                       kRedColor,
//                                                                   padding:
//                                                                       EdgeInsets
//                                                                           .all(
//                                                                               1.0),
//                                                                   child: Icon(Icons
//                                                                       .close_rounded)),
//                                                             )
//                                                       : Icon(
//                                                           Icons.circle,
//                                                           size: 2.0,
//                                                         ),
//                                                   title: Text(
//                                                     "${String.fromCharCode(indexx + 65)} )     aaaaaaaaaaa",
//                                                     style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontFamily: font,
//                                                       fontSize: 17.0,
//                                                       color: isPressed
//                                                           ? kPrimaryColor
//                                                           : kTitleTextBlueColor,
//                                                     ),
//                                                   ),
//                                                   tileColor: //kTitleTextBlueColor,
//                                                       isPressed
//                                                           ? color
//                                                               .withOpacity(0.5)
//                                                           : kPrimaryColor,
//                                                   shape: RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15.0),
//                                                       side: BorderSide(
//                                                           color: isPressed
//                                                               ? color
//                                                               : kTitleTextBlueColor,
//                                                           width: 2.0)),
//                                                   onTap: () {
//                                                     setState(() {
//                                                       //If pressed correct Answer
//                                                       if (isPressed == false &&
//                                                           color ==
//                                                               kGreenColor) {
//                                                         score++;

//                                                         isPressed = true;
//                                                       }
//                                                       //If answer is incorrect
//                                                       else if (isPressed ==
//                                                           false) {
//                                                         isPressed = true;
//                                                       }
//                                                     });
//                                                   },
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: size.height * 0.015,
//                                               )
//                                             ],
//                                           ),
//                                         );
//                                       }),
//                                     ),
//                                   ),
//                                 );
//                               }
//                               return const Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             })
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//             SizedBox(
//               height: 20.0,
//             ),
//             Container(
//               width: size.width * 0.35,
//               child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: kSecondaryColor,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0)),
//                       side: BorderSide(color: kTitleTextBlueColor, width: 2.0)),
//                   onPressed: () {
//                     setState(() {
//                       if (index == int.parse(qcount) - 1) {
//                         timer.cancel();
//                         showDialog(
//                             context: context,
//                             builder: ((ctx) => ResultBox(
//                                   score: score,
//                                   total_question: int.parse(qcount),
//                                   onPressed: StartOver,
//                                 )));
//                       } else {
//                         index = (index + 1);
//                         isPressed = false;
//                       }
//                     });
//                   },
//                   child: Text(
//                     "Next Quest",
//                     style: kquizTextStyle,
//                   )),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
