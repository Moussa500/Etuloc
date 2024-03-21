import 'package:flutter/material.dart';
class SearchTextProvider with ChangeNotifier {
  String _searchText = '';

  String get searchText => _searchText;

  set searchText(String text) {
    _searchText = text;
    notifyListeners();
  }
}
