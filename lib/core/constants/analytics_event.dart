class AnalyticsEvent {
  static final AnalyticsEvent _singleton = AnalyticsEvent._internal();

  AnalyticsEvent._internal();

  factory AnalyticsEvent() {
    return _singleton;
  }

  static const String screenOnboarding = "onboarding_screen";
  static const String screenAuthentication = "authentication_screen";
  static const String screenFeedback = "feedback_screen";
  static const String screenAddReferCode = "add_refer_code_screen";
  static const String screenHome = "home_screen";
  static const String screenTemplate = "template_screen";
  static const String screenLanguage = "language_screen";
  static const String screenAccount = "account_screen";
  static const String tabProfileDetail = "profile_detail_tab";
  static const String tabEducation = "education_tab";
  static const String tabWork = "work_tab";
  static const String tabCertificate = "certificate_tab";
  static const String tabAchievement = "achievement_tab";
  static const String tabSoftSkill = "soft_skill_tab";
  static const String tabTechnicalSkill = "technical_skill_tab";
  static const String tabLanguage = "language_tab";
  static const String tabInterest = "interest_tab";
  static const String tabReference = "reference_tab";

  static const String eventLogin = "login";
  static const String eventSignup = "sign_up";
  static const String eventShare = "share";
  static const String eventSelectItem = "select_item";
  static const String eventDownloadSuccess = "download_success";

  static const String keyVersion = "version";
  static const String keyItemListId = "itemListId";
  static const String keyItemListName = "itemListName";
}
