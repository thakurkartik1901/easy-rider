import 'package:easy_rider/home/infrastructure/user_repository.dart';
import 'package:easy_rider/ride/model/data_ui.dart';
import 'package:flutter/material.dart';

enum UserState { initial, inProgress, success, failure }

class UserNotifier with ChangeNotifier {
  UserNotifier();

  static final UserRepository _userRepository = UserRepository();
  UserState userState = UserState.initial;
  DataUI? dataUI;

  bool isTab = false;

  Future<void> fetchUser() async {
    if (userState == UserState.inProgress) {
      return;
    }
    userState = UserState.inProgress;
    notifyListener();

    final successOrFailure = await _userRepository.fetchUser();
    userState = successOrFailure.fold(
      (l) => UserState.failure,
      (r) {
        dataUI = r;
        return UserState.success;
      },
    );

    notifyListener();
  }

  Future<void> changeDutyStatus(bool status) async {
    final successOrFailure = await _userRepository.changeDutyStatus(status);
    userState = successOrFailure.fold(
      (l) => UserState.failure,
      (r) {
        dataUI?.cab?.available = status;
        return UserState.success;
      },
    );
    notifyListener();
  }

  Future<void> syncUserLocation(double lat, double lng) async {
    final successOrFailure = await _userRepository.syncUserLocation(lat, lng);
    userState = successOrFailure.fold(
      (l) => UserState.failure,
      (r) {
        return UserState.success;
      },
    );
  }

  void notifyListener() {
    notifyListeners();
  }
}
