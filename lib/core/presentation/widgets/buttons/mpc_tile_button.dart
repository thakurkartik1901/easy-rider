import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:flutter/material.dart';

class MPCTileButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final void Function()? onTap;
  const MPCTileButton(this.icon, this.label, this.onTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: ListTile(
          leading: icon != null
              ? ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: Container(
                    color: const Color.fromARGB(255, 209, 215, 251),
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      icon,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                )
              : null,
          title: MPCHeadingLabel(
            label: label,
            fontSize: 16,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w400,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
            color: Colors.black,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
