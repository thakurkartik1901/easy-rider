import 'package:easy_rider/core/constants/analytics_event.dart';
import 'package:easy_rider/core/libs/packages/event_service.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';

import 'package:easy_rider/core/presentation/widgets/shimmers/list_shimmer.dart';
import 'package:easy_rider/ride/application/ride_notifier.dart';
import 'package:easy_rider/ride/presentation/common/empty_widget.dart';
import 'package:easy_rider/ride/presentation/common/ride_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActiveTab extends StatefulWidget {
  const ActiveTab({Key? key}) : super(key: key);

  @override
  _ActiveTabState createState() => _ActiveTabState();
}

class _ActiveTabState extends State<ActiveTab>
    with AutomaticKeepAliveClientMixin<ActiveTab> {
  ValueNotifier<bool> enableSaveButton = ValueNotifier(false);
  late BuildContext _context;
  late AppLocalizationsData labels;

  @override
  void initState() {
    super.initState();
    EventService.logCurrentScreen(AnalyticsEvent.tabEducation);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _context = context;
    labels = _context.localizations;

    return Consumer<RideValueNotifier>(
      builder: (context, rideNotifier, _) {
        Widget widget = const ListShimmer();
        if (rideNotifier.rideState != RideState.inProgress) {
          widget = rideNotifier.activeRides.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: _pullRefresh,
                  child: ListView.builder(
                    itemCount: rideNotifier.activeRides.length,
                    padding:
                        const EdgeInsets.only(left: 12, top: 12, right: 12),
                    itemBuilder: (contex, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RideListItem(
                            rideNotifier.activeRides[index],
                          ),
                          if (index == rideNotifier.activeRides.length - 1) ...[
                            const SizedBox(height: 40)
                          ],
                        ],
                      );
                    },
                  ),
                )
              : EmptyCard(
                  label: labels.ride.noRidesAssigned,
                  onPressed: _pullRefresh,
                );
        }
        return widget;
      },
    );
  }

  Future<void> _pullRefresh() async {
    Future.microtask(
      () => _context.read<RideValueNotifier>().fetchActiveRides(),
    );
  }
}
