import 'package:flutter/material.dart';

class MPCOutlinedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? label;
  final bool? isEnabled;
  final Color? contentColor;
  final Color? borderColor;

  const MPCOutlinedButton({
    Key? key,
    this.onPressed,
    this.label,
    this.isEnabled,
    this.contentColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        side: BorderSide(color: borderColor ?? Colors.white),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Text(
          label ?? '',
          style: TextStyle(
            fontSize: 18,
            color: contentColor ?? Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
