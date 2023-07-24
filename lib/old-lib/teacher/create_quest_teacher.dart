import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:quest/constant.dart';
import 'package:quest/teacher/add_quiz_details.dart';
import 'package:quest/teacher_student/add_student_details.dart';

class CreateQuestTeacher extends StatefulWidget {
  final name;
  final email;
  final imageUrl;
  CreateQuestTeacher(
      {super.key,
      required this.name,
      required this.email,
      required this.imageUrl});
  @override
  State<CreateQuestTeacher> createState() => _CreateQuestTeacherState();
}

class _CreateQuestTeacherState extends State<CreateQuestTeacher> {
  final CollectionReference _teacherquest =
      FirebaseFirestore.instance.collection('teacherquest');
  // void FetchTeacher(String email)async{

  // }
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
        SizedBox(
          height: 10.0,
        ),

        //Create a quest
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          child: Row(
            children: [
              FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2.0, color: kTitleTextBlueColor),
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(Icons.add, color: kOrangeColor),
                  backgroundColor: kSecondaryColor,
                  onPressed: () {
                    AddQuizDetails(widget.name.toString(),
                        widget.email.toString(), context);
                  }),
              SizedBox(
                width: 20.0,
              ),
              Text(
                'Create quest',
                style: TextStyle(
                    color: kOrangeColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: font,
                    fontSize: 17.0),
              )
            ],
          ),
        ),
        //Create quest
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
                      if (documentSnapshot2['email'] == '') {
                        _teacherquest
                            .doc(documentSnapshot2.id)
                            .update({
                              'email': widget.email,
                              'name': widget.name
                            }) // <-- Updated data
                            .then((_) => print('Success'))
                            .catchError((error) => print('Failed: $error'));
                      }
                      if (documentSnapshot2['email'] == widget.email) {
                        return Card(
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
                                      backgroundColor: kOrangeColor,
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
                                            style: kTeacherTitleTextStyle),
                                        Text('Teacher: ' + widget.name,
                                            style: kTeacherTextStyle),
                                        Text(
                                            'Question count: ' +
                                                documentSnapshot2['qcount']
                                                    .toString(),
                                            style: kTeacherTextStyle),
                                        Text(
                                            'Total marks: ' +
                                                (int.parse(documentSnapshot2[
                                                            'qcount']) *
                                                        5)
                                                    .toString(),
                                            style: kTeacherTextStyle),
                                        Text(
                                            'Duration: ' +
                                                (int.parse(documentSnapshot2[
                                                            'qcount']) *
                                                        60)
                                                    .toString() +
                                                's',
                                            style: kTeacherTextStyle),
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ));
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
