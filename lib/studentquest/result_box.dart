// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quest/constant.dart';

class ResultBox extends StatelessWidget {
  final int score;
  final int total_question;
  final VoidCallback onPressed;
  final int mark;
  const ResultBox({
    Key? key,
    required this.score,
    required this.total_question,
    required this.onPressed,
    required this.mark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double percent = (score / total_question) * 100;

    String desc = "";
    Color statusColor = Colors.white;

    if (percent < 30.0) {
      desc = "Better Luck Next Time";
      statusColor = kRedColor;
    } else if (percent >= 30.0 && percent <= 70.0) {
      desc = "You've tried Hard";
      statusColor = kYellowColor;
    } else {
      desc = "You are Great";
      statusColor = kGreenColor;
    }

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
                onPressed: onPressed,
                child: Text(
                  "Repeat Quest",
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
                  "End Quest",
                  style: kquizTextStyle,
                )),
          ],
        ),
      ],
      backgroundColor: kSecondaryColor,
      content: Container(
        height: size.height * 0.55,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Lottie.asset('lib/teacherquest/assets/success.json', height: 150.0),
          Text("You have completed the test",
              style: TextStyle(
                  fontFamily: font,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: kTitleTextBlueColor)),
          SizedBox(
            height: 10,
          ),
          Text("${percent}% Score",
              style: TextStyle(
                  fontFamily: font,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: statusColor)),
          SizedBox(
            height: 10,
          ),
          Text("You scored ${mark}/${total_question * 5}",
              style: TextStyle(
                  fontFamily: font,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: statusColor)),
          SizedBox(
            height: 10,
          ),
          Text("${desc}",
              style: TextStyle(
                  fontFamily: font,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: statusColor)),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              CircularPercentIndicator(
                animation: true,
                animationDuration: 2000,
                backgroundColor: kTitleTextBlueColor,
                progressColor: statusColor,
                circularStrokeCap: CircularStrokeCap.round,
                radius: 35.0,
                lineWidth: 10.0,
                percent: percent / 100.0,
                center: Text(
                  "${score}/${total_question}",
                  style: TextStyle(
                      fontFamily: font,
                      fontSize: 17.0,
                      color: kTitleTextBlueColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  "You have answered ${score} questions out of ${total_question} questions",
                  style: TextStyle(
                      fontFamily: font,
                      fontSize: 16.0,
                      color: kTitleTextBlueColor,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
        ]),
      ),
    );
  }
}
