import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ListShimmer extends StatefulWidget {
  const ListShimmer();
  @override
  _ListShimmerState createState() => _ListShimmerState();
}

class _ListShimmerState extends State<ListShimmer> {
  @override
  Widget build(BuildContext context) {
    final isTab = Provider.of<UserNotifier>(context, listen: false).isTab;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 16.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _shimmer(isTab),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    _shimmer(isTab),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    _shimmer(isTab),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmer(bool isTab) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
      child: Container(
        color: const Color.fromARGB(255, 244, 244, 244),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/home-banner.png',
                fit: BoxFit.cover,
                width: isTab ? 105 : 80,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: isTab ? 180 : 190,
                      height: isTab ? 30 : 65.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: isTab ? 380 : 190,
                      height: isTab ? 40 : 25.0,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: isTab ? 380 : 190,
                      height: isTab ? 40 : 30.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
