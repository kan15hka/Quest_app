// List semail = [];
//   int index = 100;
//   void FetchName(String email) async {
//     final CollectionReference _teachstu =
//         FirebaseFirestore.instance.collection('teachstu');
//     bool exist = false;
//     print(email);
//     final records =
//         await FirebaseFirestore.instance.collection('teachstu').get();
//     semail = records.docs.map((e) => e.data()).toList();
//     print(semail[0]['name']);