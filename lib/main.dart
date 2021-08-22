import 'package:flutter/material.dart';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart' as Fluro;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'services/analytics_service.dart';

import 'app_bloc_delegate.dart';
import 'services/navigation_service.dart';
import 'routers.dart';
import 'service_locator.dart';
import 'services/services.dart';
import 'services/theme/theme.dart';

Future<void> main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    Bloc.observer = AppBlocDelegate();
  
    try {
      await setupLocator();
    } catch (error) {
      print('Locator setup has failed');
    }

    runApp(AppComponent());
}

class AppComponent extends StatefulWidget {
  @override
  State createState() {
    return AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {
  AppComponentState() {
    final router = Fluro.FluroRouter();
    Routes.init(router);
    GetIt.I<NavigationService>().router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) {
            return locator<ThemeService>().getBloc();
          },
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState state) {
          return I18n(
            initialLocale: Locale("vi", ""),
            child: MaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en', "US"),
                const Locale('vi', ""),
              ],
              navigatorObservers: [
                GetIt.I<AnalyticsService>().getAnalyticsObserver(),
              ],
              debugShowCheckedModeBanner: false,
              theme: state.themeData,
              onGenerateRoute:
              GetIt.I<NavigationService>().router!.generator,
              navigatorKey: GetIt.I<NavigationService>().navigatorKey));
        }
      ),
    );
  }
}


