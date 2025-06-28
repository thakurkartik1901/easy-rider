import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MPCTextFormField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final String? labelText;
  final String? exampleText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isEnabled;
  final bool isMandatory;

  const MPCTextFormField({
    Key? key,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.labelText,
    this.exampleText,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isEnabled = true,
    this.isMandatory = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTab = Provider.of<UserNotifier>(context, listen: false).isTab;
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MPCHeadingLabel(
              label: labelText!,
              fontSize: isTab ? 18.0 : 14,
              fontWeight: FontWeight.w400,
              color: AppConstants.textSecondaryLight,
              overflow: TextOverflow.visible,
              maxLines: 3,
            ),
            // Text(
            //   labelText!,
            //   style: TextStyle(
            //     color: Colors.grey,
            //     fontSize: isTab ? 18.0 : 13,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            if (isMandatory)
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Icon(
                  Icons.sunny,
                  color: Colors.red,
                  size: isTab ? 12 : 7,
                ),
              ),
          ],
        ),
        SizedBox(
          height: isTab ? 3 : 2,
        ),
        TextFormField(
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                width: 2,
                style: BorderStyle.none,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 0.0,
              ),
            ),
            filled: true,
            counterText: '',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            hintText: exampleText ?? "",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: isTab ? 20.0 : 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          maxLines: maxLines,
          style: TextStyle(
            color: Colors.black,
            fontSize: isTab ? 20.0 : 14,
            fontWeight: FontWeight.w400,
          ),
          enabled: isEnabled,
          initialValue: initialValue,
          validator: validator,
          onChanged: onChanged,
        ),
        SizedBox(
          height: isTab ? 15.0 : 10,
        ),
      ],
    );
  }
}



//  return Stack(
//       children: [
//         if (isMandatory)
//           const Padding(
//             padding: EdgeInsets.only(top: 12.0),
//             child: Icon(
//               Icons.sunny,
//               color: Colors.orange,
//               size: 10,
//             ),
//           ),
//         Padding(
//           padding: const EdgeInsets.only(left: 12.0),
//           child: TextFormField(
//             keyboardType: keyboardType,
//             textInputAction: textInputAction,
//             decoration: InputDecoration(
//               labelText: labelText,
//               counterText: '',
//               labelStyle: TextStyle(
//                 color: Colors.grey[800],
//                 fontSize: 14,
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//             maxLines: maxLines,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//             ),
//             enabled: isEnabled,
//             initialValue: initialValue,
//             validator: validator,
//             onChanged: onChanged,
//           ),
//         ),
//       ],
//     );
//   }
