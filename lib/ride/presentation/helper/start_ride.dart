import 'package:easy_rider/core/application/loader_notifier.dart';
import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';

import 'package:easy_rider/core/presentation/widgets/buttons/mpc_button.dart';
import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:easy_rider/ride/application/ride_notifier.dart';
import 'package:easy_rider/ride/model/ride.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class StartRide extends StatefulWidget {
  final Ride? ride;
  const StartRide(this.ride, {super.key});

  @override
  _StartRideState createState() => _StartRideState();
}

class _StartRideState extends State<StartRide> {
  ValueNotifier<bool> enableSaveButton = ValueNotifier(false);

  String _otp = '';

  bool isTab = true;

  late BuildContext _context;
  late AppLocalizationsData labels;
  late double height;

  @override
  Widget build(BuildContext context) {
    _context = context;
    labels = _context.localizations;
    height = MediaQuery.of(context).size.height;
    isTab = Provider.of<UserNotifier>(context, listen: false).isTab;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.02),
        MPCHeadingLabel(
          label: labels.ride.startRideFor,
          fontSize: 12,
          fontFamily: AppConstants.fontFamilyLora,
          fontWeight: FontWeight.w400,
          color: AppConstants.textPrimary,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.start,
          maxLines: 7,
        ),
        if (widget.ride?.customer?.name != null)
          MPCHeadingLabel(
            label: widget.ride?.customer?.name ?? '',
            fontSize: 25,
            fontFamily: AppConstants.fontFamilyLora,
            fontWeight: FontWeight.w600,
            color: AppConstants.textPrimary,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.start,
            maxLines: 7,
          ),
        MPCHeadingLabel(
          label: widget.ride?.customer?.phoneNumber ?? '',
          fontSize: 16,
          fontFamily: AppConstants.fontFamilyLora,
          fontWeight: FontWeight.w400,
          color: AppConstants.textPrimary,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.start,
          maxLines: 7,
        ),
        SizedBox(height: height * 0.02),
        _label(context, labels.auth.enterOTP),
        _otpTextFormFieldWidget(),
        _submitButtonWidget(),
        SizedBox(
          height: height *
              (MediaQuery.of(context).viewInsets.bottom != 0 ? 0.37 : 0.3),
        ),
      ],
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
          enablePinAutofill: false,
          autoDismissKeyboard: false,
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
          label: labels.ride.submit,
          onPressed: () async {
            if (enableSaveButtonValue) {
              FocusScope.of(_context).unfocus();
              _context.read<LoaderNotifier>().showLoader();
              _context
                  .read<RideValueNotifier>()
                  .startRide(widget.ride!.id!, _otp, _context)
                  .then((authState) {
                _context.read<LoaderNotifier>().hideLoader();
                if (authState == RideStatusUpdate.success) {
                  if (mounted) {
                    widget.ride?.startTime = DateTime.now();
                    widget.ride?.status = "In Progress";
                    _context
                        .read<RideValueNotifier>()
                        .updateRidesData(widget.ride!);
                    Navigator.pop(context);
                  }
                }
              });
            }
          },
        );
      },
    );
  }

  void shouldEnableButton() {
    if (_otp.length == 4 &&
            _context.read<RideValueNotifier>().rideStatusUpdateState ==
                RideStatusUpdate.initial ||
        _context.read<RideValueNotifier>().rideStatusUpdateState ==
            RideStatusUpdate.otpVerifyfailure) {
      enableSaveButton.value = true;
    } else {
      enableSaveButton.value = true;
      enableSaveButton.value = false;
    }
  }
}
