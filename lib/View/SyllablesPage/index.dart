import 'package:bitirme_projesi/controller/SyllablesPageController/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SyllablesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SyllablesPageController controller = Get.put(SyllablesPageController());

    return Scaffold(
      appBar: AppBar(title: Text("Syllables Page")),
      body: Obx(
        () => controller.words.isEmpty
            ? Center(child: const CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.words.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(12),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Kelime:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(controller.words[index]['originalText'], style: TextStyle(fontSize: 24)),
                          SizedBox(height: 10),
                          Text("Hece:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(controller.words[index]['syllables'], style: TextStyle(fontSize: 22, color: Colors.blue)),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
