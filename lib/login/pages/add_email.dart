import 'package:cloud_firestore/cloud_firestore.dart';

List semail = [];
void AddEmail(String email, String name) async {
  final CollectionReference _teachstu =
      FirebaseFirestore.instance.collection('teachstu');
  bool exist = false;
  final records = await FirebaseFirestore.instance.collection('teachstu').get();
  semail = records.docs.map((e) => e.data()).toList();

  if (semail.isEmpty) {
    await _teachstu.add({"email": email, "status": 'teacher', "name": name});
  } else {
    for (var i = 0; i < semail.length; i++) {
      if (semail[i]['email'].toString() == email.toString()) {
        exist = true;
      }
    }
    if (!exist) {
      await _teachstu.add({"email": email, "status": '', "name": name});
    }
  }
  return;
}
