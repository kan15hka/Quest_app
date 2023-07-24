import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quest/constant.dart';
import 'package:quest/studentquest/student_quest.dart';

class QuestGo extends StatelessWidget {
  final String topic;
  final String desc;
  const QuestGo({Key? key, required this.topic, required this.desc})
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return StudentQuest(qtopic: topic);
                  }));
                },
                child: Text(
                  "Go Quest",
                  style: kquizTextStyle,
                )),
          ],
        ),
      ],
      backgroundColor: kSecondaryColor,
      content: Container(
        height: size.height * 0.5,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Lottie.asset('assets/start.json', height: 220.0),
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
          Text("Wanna Start the Quest?",
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
