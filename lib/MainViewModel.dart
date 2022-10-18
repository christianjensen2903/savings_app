import 'package:flutter/cupertino.dart';

class MainViewModel extends ChangeNotifier {
  int _savedAmount = 0;
  TextEditingController controller = TextEditingController();

  int get savedAmount => _savedAmount;

  void addSavings(int value) {
    _savedAmount = _savedAmount + value;
    notifyListeners();
  }
}
