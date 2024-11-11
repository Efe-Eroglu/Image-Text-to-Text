import 'package:flutter/material.dart';

class HistoryProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _historyItems = [];

  List<Map<String, dynamic>> get historyItems => _historyItems;

  void addHistoryItem(String imageUrl, String text) {
    _historyItems.add({"image": imageUrl, "text": text});
    notifyListeners();
  }

  void deleteHistoryItem(int index) {
    _historyItems.removeAt(index);
    notifyListeners();
  }
}
