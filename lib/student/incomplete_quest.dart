import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:quest/student/quest_go_dialogbox.dart';

import '../constant.dart';

class IncompleteQuest extends StatefulWidget {
  const IncompleteQuest({super.key});

  @override
  State<IncompleteQuest> createState() => _IncompleteQuestState();
}

class _IncompleteQuestState extends State<IncompleteQuest> {
  final CollectionReference _teacherquest =
      FirebaseFirestore.instance.collection('teacherquest');
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
              'Quest Source appear here',
              style: TextStyle(
                  color: kTitleTextBlueColor,
                  fontFamily: font,
                  // fontWeight: FontWeight.bold,
                  fontSize: 17.0),
            ),
          ),
        ),
        StreamBuilder(
          stream: _teacherquest.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot2) {
            if (streamSnapshot2.hasData) {
              return Flexible(
                child: ListView.builder(
                    itemCount: streamSnapshot2.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot2 =
                          streamSnapshot2.data!.docs[index];

                      return GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: ((ctx) => QuestGo(
                                  topic: documentSnapshot2['topic'],
                                  desc: documentSnapshot2['desc'])));
                        },
                        child: Card(
                            color: kSecondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                width: 2.0,
                                color: kTitleTextBlueColor,
                              ),
                            ),
                            margin: EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 20.0),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                color: kSecondaryColor,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: kYellowColor,
                                      radius: 32.0,
                                      child: CircleAvatar(
                                        backgroundColor: kSecondaryColor,
                                        backgroundImage: NetworkImage(
                                            documentSnapshot2['qimageUrl']),
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
                                                documentSnapshot2['topic'],
                                            style: kStudentTitleTextStyle),
                                        Text(
                                            'Teacher: ' +
                                                documentSnapshot2['name'],
                                            style: kStudentTextStyle),
                                        Text(
                                            'Question count: ' +
                                                documentSnapshot2['qcount']
                                                    .toString(),
                                            style: kStudentTextStyle),
                                        Text(
                                            'Total marks: ' +
                                                (int.parse(documentSnapshot2[
                                                            'qcount']) *
                                                        5)
                                                    .toString(),
                                            style: kStudentTextStyle),
                                        Text(
                                            'Duration: ' +
                                                (int.parse(documentSnapshot2[
                                                            'qcount']) *
                                                        60)
                                                    .toString() +
                                                's',
                                            style: kStudentTextStyle),
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            )),
                      );
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
