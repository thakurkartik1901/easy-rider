import 'package:easy_rider/core/application/loader_notifier.dart';
import 'package:easy_rider/core/constants/analytics_event.dart';
import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/event_service.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';

import 'package:easy_rider/core/presentation/widgets/shimmers/list_shimmer.dart';
import 'package:easy_rider/ride/application/ride_notifier.dart';
import 'package:easy_rider/ride/presentation/common/empty_widget.dart';
import 'package:easy_rider/ride/presentation/common/ride_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab>
    with AutomaticKeepAliveClientMixin<HistoryTab> {
  late BuildContext _context;
  late AppLocalizationsData labels;
  late ScrollController _scrollController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _pullRefresh();
    EventService.logCurrentScreen(AnalyticsEvent.tabEducation);
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.extentAfter <= 0) {
      if (!_isLoading) {
        _isLoading = true;
        _context.read<LoaderNotifier>().showLoader();
        _context.read<RideValueNotifier>().fetchCompletedRides().then((value) {
          _isLoading = false;
          _context.read<LoaderNotifier>().hideLoader();
        });
      }
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _context = context;
    labels = _context.localizations;

    return Consumer<RideValueNotifier>(
      builder: (context, rideNotifier, _) {
        Widget widget = const ListShimmer();
        if (rideNotifier.rideState != RideState.inProgress) {
          widget = rideNotifier.completedRides.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: _pullRefresh,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: rideNotifier.completedRides.length,
                    padding:
                        const EdgeInsets.only(left: 12, top: 12, right: 12),
                    itemBuilder: (contex, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RideListItem(
                            rideNotifier.completedRides[index],
                          ),
                          if (index ==
                              rideNotifier.completedRides.length - 1) ...[
                            const SizedBox(height: 40)
                          ],
                        ],
                      );
                    },
                  ),
                )
              : EmptyCard(
                  label: labels.ride.noCompletedRides,
                  image: 'assets/images/intro-one.png',
                  onPressed: _pullRefresh,
                );
        }
        return widget;
      },
    );
  }

  Future<void> _pullRefresh() async {
    Future.microtask(
      () => _context
          .read<RideValueNotifier>()
          .fetchCompletedRides(hardRefresh: true),
    );
  }
}
