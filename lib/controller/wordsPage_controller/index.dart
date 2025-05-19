import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class WordsPageController extends GetxController {
  final PageController pageController = PageController();
  RxList<QueryDocumentSnapshot> words = RxList<QueryDocumentSnapshot>();

  @override
  void onInit() {
    super.onInit();
    fetchWords();
  }

  void fetchWords() async {
    var snapshot = await FirebaseFirestore.instance.collection('words').get();
    words.value = snapshot.docs;
  }

  void nextPage() {
    if (pageController.page! < words.length - 1) {
      pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void prevPage() {
    if (pageController.page! > 0) {
      pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }
}
