import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_app/components/category_card.dart';
import 'package:medical_app/model/category_model.dart';
import 'package:medical_app/model/category_model_provider.dart';
import 'package:medical_app/pages/details_page.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<CategoryModel>> getData() async {
    var url = "https://api.jsonbin.io/v3/b/65575d0712a5d376599ace04";
    var response = await http.get(Uri.parse(url));
    var data = json.decode(response.body);
    return data['record']['categories']
        .map<CategoryModel>((r) => CategoryModel.fromMap(r))
        .toList();
  }

  @override
  void initState() {
    final data = Provider.of<CategoryModelProvider>(context, listen: false);
    data.appointmentIDs = data.getAppointmentsList ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medical App"),
      ),
      drawer: const Drawer(
        backgroundColor: Color(0xfff3f6ff),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              child: Icon(
                Icons.medical_services,
                size: 60,
              ),
            ),
            Spacer(),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                child: Text("U"),
              ),
              title: Text("Developer by Urooj Khan"),
              subtitle: Text("uroojk844@gmail.com"),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Welcome user!",
              style: TextStyle(
                fontSize: 28,
                color: Color(0xff7080b3),
              ),
            ),
            const SizedBox(height: 24),
            FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Provider.of<CategoryModelProvider>(context, listen: false)
                      .categories = snapshot.data!;
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Consumer<CategoryModelProvider>(
                  builder: (context, categoryData, child) => GridView.builder(
                    itemCount: categoryData.categories.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                category: categoryData.categories[index].name,
                              ),
                            ),
                          );
                        },
                        child: CategoryCard(index: index)),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
