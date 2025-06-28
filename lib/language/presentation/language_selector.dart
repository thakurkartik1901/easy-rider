import 'package:easy_rider/core/application/language_notifier.dart';
import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';

import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({
    super.key,
  });

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late BuildContext _context;
  late AppLocalizationsData labels;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    labels = _context.localizations;
    final height = MediaQuery.of(context).size.height;
    final isTab = Provider.of<UserNotifier>(context, listen: false).isTab;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.02),
          MPCHeadingLabel(
            label: labels.language.changeLanguage,
            fontSize: 25,
            fontFamily: AppConstants.fontFamilyLora,
            fontWeight: FontWeight.w600,
            color: AppConstants.textPrimary,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.start,
            maxLines: 7,
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Expanded(
            child: Consumer<LanguageNotifier>(
              builder: (context, languageNotifier, child) {
                return ListView.builder(
                  itemCount: languageOptions.length,
                  itemBuilder: (contex, index) {
                    final language = languageOptions[index];
                    return Column(
                      children: [
                        InkWell(
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            context
                                .read<LanguageNotifier>()
                                .updateLanguage(language.key!);
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.025,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MPCHeadingLabel(
                                  label: language.value!,
                                  fontSize: isTab ? 20 : 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppConstants.textSecondary,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.start,
                                  maxLines: 7,
                                ),
                                if (languageNotifier
                                        .languageState.currentLanguage ==
                                    language.key)
                                  const Icon(
                                    Icons.check_circle_outline,
                                    size: 20,
                                    color: AppConstants.onlineColor,
                                  )
                                else
                                  const SizedBox(
                                    width: 20,
                                    height: 20,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        if (languageOptions.length - 1 == index)
                          SizedBox(
                            height: height * 0.02,
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
