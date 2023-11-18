import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medical_app/model/category_model.dart';

class CategoryModelProvider extends ChangeNotifier {
  List<CategoryModel> categories = [];
  final _appointments = Hive.box("appointments");

  get getAppointmentsList => _appointments.get("appointments");

  List<String> appointmentIDs = [];

  setAppointment(String docID) {
    if (appointmentIDs.contains(docID)) return;
    appointmentIDs.add(docID);
    _appointments.put("appointments", appointmentIDs);
    notifyListeners();
  }

  setCategoryData(List<CategoryModel> categoryData) {
    categories = categoryData;
    notifyListeners();
  }
}
