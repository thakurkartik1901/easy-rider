import 'package:easy_rider/auth/application/auth_notifier.dart';
import 'package:easy_rider/core/application/language_notifier.dart';
import 'package:easy_rider/core/application/loader_notifier.dart';
import 'package:easy_rider/ride/application/ride_notifier.dart';
import 'package:easy_rider/home/application/user_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  List<SingleChildWidget> get() {
    return [
      ChangeNotifierProvider.value(value: LoaderNotifier()),
      ChangeNotifierProvider.value(value: LanguageNotifier()),
      ChangeNotifierProvider.value(value: AuthNotifier()),
      ChangeNotifierProvider.value(value: UserNotifier()),
      ChangeNotifierProvider.value(value: RideValueNotifier()),
    ];
  }
}
