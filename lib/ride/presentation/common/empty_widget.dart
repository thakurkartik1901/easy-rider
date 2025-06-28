import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';
import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  final String? label;
  final String? image;
  final void Function()? onPressed;
  const EmptyCard({Key? key, this.onPressed, this.image, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = context.localizations;

    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image ?? 'assets/images/notification-empty.png',
          height: height * 0.5,
        ),
        MPCHeadingLabel(
          label: label ?? labels.common.noData.description,
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: AppConstants.textSecondaryLight,
          overflow: TextOverflow.visible,
          maxLines: 3,
        ),
        SizedBox(
          height: height * (onPressed != null ? 0.02 : 0.1),
        ),
        if (onPressed != null)
          Center(
            child: InkWell(
              onTap: onPressed,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: CircleAvatar(
                maxRadius: 35,
                backgroundColor: AppConstants.buttonPrimary,
                child: MPCHeadingLabel(
                  label: labels.ride.reload,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.left,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
