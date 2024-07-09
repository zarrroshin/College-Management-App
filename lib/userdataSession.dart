library userdataSession;

import 'package:flutter/cupertino.dart';

class UserdataSession with ChangeNotifier {
  String _studentId = '';

  String get studentId => _studentId;

  void setStudentId(String studentId) {
    _studentId = studentId;
    notifyListeners();
  }
}

