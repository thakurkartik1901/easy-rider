import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class MPCBackButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? label;
  final IconData? icon;
  final Color? bgColor;
  final Color? contentColor;
  final bool? isEnabled;
  final double? elevation;

  const MPCBackButton({
    Key? key,
    this.onPressed,
    this.label,
    this.icon,
    this.bgColor,
    this.contentColor,
    this.isEnabled,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 28,
        child: Image.asset(
          'assets/images/arrow-back.png',
          color: bgColor ?? AppConstants.textPrimary,
        ),
      ),
    );
  }
}
