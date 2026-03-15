import 'package:flutter/material.dart';

class SubscriptionController extends ChangeNotifier {
  bool _isPro = false;
  bool _isLoading = false;

  bool get isPro => _isPro;
  bool get isLoading => _isLoading;

  void setPro(bool value) {
    _isPro = value;
    notifyListeners();
  }

  Future<void> upgradeToPro() async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay for professional feel
    await Future.delayed(const Duration(seconds: 2));

    _isPro = true;
    _isLoading = false;
    notifyListeners();
  }

  void toggleSubscription() {
    _isPro = !_isPro;
    notifyListeners();
  }
}
