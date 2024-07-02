import 'package:flutter/material.dart';

class BottomSheetManager with ChangeNotifier {
  bool _isVisible = false;
  String youtubeTitle= '';
  bool get isVisible => _isVisible;

  void showBottomSheet(String title) {
  youtubeTitle= title;
    _isVisible = true;
    notifyListeners();
  }

  void hideBottomSheet() {
    _isVisible = false;
    notifyListeners();
  }
}
