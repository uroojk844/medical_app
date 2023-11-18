import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  CollectionReference doctors =
      FirebaseFirestore.instance.collection("doctors");

  Stream<QuerySnapshot> getDoctorsOfCategory(String category) {
    return doctors.where("category", isEqualTo: category).snapshots();
  }
}
