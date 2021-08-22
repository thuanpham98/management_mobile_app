import 'package:fluro/fluro.dart' as Fluro;
import 'package:flutter/material.dart';

import '../service_locator.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  Fluro.FluroRouter? router;
  static BuildContext? appContext;

  static NavigationService? _instance;

  static NavigationService getInstance() {
    if (_instance == null) {
      _instance = NavigationService();
    }
    return _instance!;
  }

  Future<dynamic> navTo(String path,
      {BuildContext?  context,
      Fluro.TransitionType transition = Fluro.TransitionType.custom, // custom allow dev custom Object transitionBuilder
      Duration transitionDuration = const Duration(milliseconds: 300),
      RouteTransitionsBuilder? transitionBuilder,
      bool clearStack = false}) {
      transitionBuilder=(
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
          );

    if (context != null) {
      return router!.navigateTo(context, path,
          transition: transition,
          transitionDuration: transitionDuration,
          transitionBuilder: transitionBuilder,
          clearStack: clearStack);
    }

    return router!.navigateTo(appContext!, path,
        transition: transition,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder);
  }

  void navPop({BuildContext? context}) {
    if (context != null) {
      return Navigator.pop(context);
    }
    return Navigator.pop(appContext!);
  }

  void navPush<T extends Object>(Route<T> route, {BuildContext? context}) {
    if(context == null){
      Navigator.of(appContext!).push(route);
    }else{
      Navigator.of(context).push(route);
    }
  }

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }

  Future<dynamic> showBottomSheet({Function? builder, BuildContext? context}) {
    BuildContext? ctx = context ?? appContext;
    log?.v('Show bottom sheet $context');
    return showModalBottomSheet(elevation: 12,
      // useRootNavigator: true,
      // isDismissible: false,
      context: ctx!,
      backgroundColor: Theme.of(ctx).primaryColorLight,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20.0),
          topRight: const Radius.circular(20.0),
        ),
      ),
      builder: builder??Function.apply((BuildContext _context){return Container();}, []));
  }

  BuildContext getParentContext() {
    return appContext!;
  }
}
