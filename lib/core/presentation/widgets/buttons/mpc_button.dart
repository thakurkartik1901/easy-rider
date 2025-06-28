import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:flutter/material.dart';

class MPCButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? label;
  final String? image;
  final Color? bgColor;
  final Color? contentColor;
  final bool? isEnabled;

  const MPCButton({
    Key? key,
    this.onPressed,
    this.label,
    this.image,
    this.bgColor,
    this.contentColor,
    this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          isEnabled ?? true
              ? bgColor ?? AppConstants.buttonPrimary
              : AppConstants.buttonDisabled,
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
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 13, 0, 13),
        child: Row(
          children: [
            Expanded(
              child: MPCHeadingLabel(
                label: label!.toUpperCase(),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: contentColor ?? Colors.white,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            if (image != null)
              SizedBox(
                height: 20,
                width: 20,
                child: Image.asset(
                  image!,
                  color: contentColor ?? Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
