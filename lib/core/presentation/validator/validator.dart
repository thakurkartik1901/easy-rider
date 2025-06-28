import 'package:easy_rider/core/libs/packages/localizations.dart';

class Validator {
  AppLocalizationsData labels;
  Validator(this.labels);

  String? phoneNumber(String? value) {
    final RegExp regex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    if (value != null && value.length > 10) {
      return labels.errorMessage.invalidMobile;
    } else if (!regex.hasMatch(value!)) {
      return labels.errorMessage.invalidMobile;
    } else {
      return null;
    }
  }

  String? email(String? value) {
    final RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
    if (!regex.hasMatch(value!)) {
      return labels.errorMessage.invalidEmail;
    } else {
      return null;
    }
  }

  String? description(String? value, {int length = 100}) {
    if (value == null || value.isEmpty) {
      return "nothing to show";
    } else if (value.length < length) {
      return "nothing to show";
      // return labels.validator.length(dataLength: length.toString());
    } else {
      return null;
    }
  }
}
