import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:quest/student/quest_result_go.dart';

import '../constant.dart';

class CompletedQuest extends StatefulWidget {
  final String semail;
  final String sname;
  CompletedQuest({super.key, required this.semail, required this.sname});
  @override
  State<CompletedQuest> createState() => _CompletedQuestState();
}

class _CompletedQuestState extends State<CompletedQuest> {
  final CollectionReference _studentquest =
      FirebaseFirestore.instance.collection('studentquest');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Quest Answered by you appear here',
              style: TextStyle(
                  color: kTitleTextBlueColor,
                  fontFamily: font,
                  // fontWeight: FontWeight.bold,
                  fontSize: 17.0),
            ),
          ),
        ),
        StreamBuilder(
          stream: _studentquest.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot2) {
            if (streamSnapshot2.hasData) {
              return Flexible(
                child: ListView.builder(
                    itemCount: streamSnapshot2.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot2 =
                          streamSnapshot2.data!.docs[index];
                      if (documentSnapshot2['semail'] == widget.semail) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: ((ctx) => QuestResultGo(
                                    score: documentSnapshot2['score'],
                                    sname: widget.sname,
                                    semail: documentSnapshot2['semail'],
                                    topic: documentSnapshot2['topic'],
                                    desc: documentSnapshot2['desc'])));
                          },
                          child: Card(
                              color: kSecondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                  width: 2.0,
                                  color: kGreenColor,
                                ),
                              ),
                              margin: EdgeInsets.only(
                                  left: 30.0, right: 30.0, top: 20.0),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  color: kSecondaryColor,
                                  child: Column(
                                    children: [
                                      Text('Status: Completed',
                                          style: TextStyle(
                                              color: kGreenColor,
                                              fontFamily: font,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: kYellowColor,
                                            radius: 32.0,
                                            child: CircleAvatar(
                                              backgroundColor: kSecondaryColor,
                                              backgroundImage: NetworkImage(
                                                  documentSnapshot2[
                                                      'qimageUrl']),
                                              radius: 30.0,
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
                                                  'Topic: ' +
                                                      documentSnapshot2[
                                                          'topic'],
                                                  style:
                                                      kStudentTitleTextStyle),
                                              Text(
                                                  'Teacher: ' +
                                                      documentSnapshot2[
                                                          'tname'],
                                                  style: kStudentTextStyle),
                                              Text(
                                                  'Question count: ' +
                                                      documentSnapshot2[
                                                              'qcount']
                                                          .toString(),
                                                  style: kStudentTextStyle),
                                              Text(
                                                  'Marks obtained: ' +
                                                      (int.parse(documentSnapshot2[
                                                                  'score']) *
                                                              5)
                                                          .toString() +
                                                      '/' +
                                                      (int.parse(documentSnapshot2[
                                                                  'qcount']) *
                                                              5)
                                                          .toString(),
                                                  style: kStudentTextStyle),
                                              // Text(
                                              //     'Duration: ' +
                                              //         documentSnapshot2['duration']
                                              //             .toString(),
                                              //     style: kStudentTextStyle),
                                            ],
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        );
                      } else {
                        return SizedBox(
                          height: 0.0,
                        );
                      }
                    }),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }
}
