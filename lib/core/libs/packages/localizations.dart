//
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Simple localization data class to replace flutter_sheet_localization
class AppLocalizationsData {
  final AppLocalizationsDataRideStatus rideStatus;
  final AppLocalizationsDataRide ride;
  final AppLocalizationsDataHome home;
  final AppLocalizationsDataAuth auth;
  final AppLocalizationsDataAction action;
  final AppLocalizationsDataAppUpdate appUpdate;
  final AppLocalizationsDataCommon common;
  final AppLocalizationsDataLanguage language;
  final AppLocalizationsDataLogout logout;
  final AppLocalizationsDataErrorMessage errorMessage;
  final AppLocalizationsDataAbout about;
  final AppLocalizationsDataSuccessMessage successMessage;
  final AppLocalizationsDataPlurals plurals;
  final AppLocalizationsDataTemplated templated;
  final AppLocalizationsDataDates dates;

  const AppLocalizationsData({
    required this.rideStatus,
    required this.ride,
    required this.home,
    required this.auth,
    required this.action,
    required this.appUpdate,
    required this.common,
    required this.language,
    required this.logout,
    required this.errorMessage,
    required this.about,
    required this.successMessage,
    required this.plurals,
    required this.templated,
    required this.dates,
  });
}

// Stub classes for the localization data
class AppLocalizationsDataRideStatus {
  final String pending;
  final String confirmed;
  final String cancelled;
  final String completed;
  final String inProgress;
  final String waitingforPayment;
  final String checkedIn;
  final String checkedOut;
  final String noShow;
  final String onHold;
  final String rescheduled;
  final String rejected;
  final String pendingApproval;
  final String pendingAvailability;
  final String expired;
  final String refunded;
  final String partialPayment;
  final String waitingList;
  final String customStatus;
  
  const AppLocalizationsDataRideStatus({
    this.pending = 'Pending',
    this.confirmed = 'Confirmed',
    this.cancelled = 'Cancelled',
    this.completed = 'Completed',
    this.inProgress = 'In Progress',
    this.waitingforPayment = 'Waiting for Payment',
    this.checkedIn = 'Checked In',
    this.checkedOut = 'Checked Out',
    this.noShow = 'No Show',
    this.onHold = 'On Hold',
    this.rescheduled = 'Rescheduled',
    this.rejected = 'Rejected',
    this.pendingApproval = 'Pending Approval',
    this.pendingAvailability = 'Pending Availability',
    this.expired = 'Expired',
    this.refunded = 'Refunded',
    this.partialPayment = 'Partial Payment',
    this.waitingList = 'Waiting List',
    this.customStatus = 'Custom Status',
  });
}

class AppLocalizationsDataRide {
  final String noCompletedRides;
  final String startRideFor;
  final String submit;
  final String noRidesAssigned;
  final String pickupTime;
  final String startTime;
  final String endTime;
  final String startTrip;
  final String endTrip;
  final String newRide;
  final String receivedNewRide;
  final String okay;
  final String active;
  final String history;
  final String status;
  final String reload;
  
  const AppLocalizationsDataRide({
    this.noCompletedRides = 'No completed rides',
    this.startRideFor = 'Start ride for',
    this.submit = 'Submit',
    this.noRidesAssigned = 'No rides assigned',
    this.pickupTime = 'Pickup Time',
    this.startTime = 'Start Time',
    this.endTime = 'End Time',
    this.startTrip = 'Start Trip',
    this.endTrip = 'End Trip',
    this.newRide = 'New Ride',
    this.receivedNewRide = 'Received new ride',
    this.okay = 'Okay',
    this.active = 'Active',
    this.history = 'History',
    this.status = 'Status',
    this.reload = 'Reload',
  });
}

class AppLocalizationsDataHome {
  final String language;
  final String online;
  final String offLine;
  
  const AppLocalizationsDataHome({
    this.language = 'Language',
    this.online = 'Online',
    this.offLine = 'Offline',
  });
}

class AppLocalizationsDataAuth {
  final String signIn;
  final String enterOTP;
  final String privacyDeclaration;
  final String mobileHint;
  final String mobilePlaceholder;
  final String didNotReceive;
  final String resend;
  
  const AppLocalizationsDataAuth({
    this.signIn = 'Sign In',
    this.enterOTP = 'Enter OTP',
    this.privacyDeclaration = 'Privacy Declaration',
    this.mobileHint = 'Mobile Hint',
    this.mobilePlaceholder = 'Mobile Placeholder',
    this.didNotReceive = 'Did not receive',
    this.resend = 'Resend',
  });
}

class AppLocalizationsDataAction {
  final String add;
  final String cancel;
  final String update;
  final String verify;
  final String next;
  
  const AppLocalizationsDataAction({
    this.add = 'Add',
    this.cancel = 'Cancel',
    this.update = 'Update',
    this.verify = 'Verify',
    this.next = 'Next',
  });
}

class AppLocalizationsDataAppUpdate {
  final String heading;
  final String descritpion;
  
  const AppLocalizationsDataAppUpdate({
    this.heading = 'App Update',
    this.descritpion = 'A new version is available',
  });
}

class AppLocalizationsDataCommon {
  final AppLocalizationsDataCommonNoData noData;
  const AppLocalizationsDataCommon({required this.noData});
}

class AppLocalizationsDataCommonNoData {
  final String description;
  const AppLocalizationsDataCommonNoData({
    this.description = 'No data available',
  });
}

class AppLocalizationsDataLanguage {
  final String changeLanguage;
  const AppLocalizationsDataLanguage({
    this.changeLanguage = 'Change Language',
  });
}

class AppLocalizationsDataLogout {
  final String logout;
  final String heading;
  final String descritpion;
  
  const AppLocalizationsDataLogout({
    this.logout = 'Logout',
    this.heading = 'Logout',
    this.descritpion = 'Are you sure you want to logout?',
  });
}

class AppLocalizationsDataErrorMessage {
  final String invalidOTP;
  final String somethingWrong;
  final String invalidMobile;
  final String invalidEmail;
  
  const AppLocalizationsDataErrorMessage({
    this.invalidOTP = 'Invalid OTP',
    this.somethingWrong = 'Something went wrong',
    this.invalidMobile = 'Invalid mobile number',
    this.invalidEmail = 'Invalid email',
  });
}

class AppLocalizationsDataAbout {
  final String privacyPolicy;
  const AppLocalizationsDataAbout({
    this.privacyPolicy = 'Privacy Policy',
  });
}

class AppLocalizationsDataSuccessMessage {
  final String otpSuccessful;
  const AppLocalizationsDataSuccessMessage({
    this.otpSuccessful = 'OTP sent successfully',
  });
}

class AppLocalizationsDataPlurals {
  const AppLocalizationsDataPlurals();
}

class AppLocalizationsDataTemplated {
  final AppLocalizationsDataTemplatedDate date;
  final AppLocalizationsDataTemplatedNumbers numbers;
  const AppLocalizationsDataTemplated({
    required this.date,
    required this.numbers,
  });
}

class AppLocalizationsDataTemplatedDate {
  const AppLocalizationsDataTemplatedDate();
}

class AppLocalizationsDataTemplatedNumbers {
  const AppLocalizationsDataTemplatedNumbers();
}

class AppLocalizationsDataDates {
  final AppLocalizationsDataDatesMonth month;
  const AppLocalizationsDataDates({required this.month});
}

class AppLocalizationsDataDatesMonth {
  const AppLocalizationsDataDatesMonth();
}

// Localized labels map
final Map<Locale, AppLocalizationsData> localizedLabels = {
  const Locale('en'): const AppLocalizationsData(
    rideStatus: AppLocalizationsDataRideStatus(),
    ride: AppLocalizationsDataRide(),
    home: AppLocalizationsDataHome(),
    auth: AppLocalizationsDataAuth(),
    action: AppLocalizationsDataAction(),
    appUpdate: AppLocalizationsDataAppUpdate(),
    common: AppLocalizationsDataCommon(
      noData: AppLocalizationsDataCommonNoData(),
    ),
    language: AppLocalizationsDataLanguage(),
    logout: AppLocalizationsDataLogout(),
    errorMessage: AppLocalizationsDataErrorMessage(),
    about: AppLocalizationsDataAbout(),
    successMessage: AppLocalizationsDataSuccessMessage(),
    plurals: AppLocalizationsDataPlurals(),
    templated: AppLocalizationsDataTemplated(
      date: AppLocalizationsDataTemplatedDate(),
      numbers: AppLocalizationsDataTemplatedNumbers(),
    ),
    dates: AppLocalizationsDataDates(
      month: AppLocalizationsDataDatesMonth(),
    ),
  ),
  const Locale('hi'): const AppLocalizationsData(
    rideStatus: AppLocalizationsDataRideStatus(
      pending: 'लंबित',
      confirmed: 'पुष्टि की गई',
      cancelled: 'रद्द किया गया',
      completed: 'पूर्ण',
      inProgress: 'प्रगति में',
      waitingforPayment: 'भुगतान की प्रतीक्षा',
      checkedIn: 'चेक इन',
      checkedOut: 'चेक आउट',
      noShow: 'नहीं दिखाया',
      onHold: 'रोक दिया गया',
      rescheduled: 'पुनर्निर्धारित',
      rejected: 'अस्वीकृत',
      pendingApproval: 'अनुमोदन लंबित',
      pendingAvailability: 'उपलब्धता लंबित',
      expired: 'समाप्त',
      refunded: 'वापस किया गया',
      partialPayment: 'आंशिक भुगतान',
      waitingList: 'प्रतीक्षा सूची',
      customStatus: 'कस्टम स्थिति',
    ),
    ride: AppLocalizationsDataRide(
      noCompletedRides: 'कोई पूर्ण सवारी नहीं',
      startRideFor: 'के लिए सवारी शुरू करें',
      submit: 'जमा करें',
      noRidesAssigned: 'कोई सवारी नहीं सौंपी गई',
      pickupTime: 'पिकअप समय',
      startTime: 'शुरू करने का समय',
      endTime: 'समाप्ति समय',
      startTrip: 'यात्रा शुरू करें',
      endTrip: 'यात्रा समाप्त करें',
      newRide: 'नई सवारी',
      receivedNewRide: 'नई सवारी प्राप्त हुई',
      okay: 'ठीक है',
      active: 'सक्रिय',
      history: 'इतिहास',
      status: 'स्थिति',
      reload: 'पुनः लोड करें',
    ),
    home: AppLocalizationsDataHome(
      language: 'भाषा',
      online: 'ऑनलाइन',
      offLine: 'ऑफलाइन',
    ),
    auth: AppLocalizationsDataAuth(
      signIn: 'साइन इन करें',
      enterOTP: 'OTP दर्ज करें',
      privacyDeclaration: 'गोपनीयता घोषणा',
      mobileHint: 'मोबाइल संकेत',
      mobilePlaceholder: 'मोबाइल प्लेसहोल्डर',
      didNotReceive: 'प्राप्त नहीं हुआ',
      resend: 'पुनः भेजें',
    ),
    action: AppLocalizationsDataAction(
      add: 'जोड़ें',
      cancel: 'रद्द करें',
      update: 'अपडेट करें',
      verify: 'सत्यापित करें',
      next: 'अगला',
    ),
    appUpdate: AppLocalizationsDataAppUpdate(
      heading: 'ऐप अपडेट',
      descritpion: 'एक नया संस्करण उपलब्ध है',
    ),
    common: AppLocalizationsDataCommon(
      noData: AppLocalizationsDataCommonNoData(
        description: 'कोई डेटा उपलब्ध नहीं',
      ),
    ),
    language: AppLocalizationsDataLanguage(
      changeLanguage: 'भाषा बदलें',
    ),
    logout: AppLocalizationsDataLogout(
      logout: 'लॉगआउट',
      heading: 'लॉगआउट',
      descritpion: 'क्या आप वाकई लॉगआउट करना चाहते हैं?',
    ),
    errorMessage: AppLocalizationsDataErrorMessage(
      invalidOTP: 'अमान्य OTP',
      somethingWrong: 'कुछ गलत हो गया',
      invalidMobile: 'अमान्य मोबाइल नंबर',
      invalidEmail: 'अमान्य ईमेल',
    ),
    about: AppLocalizationsDataAbout(
      privacyPolicy: 'गोपनीयता नीति',
    ),
    successMessage: AppLocalizationsDataSuccessMessage(
      otpSuccessful: 'OTP सफलतापूर्वक भेजा गया',
    ),
    plurals: AppLocalizationsDataPlurals(),
    templated: AppLocalizationsDataTemplated(
      date: AppLocalizationsDataTemplatedDate(),
      numbers: AppLocalizationsDataTemplatedNumbers(),
    ),
    dates: AppLocalizationsDataDates(
      month: AppLocalizationsDataDatesMonth(),
    ),
  ),
};

extension AppLocalizationsExtensions on BuildContext {
  AppLocalizationsData get localizations {
    return Localizations.of<AppLocalizationsData>(this, AppLocalizationsData)!;
  }
}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizationsData> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => localizedLabels.containsKey(locale);

  @override
  Future<AppLocalizationsData> load(Locale locale) =>
      SynchronousFuture<AppLocalizationsData>(localizedLabels[locale]!);
  
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

// final labels = AppLocalizations.of(context);
// print(labels.dates.month.february);
// print(labels.templated.hello(firstName: "World"));
// print(labels.templated.contact(Gender.male, lastName: "John"));
