import 'package:easy_rider/core/libs/packages/localizations.dart';
import 'package:flutter/material.dart';

class TabHeader extends StatelessWidget {
  final void Function()? onPressed;
  final String? label;
  const TabHeader({
    Key? key,
    this.onPressed,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = context.localizations;
    return Row(
      children: [
        Expanded(
          child: Text(
            label ?? '',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.zero,
          color: Colors.indigoAccent,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 3,
                right: 7,
                top: 2,
                bottom: 2,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text(
                    labels.action.add,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
