import 'package:flutter/material.dart';

class SubscriptionController extends ChangeNotifier {
  bool _isPro = false;

  bool get isPro => _isPro;

  void setPro(bool value) {
    _isPro = value;
    notifyListeners();
  }

  void toggleSubscription() {
    _isPro = !_isPro;
    notifyListeners();
  }
}
