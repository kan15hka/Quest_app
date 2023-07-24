// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:quest/constant.dart';

// class QuestAnswerTextField extends StatefulWidget {
//   final answerController;
//   widget suffix
//   final String hintText;
//   QuestAnswerTextField(
//       {super.key,
//       required this.answerController,
//       required this.isChecked,
//       required this.hintText});
//   @override
//   State<QuestAnswerTextField> createState() => _QuestAnswerTextFieldState();
// }

// class _QuestAnswerTextFieldState extends State<QuestAnswerTextField> {
//   Color getColor(Set<MaterialState> states) {
//     const Set<MaterialState> interactiveStates = <MaterialState>{
//       MaterialState.selected,
//       MaterialState.focused,
//       MaterialState.pressed,
//     };
//     if (states.any(interactiveStates.contains)) {
//       return kGreenColor;
//     }
//     return kTitleTextBlueColor;
//   }

//   bool? k = false;
//   @override
//   Widget build(BuildContext context) {
//     bool? check = widget.isChecked;
//     print(check);
//     return TextField(
//       cursorColor: kTitleTextBlueColor,
//       style: TextStyle(
//           color: kTitleTextBlueColor, fontFamily: font, fontSize: 18.0),
//       controller: widget.answerController,
//       decoration: InputDecoration(
//         //Check Box for marking the corectness of the answers
//         suffixIcon: Checkbox(
//           checkColor: kPrimaryColor,
//           value: k,
//           fillColor: MaterialStateProperty.resolveWith(getColor),
//           shape: CircleBorder(
//               side: BorderSide(color: kTitleTextBlueColor, width: 2.0)),
//           onChanged: (newBool) {
//             setState(() {
//               k = newBool;
//             });
//           },
//         ),
//         contentPadding: EdgeInsets.all(15.0),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15.0),
//           borderSide: BorderSide(color: kTitleTextBlueColor, width: 2.0),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15.0),
//           borderSide: BorderSide(color: kTitleTextPurpleColor, width: 2.0),
//         ),
//         hintText: widget.hintText,
//         hintStyle: TextStyle(
//             color: kTitleTextBlueColor, fontFamily: font, fontSize: 18.0),
//       ),
//     );
//   }
// }
