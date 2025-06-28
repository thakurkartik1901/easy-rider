import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';

import 'package:easy_rider/core/presentation/widgets/labels/mpc_heading.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:easy_rider/ride/presentation/active/active_tab.dart';
import 'package:easy_rider/ride/presentation/history/history_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideSection extends StatefulWidget {
  const RideSection({Key? key}) : super(key: key);

  @override
  _RideSectionState createState() => _RideSectionState();
}

class _RideSectionState extends State<RideSection>
    with TickerProviderStateMixin {
  late BuildContext _context;
  late AppLocalizationsData labels;
  late TabController _controller;
  late bool isTab = false;

  ValueNotifier valueNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      animationDuration: const Duration(microseconds: 100),
      vsync: this,
    );
    _controller.addListener(() {
      valueNotifier.value = _controller.index;
      _controller.animateTo(
        _controller.index,
        duration: const Duration(microseconds: 100),
      );
      FocusScope.of(_context).unfocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    labels = _context.localizations;
    isTab = Provider.of<UserNotifier>(context, listen: false).isTab;

    return Stack(
      children: [
        Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              margin: EdgeInsets.zero,
              color: Colors.white,
              child: ValueListenableBuilder(
                valueListenable: valueNotifier,
                builder: (context, value, child) {
                  return TabBar(
                    controller: _controller,
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.black,
                    indicatorColor: AppConstants.textPrimary,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(
                        child: _scrollingTab(
                          Icons.school_rounded,
                          labels.ride.active,
                          isSelected: value == 0,
                        ),
                      ),
                      Tab(
                        child: _scrollingTab(
                          Icons.work_rounded,
                          labels.ride.history,
                          isSelected: value == 1,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  ActiveTab(),
                  HistoryTab(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row _scrollingTab(IconData icon, String label, {bool isSelected = false}) {
    return Row(
      children: [
        // Icon(
        //   icon,
        //   color: isSelected
        //       ? AppConstants.textPrimary
        //       : AppConstants.textSecondaryLight,
        // ),
        // const SizedBox(
        //   width: 5,
        // ),
        MPCHeadingLabel(
          label: label,
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected
              ? AppConstants.textPrimary
              : AppConstants.textSecondaryLight,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
