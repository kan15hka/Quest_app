import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quest/constant.dart';
import 'package:quest/teacherquest/result_box.dart';

class TeacherQuest extends StatefulWidget {
  final String email;
  final String topic;
  final String desc;
  final String qcount;
  final String qimageUrl;
  const TeacherQuest(
      {super.key,
      required this.email,
      required this.topic,
      required this.desc,
      required this.qcount,
      required this.qimageUrl});

  @override
  State<TeacherQuest> createState() => _TeacherQuestState();
}

class _TeacherQuestState extends State<TeacherQuest> {
  //Text Editing controllers
  TextEditingController _questionController = TextEditingController();
  TextEditingController _answerAController = TextEditingController();
  TextEditingController _answerBController = TextEditingController();
  TextEditingController _answerCController = TextEditingController();
  TextEditingController _answerDController = TextEditingController();

  final firestoreInstance = FirebaseFirestore.instance;
  //chexkbox bools
  String answer = '';
  bool? isCheckedA = false;
  bool? isCheckedB = false;
  bool? isCheckedC = false;
  bool? isCheckedD = false;
  bool isCheckedBox = false;
  List rows = [];
  int inde = 0;
  int findex = 0;
  int i = 0;

  //check box color
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
      MaterialState.focused,
      MaterialState.pressed,
    };
    if (states.any(interactiveStates.contains)) {
      return kGreenColor;
    }
    return kTitleTextBlueColor;
  }

  int index = 0;

  void FinishQuestCreate() {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  late String teacherquestDocumentId;
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
          });
        }
      });

      // do something with the document ID
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "CREATE THE QUEST",
          style: TextStyle(
              color: kOrangeColor,
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
                        //Topic of the quest
                        Text(
                          widget.topic,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kTitleTextPurpleColor,
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: font),
                        ),
                        //Description of the Quest
                        Text(
                          widget.desc,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kTitleTextBlueColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: font),
                        ),
                      ],
                    ),
                  ),
                  //Progress Bar
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            //questions
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Question ${index + 1}/${int.parse(widget.qcount)}:",
                    style: kquizTextStyle),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            //QnA Container
            Column(children: [
              Container(
                height: size.height * 0.55,
                width: size.width * 0.9,
                child: Card(
                  color: kSecondaryColor,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: kTitleTextBlueColor, width: 2.0),
                      borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text("Enter the question", style: kquizTextStyle),
                        SizedBox(
                          height: 10,
                        ),
                        //Question of the quest

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          alignment: Alignment.center,
                          child: TextField(
                            style: TextStyle(
                                color: kTitleTextBlueColor,
                                fontFamily: font,
                                fontSize: 18.0),
                            controller: _questionController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: kPrimaryColor,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    color: kTitleTextBlueColor, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    color: kTitleTextPurpleColor, width: 2.0),
                              ),
                              hintText: 'Question',
                              hintStyle: TextStyle(
                                  color: kTitleTextBlueColor,
                                  fontFamily: font,
                                  fontSize: 18.0),
                            ),
                          ),
                        ),
                        Text("Enter the answers", style: kquizTextStyle),
                        SizedBox(
                          height: 10,
                        ),

                        //Answers
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            children: [
                              //Answer A
                              TextField(
                                cursorColor: kTitleTextBlueColor,
                                style: TextStyle(
                                    color: kTitleTextBlueColor,
                                    fontFamily: font,
                                    fontSize: 18.0),
                                controller: _answerAController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: (isCheckedBox)
                                      ? (isCheckedA!)
                                          ? kGreenColor
                                          : kRedColor
                                      : kPrimaryColor,
                                  //Check Box for marking the corectness of the answers
                                  suffixIcon: Checkbox(
                                    checkColor: kPrimaryColor,
                                    value: isCheckedA,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor),
                                    shape: CircleBorder(
                                        side: BorderSide(
                                            color: kTitleTextBlueColor,
                                            width: 2.0)),
                                    onChanged: (newBool) {
                                      setState(() {
                                        isCheckedA = newBool;
                                        isCheckedBox = true;
                                      });
                                    },
                                  ),
                                  contentPadding: EdgeInsets.all(15.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: kTitleTextBlueColor, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: kTitleTextPurpleColor,
                                        width: 2.0),
                                  ),
                                  hintText: 'Answer A',
                                  hintStyle: TextStyle(
                                      color: kTitleTextBlueColor,
                                      fontFamily: font,
                                      fontSize: 18.0),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //Answer B
                              TextField(
                                cursorColor: kTitleTextBlueColor,
                                style: TextStyle(
                                    color: kTitleTextBlueColor,
                                    fontFamily: font,
                                    fontSize: 18.0),
                                controller: _answerBController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: (isCheckedBox)
                                      ? (isCheckedB!)
                                          ? kGreenColor
                                          : kRedColor
                                      : kPrimaryColor,
                                  //Check Box for marking the corectness of the answers
                                  suffixIcon: Checkbox(
                                    checkColor: kPrimaryColor,
                                    value: isCheckedB,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor),
                                    shape: CircleBorder(
                                        side: BorderSide(
                                            color: kTitleTextBlueColor,
                                            width: 2.0)),
                                    onChanged: (newBool) {
                                      setState(() {
                                        isCheckedB = newBool;
                                        isCheckedBox = true;
                                      });
                                    },
                                  ),
                                  contentPadding: EdgeInsets.all(15.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: kTitleTextBlueColor, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: kTitleTextPurpleColor,
                                        width: 2.0),
                                  ),
                                  hintText: 'Answer B',
                                  hintStyle: TextStyle(
                                      color: kTitleTextBlueColor,
                                      fontFamily: font,
                                      fontSize: 18.0),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //Answer C
                              TextField(
                                cursorColor: kTitleTextBlueColor,
                                style: TextStyle(
                                    color: kTitleTextBlueColor,
                                    fontFamily: font,
                                    fontSize: 18.0),
                                controller: _answerCController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: (isCheckedBox)
                                      ? (isCheckedC!)
                                          ? kGreenColor
                                          : kRedColor
                                      : kPrimaryColor,
                                  //Check Box for marking the corectness of the answers
                                  suffixIcon: Checkbox(
                                    checkColor: kPrimaryColor,
                                    value: isCheckedC,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor),
                                    shape: CircleBorder(
                                        side: BorderSide(
                                            color: kTitleTextBlueColor,
                                            width: 2.0)),
                                    onChanged: (newBool) {
                                      setState(() {
                                        isCheckedC = newBool;
                                        isCheckedBox = true;
                                      });
                                    },
                                  ),
                                  contentPadding: EdgeInsets.all(15.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: kTitleTextBlueColor, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: kTitleTextPurpleColor,
                                        width: 2.0),
                                  ),
                                  hintText: 'Answer C',
                                  hintStyle: TextStyle(
                                      color: kTitleTextBlueColor,
                                      fontFamily: font,
                                      fontSize: 18.0),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //Answer D
                              TextField(
                                cursorColor: kTitleTextBlueColor,
                                style: TextStyle(
                                    color: kTitleTextBlueColor,
                                    fontFamily: font,
                                    fontSize: 18.0),
                                controller: _answerDController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: (isCheckedBox)
                                      ? (isCheckedD!)
                                          ? kGreenColor
                                          : kRedColor
                                      : kPrimaryColor,
                                  //Check Box for marking the corectness of the answers
                                  suffixIcon: Checkbox(
                                    checkColor: kPrimaryColor,
                                    value: isCheckedD,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor),
                                    shape: CircleBorder(
                                        side: BorderSide(
                                            color: kTitleTextBlueColor,
                                            width: 2.0)),
                                    onChanged: (newBool) {
                                      setState(() {
                                        isCheckedD = newBool;
                                        isCheckedBox = true;
                                      });
                                    },
                                  ),
                                  contentPadding: EdgeInsets.all(15.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: kTitleTextBlueColor, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: kTitleTextPurpleColor,
                                        width: 2.0),
                                  ),
                                  hintText: 'Answer D',
                                  hintStyle: TextStyle(
                                      color: kTitleTextBlueColor,
                                      fontFamily: font,
                                      fontSize: 18.0),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        )
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
                    print(_questionController.text);
                    print(isCheckedA);
                    if (isCheckedA == true) {
                      answer = _answerAController.text;
                    } else if (isCheckedB == true) {
                      answer = _answerBController.text;
                    } else if (isCheckedC == true) {
                      answer = _answerCController.text;
                    } else if (isCheckedD == true) {
                      answer = _answerDController.text;
                    } else {
                      print('wrong');
                    }
                    documentId();

                    firestoreInstance
                        .collection('teacherquest')
                        .doc(teacherquestDocumentId)
                        .collection('qna')
                        .add({
                      "question": _questionController.text,
                      "answera": _answerAController.text,
                      "answerb": _answerBController.text,
                      "answerc": _answerCController.text,
                      "answerd": _answerDController.text,
                      "answer": answer
                    });

                    setState(() {
                      isCheckedA = false;
                      isCheckedB = false;
                      isCheckedC = false;
                      isCheckedD = false;
                      isCheckedBox = false;
                      answer = '';
                      _questionController.text = '';
                      _answerAController.text = '';
                      _answerBController.text = '';
                      _answerCController.text = '';
                      _answerDController.text = '';

                      if (index == int.parse(widget.qcount) - 1) {
                        showDialog(
                            context: context,
                            builder: ((ctx) => ResultBox(
                                  questTopic: widget.topic,
                                  questDesc: widget.desc,
                                  totalQuestion: int.parse(widget.qcount),
                                  onPressed: FinishQuestCreate,
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
          ]),
        ),
      ),
    );
  }
}
