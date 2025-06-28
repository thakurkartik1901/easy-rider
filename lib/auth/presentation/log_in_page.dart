import 'package:easy_rider/auth/application/auth_notifier.dart';
import 'package:easy_rider/core/application/loader_notifier.dart';
import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';
import 'package:easy_rider/core/presentation/routes/app_routes.dart';
import 'package:easy_rider/core/presentation/validator/validator.dart';
import 'package:easy_rider/core/presentation/widgets/buttons/mpc_button.dart';
import 'package:easy_rider/core/presentation/widgets/components/app_scaffold.dart';
import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:easy_rider/core/presentation/widgets/logo/app_logo.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:easy_rider/language/presentation/language_bottomsheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  ValueNotifier<bool> enableSaveButton = ValueNotifier(false);
  String _phone = '';
  String _otp = '';

  bool isLoaderVisible = false;
  bool isTab = true;

  late BuildContext _context;
  late AppLocalizationsData labels;
  late double height;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    labels = _context.localizations;
    height = MediaQuery.of(context).size.height;
    isTab = Provider.of<UserNotifier>(context, listen: false).isTab;
    return AppScaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: SizedBox(
              height: height * 0.95,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 15,
                  ),
                  child: _body(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Consumer<AuthNotifier>(
      builder: (_, authNotifier, __) {
        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Applogo(),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      LanguageBottomsheet.openBottonSheet(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.language),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(labels.home.language),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height *
                      (MediaQuery.of(context).viewInsets.bottom != 0
                          ? 0.05
                          : 0.12),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MPCHeadingLabel(
                        label: labels.auth.signIn,
                        fontSize: 22,
                        fontFamily: AppConstants.fontFamilyLora,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.textSecondaryLight,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.left,
                        maxLines: 3,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      _phoneTextFormFieldWidget(),
                      ValueListenableBuilder<bool>(
                        valueListenable: enableSaveButton,
                        builder: (context, enableSaveButton, child) {
                          return _context.read<AuthNotifier>().authState ==
                                      AuthState.otpSent ||
                                  _context.read<AuthNotifier>().authState ==
                                      AuthState.otpVerifyfailure
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    _label(context, labels.auth.enterOTP),
                                    _otpTextFormFieldWidget(),
                                    SizedBox(
                                      height: height * 0.005,
                                    ),
                                    _resentOTPButtonWidget(),
                                  ],
                                )
                              : Container();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height *
                      (MediaQuery.of(context).viewInsets.bottom != 0
                          ? 0.37
                          : 0.3),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom != 0
                        ? height * 0.26
                        : 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _submitButtonWidget(),
                    SizedBox(height: height * 0.02),
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            MPCHeadingLabel(
                              label: labels.auth.privacyDeclaration,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppConstants.textSecondaryLight,
                              overflow: TextOverflow.visible,
                              maxLines: 3,
                            ),
                            InkWell(
                              onTap: () async {
                                navigate(
                                  context,
                                  "https://easyrider.com/privacy-policy/",
                                  labels,
                                );
                              },
                              child: MPCHeadingLabel(
                                label: labels.about.privacyPolicy,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: AppConstants.primaryColor,
                                overflow: TextOverflow.visible,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _label(BuildContext context, String label) {
    return MPCHeadingLabel(
      label: label,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppConstants.textPrimary,
      overflow: TextOverflow.visible,
      maxLines: 3,
    );
  }

  Widget _phoneTextFormFieldWidget() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      autofocus: true,
      maxLength: 10,
      decoration: InputDecoration(
        counterText: '',
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppConstants.textSecondary)),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        hintText: labels.auth.mobileHint,
        labelText: labels.auth.mobilePlaceholder,
        prefixIcon: const Icon(
          Icons.phone,
          color: Colors.green,
        ),
      ),
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 16,
            color: Colors.black,
          ),
      validator: Validator(labels).phoneNumber,
      onChanged: (value) {
        _phone = value;
        _context.read<AuthNotifier>().authState = AuthState.initial;
        enableSaveButton.value = true;
        enableSaveButton.value = false;
        shouldEnableButton();
      },
      cursorColor: Colors.black,
    );
  }

  Widget _otpTextFormFieldWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(right: isTab ? 400 : 130, top: 15),
        child: PinCodeTextField(
          appContext: context,
          length: 4,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          autoFocus: true,
          pinTheme: PinTheme(
            borderWidth: 0.5,
            shape: PinCodeFieldShape.box,
            inactiveColor: AppConstants.textSecondaryLight,
            activeColor: AppConstants.buttonPrimary,
            selectedColor: AppConstants.buttonPrimary,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: isTab ? 80 : 50,
            fieldWidth: isTab ? 80 : 50,
          ),
          animationDuration: const Duration(milliseconds: 300),
          onChanged: (value) {
            _otp = value;
            shouldEnableButton();
          },
        ),
      ),
    );
  }

  Widget _submitButtonWidget() {
    return ValueListenableBuilder<bool>(
      valueListenable: enableSaveButton,
      builder: (context, enableSaveButtonValue, child) {
        return MPCButton(
          isEnabled: enableSaveButtonValue,
          label: _context.read<AuthNotifier>().authState == AuthState.otpSent ||
                  _context.read<AuthNotifier>().authState ==
                      AuthState.otpVerifyfailure
              ? labels.action.verify
              : labels.action.next,
          onPressed: () async {
            if (enableSaveButtonValue) {
              FocusScope.of(_context).unfocus();
              if (_context.read<AuthNotifier>().authState ==
                      AuthState.initial ||
                  _context.read<AuthNotifier>().authState ==
                      AuthState.unauthenticated ||
                  _context.read<AuthNotifier>().authState ==
                      AuthState.otpSentfailure) {
                _context.read<LoaderNotifier>().showLoader();
                _context
                    .read<AuthNotifier>()
                    .sendOTP(_phone.trim(), _context)
                    .then(
                      (value) => _context.read<LoaderNotifier>().hideLoader(),
                    );
                enableSaveButton.value = false;
              } else {
                _context.read<LoaderNotifier>().showLoader();
                _context
                    .read<AuthNotifier>()
                    .verifyOTP(_phone.trim(), _otp, _context)
                    .then((authState) {
                  _context.read<LoaderNotifier>().hideLoader();
                  if (authState == AuthState.authenticated) {
                    Future.delayed(const Duration(milliseconds: 300)).then(
                      (value) {
                        if (mounted) {
                          Navigator.pushReplacementNamed(
                            _context,
                            AppRoutes.homeScreen,
                          );
                        }
                      },
                    );
                  }
                });
              }
            }
          },
        );
      },
    );
  }

  Widget _resentOTPButtonWidget() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        MPCHeadingLabel(
          label: labels.auth.didNotReceive,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppConstants.textSecondary,
          overflow: TextOverflow.visible,
          maxLines: 3,
        ),
        const SizedBox(width: 7),
        InkWell(
          onTap: () {
            _context.read<LoaderNotifier>().showLoader();
            _context.read<AuthNotifier>().sendOTP(_phone.trim(), _context);
            _context.read<LoaderNotifier>().hideLoader();
          },
          child: MPCHeadingLabel(
            label: labels.auth.resend,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppConstants.primaryColor,
            overflow: TextOverflow.visible,
            maxLines: 3,
          ),
        ),
      ],
    );
  }

  void shouldEnableButton() {
    if ((_context.read<AuthNotifier>().authState == AuthState.initial &&
            Validator(labels).phoneNumber(_phone) == null) ||
        ((_context.read<AuthNotifier>().authState == AuthState.otpSent ||
                _context.read<AuthNotifier>().authState ==
                    AuthState.otpVerifyfailure) &&
            Validator(labels).phoneNumber(_phone) == null &&
            _otp.length == 4)) {
      enableSaveButton.value = true;
    } else {
      enableSaveButton.value = true;
      enableSaveButton.value = false;
    }
  }

  Future<void> navigate(
    BuildContext context,
    String url,
    AppLocalizationsData labels,
  ) async {
    if (kIsWeb) {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } else {
      Navigator.pushNamed(
        context,
        AppRoutes.webScreen,
        arguments: {'title': labels.about.privacyPolicy, 'url': url},
      );
    }
  }
}
