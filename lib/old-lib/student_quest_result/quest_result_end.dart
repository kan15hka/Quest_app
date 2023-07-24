import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quest/constant.dart';
import 'package:quest/student_quest_result/student_quest_result.dart';
import 'package:quest/studentquest/student_quest.dart';

class QuestResultEnd extends StatelessWidget {
  final String semail;
  final String sname;
  final String topic;
  final String desc;
  const QuestResultEnd(
      {Key? key,
      required this.topic,
      required this.desc,
      required this.semail,
      required this.sname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: kTitleTextBlueColor, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kSecondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    side: BorderSide(color: kTitleTextBlueColor, width: 2.0)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: kquizTextStyle,
                )),
            SizedBox(
              width: 20.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kSecondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    side: BorderSide(color: kTitleTextBlueColor, width: 2.0)),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  "End Result",
                  style: kquizTextStyle,
                )),
          ],
        ),
      ],
      backgroundColor: kSecondaryColor,
      content: Container(
        height: size.height * 0.4,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Lottie.asset('assets/success.json', height: 150.0),
          SizedBox(
            height: 10.0,
          ),
          Text(topic,
              style: TextStyle(
                  fontFamily: font,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: kTitleTextPurpleColor)),
          SizedBox(
            height: 5,
          ),
          Text(desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: font,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: kTitleTextBlueColor)),
          SizedBox(
            height: 10.0,
          ),
          Text("Leave view of " + sname + ' Quest Results',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: font,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: kTitleTextBlueColor)),
          SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }
}
