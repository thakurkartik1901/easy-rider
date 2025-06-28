import 'package:flutter/material.dart';

class MPCHeadingExtraBigLabel extends StatelessWidget {
  final String label;
  final Color? color;

  const MPCHeadingExtraBigLabel({
    Key? key,
    required this.label,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 30,
            color: color ?? Colors.black,
          ),
    );
  }
}
