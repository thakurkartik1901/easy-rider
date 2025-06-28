import 'package:flutter/material.dart';

enum LoaderState { initial, visible, hidden }

class LoaderNotifier with ChangeNotifier {
  LoaderNotifier();
  LoaderState loaderState = LoaderState.initial;

  void showLoader() {
    if (loaderState == LoaderState.initial ||
        loaderState == LoaderState.hidden) {
      loaderState = LoaderState.visible;
      notifyListeners();
    }
  }

  void hideLoader() {
    if (loaderState == LoaderState.visible) {
      loaderState = LoaderState.hidden;
      notifyListeners();
    }
  }
}
