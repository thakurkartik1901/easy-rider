import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:flutter/material.dart';

class MPCCardHeadingLabel extends StatelessWidget {
  final String label;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const MPCCardHeadingLabel({
    Key? key,
    required this.label,
    this.color,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.only(right: 5),
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
                Colors.white,
                Colors.white70,
                Colors.white60,
                Colors.white10,
              ],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 5, bottom: 15),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: MPCHeadingLabel(
                label: label,
                fontSize: fontSize ?? 16,
                color: color ?? Colors.black,
                fontWeight: fontWeight ?? FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
