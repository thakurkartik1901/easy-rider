import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:flutter/material.dart';

class MPCIconLabelButton extends StatelessWidget {
  final String? label;
  final Color? bgColor;
  final Color? labelColor;
  final String? image;
  final double? padding;
  final double? fontSize;
  final void Function()? onTap;

  const MPCIconLabelButton({
    Key? key,
    this.label,
    this.labelColor,
    this.bgColor,
    this.image,
    this.padding,
    this.fontSize,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          bgColor ?? AppConstants.buttonPrimary,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        side: MaterialStateProperty.all(
          const BorderSide(
            style: BorderStyle.none,
          ),
        ),
      ),
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, padding ?? 13, 0, padding ?? 13),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image != null)
              SizedBox(
                height: 22,
                width: 22,
                child: Image.asset(
                  image!,
                  color: labelColor ?? Colors.white,
                ),
              ),
            Expanded(
              child: MPCHeadingLabel(
                label: label!,
                fontSize: fontSize ?? 16,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                color: labelColor ?? Colors.white,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
