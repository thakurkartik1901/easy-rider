import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MPCHeadingLabel extends StatelessWidget {
  final String label;
  final String? fontFamily;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontStyle? fontStyle;

  const MPCHeadingLabel({
    Key? key,
    required this.label,
    this.fontFamily,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.overflow,
    this.textAlign,
    this.maxLines,
    this.fontStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines ?? 1,
      overflow: overflow ?? TextOverflow.fade,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: fontWeight ?? FontWeight.w500,
            fontSize: (fontSize ?? 22) +
                (Provider.of<UserNotifier>(context, listen: false).isTab
                    ? 8.0
                    : 0),
            fontStyle: fontStyle ?? FontStyle.normal,
            fontFamily: fontFamily ?? AppConstants.fontFamilyNotoSans,
            color: color ?? Colors.black,
          ),
    );
  }
}
