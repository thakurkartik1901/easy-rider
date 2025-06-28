import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/presentation/widgets/buttons/mpc_back_button.dart';
import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:flutter/material.dart';

class CCCVHeader extends StatelessWidget {
  final Widget? trailingWidget;
  final String? label;
  final void Function()? onPressed;
  const CCCVHeader({Key? key, this.label, this.trailingWidget, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 5),
      child: Row(
        children: [
          MPCBackButton(
            onPressed: () {
              onPressed != null ? onPressed!() : Navigator.pop(context);
            },
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: MPCHeadingLabel(
              label: label ?? "",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.left,
              color: AppConstants.textPrimary,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          if (trailingWidget != null) trailingWidget!
        ],
      ),
    );
  }
}
