import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quest/constant.dart';

class ResultBox extends StatelessWidget {
  final String questTopic;
  final String questDesc;
  final int totalQuestion;
  final VoidCallback onPressed;
  const ResultBox({
    Key? key,
    required this.questTopic,
    required this.questDesc,
    required this.totalQuestion,
    required this.onPressed,
  }) : super(key: key);

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
                onPressed: onPressed,
                child: Text(
                  "Finish Quest Create",
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
          Text(
            questTopic,
            style: TextStyle(
                fontFamily: font,
                fontSize: 20.0,
                color: kTitleTextPurpleColor,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          Text(
            questDesc,
            style: TextStyle(
                fontFamily: font,
                fontSize: 17.0,
                color: kTitleTextBlueColor,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          Lottie.asset('lib/teacherquest/assets/success.json', height: 150.0),
          Text("You have successfully created the quest",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: font,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: kTitleTextBlueColor)),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              CircularPercentIndicator(
                animation: true,
                animationDuration: 2000,
                backgroundColor: kTitleTextBlueColor,
                progressColor: kTitleTextPurpleColor,
                circularStrokeCap: CircularStrokeCap.round,
                radius: 35.0,
                lineWidth: 10.0,
                percent: 1,
                center: Text(
                  "${totalQuestion}/${totalQuestion}",
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
                  "You have created ${totalQuestion} questions",
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
