import 'package:bitirme_projesi/controller/SyllablesPageController/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SyllablesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SyllablesPageController controller = Get.put(SyllablesPageController());
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Obx(
          () => controller.words.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: pageWidth * 0.05,
                    vertical: pageHeight * 0.08,
                  ),
                  itemCount: controller.words.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.only(bottom: pageHeight * 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white,
                              Colors.teal.shade50,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(pageWidth * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.text_fields,
                                    color: Colors.teal,
                                    size: 24,
                                  ),
                                  SizedBox(width: pageWidth * 0.02),
                                  Text(
                                    "Kelime:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal.shade700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: pageHeight * 0.01),
                              Text(
                                controller.words[index]['originalText'],
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal.shade900,
                                ),
                              ),
                              SizedBox(height: pageHeight * 0.02),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.format_list_bulleted,
                                    color: Colors.teal,
                                    size: 24,
                                  ),
                                  SizedBox(width: pageWidth * 0.02),
                                  Text(
                                    "Heceler:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal.shade700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: pageHeight * 0.01),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: pageWidth * 0.04,
                                  vertical: pageHeight * 0.015,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  controller.words[index]['syllables'],
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.teal.shade900,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
