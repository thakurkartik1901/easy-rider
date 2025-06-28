import 'package:easy_rider/core/libs/packages/localizations.dart';
import 'package:easy_rider/ride/model/address.dart';
import 'package:easy_rider/ride/model/customer.dart';

class Ride {
  Ride({
    this.id,
    this.customer,
    this.pickup,
    this.drop,
    this.pickupTime,
    this.startTime,
    this.endTime,
    this.status,
  });

  String? id;
  Customer? customer;
  Address? pickup;
  Address? drop;
  DateTime? pickupTime;
  DateTime? startTime;
  DateTime? endTime;
  String? status;

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['_id'] != null ? json['_id'] as String : null,
      customer: json['customer'] != null
          ? Customer.fromJson(json['customer'] as Map<String, dynamic>)
          : null,
      pickup: json['pickupLocation'] != null
          ? Address.fromJson(json['pickupLocation'] as Map<String, dynamic>)
          : null,
      drop: json['dropoffLocation'] != null
          ? Address.fromJson(json['dropoffLocation'] as Map<String, dynamic>)
          : null,
      pickupTime: json['pickupTime'] != null && json['pickupTime'] != ""
          ? DateTime.parse(json['pickupTime'] as String)
          : null,
      startTime: json['startTime'] != null && json['startTime'] != ""
          ? DateTime.parse(json['startTime'] as String)
          : null,
      endTime: json['endTime'] != null && json['endTime'] != ""
          ? DateTime.parse(json['endTime'] as String)
          : null,
      status: json['status'] != null && json['status'] != ""
          ? json['status'] as String
          : null,
    );
  }

  bool isBeforePickup(AppLocalizationsData labels) {
    bool isBeforePickup = false;
    final status = this.status;
    if (status == 'Pending' ||
        status == 'Confirmed' ||
        status == 'On Hold' ||
        status == 'Waiting List') {
      isBeforePickup = true;
    }
    return isBeforePickup;
  }

  bool isBeforeEnd(AppLocalizationsData labels) {
    bool isBeforeEnd = false;
    final status = this.status;
    if (status == 'Checked-In' || status == 'In Progress') {
      isBeforeEnd = true;
    }
    return isBeforeEnd;
  }

  bool isNotcompleted(AppLocalizationsData labels) {
    bool notCompleted = false;
    final status = this.status;
    if (status == 'Pending' ||
        status == 'Confirmed' ||
        status == 'Checked-In' ||
        status == 'In Progress' ||
        status == 'On Hold' ||
        status == 'Waiting List') {
      notCompleted = true;
    }
    return notCompleted;
  }

  bool isCompleted(AppLocalizationsData labels) {
    bool completed = false;
    final status = this.status;
    if (status == 'Cancelled' ||
        status == 'Completed' ||
        status == 'No-Show' ||
        status == 'Rejected' ||
        status == 'Expired' ||
        status == 'Refunded' ||
        status == 'Partial Payment') {
      completed = true;
    }
    return completed;
  }

  String getStatus(AppLocalizationsData labels) {
    String label = "";
    final status = this.status;
    if (status == 'Pending') {
      label = labels.rideStatus.pending;
    } else if (status == 'Confirmed') {
      label = labels.rideStatus.confirmed;
    } else if (status == 'Cancelled') {
      label = labels.rideStatus.cancelled;
    } else if (status == 'Completed') {
      label = labels.rideStatus.completed;
    } else if (status == 'In Progress') {
      label = labels.rideStatus.inProgress;
    } else if (status == 'Waiting for Payment') {
      label = labels.rideStatus.waitingforPayment;
    } else if (status == 'Checked-In') {
      label = labels.rideStatus.checkedIn;
    } else if (status == 'Checked-Out') {
      label = labels.rideStatus.checkedOut;
    } else if (status == 'No-Show') {
      label = labels.rideStatus.noShow;
    } else if (status == 'On Hold') {
      label = labels.rideStatus.onHold;
    } else if (status == 'Rescheduled') {
      label = labels.rideStatus.rescheduled;
    } else if (status == 'Rejected') {
      label = labels.rideStatus.rejected;
    } else if (status == 'Pending Approval') {
      label = labels.rideStatus.pendingApproval;
    } else if (status == 'Pending Availability') {
      label = labels.rideStatus.pendingAvailability;
    } else if (status == 'Expired') {
      label = labels.rideStatus.expired;
    } else if (status == 'Refunded') {
      label = labels.rideStatus.refunded;
    } else if (status == 'Partial Payment') {
      label = labels.rideStatus.partialPayment;
    } else if (status == 'Waiting List') {
      label = labels.rideStatus.waitingList;
    } else if (status == 'Custom Status') {
      label = labels.rideStatus.customStatus;
    }
    return label;
  }
}

// [
//       'Pending',
//       'Confirmed',
//       'Cancelled',
//       'Completed',
//       'In Progress',
//       'Waiting for Payment',
//       'Checked-In',
//       'Checked-Out',
//       'No-Show',
//       'On Hold',
//       'Rescheduled',
//       'Rejected',
//       'Pending Approval',
//       'Pending Availability',
//       'Expired',
//       'Refunded',
//       'Partial Payment',
//       'Waiting List',
//       'Custom Status',
//     ]
