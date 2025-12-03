import 'package:flutter/material.dart';

enum StorageMode { cloud, offline }

class StorageModeProvider extends ChangeNotifier {
  StorageMode _mode = StorageMode.cloud;

  StorageMode get mode => _mode;

  void setMode(StorageMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void toggleMode() {
    _mode = _mode == StorageMode.cloud ? StorageMode.offline : StorageMode.cloud;
    notifyListeners();
  }
}
