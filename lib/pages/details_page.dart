import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/services/firestore_services.dart';

import '../components/doctor_card.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirestoreServices().getDoctorsOfCategory(category),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data!.size > 0) {
              List doctorsList = snapshot.data!.docs;

              return GridView.builder(
                itemCount: doctorsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 16 / 9,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot = doctorsList[index];
                  String docID = documentSnapshot.id;
                  var doctor = documentSnapshot.data() as Map<String, dynamic>;
                  return DoctorCard(doctor: doctor, docID: docID);
                },
              );
            } else {
              return const Center(child: Text("No data to show!"));
            }
          },
        ),
      ),
    );
  }
}
