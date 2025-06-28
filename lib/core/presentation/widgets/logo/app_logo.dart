import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';

import 'package:flutter/material.dart';

class Applogo extends StatelessWidget {
  const Applogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.035,
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
        // MPCHeadingLabel(
        //   label: "easyrider",
        //   fontSize: 25,
        //   fontFamily: AppConstants.fontFamilyLora,
        //   fontWeight: FontWeight.w600,
        //   color: AppConstants.primaryColor,
        //   overflow: TextOverflow.visible,
        //   textAlign: TextAlign.left,
        //   maxLines: 3,
        // ),
        const MPCHeadingLabel(
          label: "Version 1.0.0",
          fontSize: 10,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
          color: AppConstants.textSecondaryLight,
          overflow: TextOverflow.visible,
          maxLines: 3,
        ),
      ],
    );
  }
}
