import 'package:easy_rider/core/application/app_providers.dart';
import 'package:easy_rider/core/application/language_notifier.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';
import 'package:easy_rider/core/libs/plugins/locator.dart';
import 'package:easy_rider/core/libs/plugins/navigation_service.dart';
import 'package:easy_rider/core/libs/plugins/route_generator.dart';
import 'package:easy_rider/core/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: MultiProvider(
        providers: AppProviders().get(),
        child: Consumer<LanguageNotifier>(
          builder: (_, languageNotifier, __) {
            return MaterialApp(
              title: 'easyrider',
              navigatorKey: locator<NavigationService>().yNavigatorKey,
              onGenerateRoute: RouteGenerator.generateRoute,
              routes: AppRoutes.routes,
              initialRoute: AppRoutes.splashScreen,
              debugShowCheckedModeBanner: false,
              locale: languageNotifier.getLocale(),
              theme: ThemeData(
                fontFamily: 'NotoSans',
                // colorScheme: ColorScheme.fromSwatch(
                //   primarySwatch: Colors.indigo,
                // ),
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: const Color(0xFF000000),
                  secondary: const Color(0xFF000000),
                ),
              ),
              localizationsDelegates: const [
                AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: localizedLabels.keys,
            );
          },
        ),
      ),
    );
  }
}
