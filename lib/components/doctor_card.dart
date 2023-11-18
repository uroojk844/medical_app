import 'package:flutter/material.dart';
import 'package:medical_app/model/category_model_provider.dart';
import 'package:provider/provider.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
    required this.docID,
  });

  final Map<String, dynamic> doctor;
  final String docID;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 4,
            blurRadius: 8,
            color: Color.fromRGBO(0, 0, 0, 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                "http://picsum.photos/60.webp",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(doctor['name']),
            subtitle: const Text("Aliganj, Lucknow"),
            trailing: const Icon(Icons.info_outline_rounded),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(milliseconds: 500),
                    backgroundColor: Colors.green,
                    content: Text("Appintment booked!"),
                  ),
                );
              },
              child: Consumer<CategoryModelProvider>(
                  builder: (context, data, child) {
                bool hasAppointment = data.appointmentIDs.contains(docID);

                return GestureDetector(
                  onTap: () {
                    if (hasAppointment) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Already apointed"),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                      return;
                    }
                    data.setAppointment(docID);
                  },
                  child: Text(
                    data.appointmentIDs.contains(docID)
                        ? "Booked"
                        : "Book appintment",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
