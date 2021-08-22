import 'package:flutter/material.dart';

class AppTabBar extends StatefulWidget {
  final int? selectedIndex;
  final List<GlobalKey<NavigatorState>>? navigatorKeys;
  final List<Widget>? childrens;

  int? _size;

  AppTabBar(
      {@required this.selectedIndex,
      @required this.navigatorKeys,
      @required this.childrens}) {
    _size = childrens!.length;
  }

  @override
  _AppTabBarState createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(widget._size!, (index) {
        return _buildOffstageNavigator(index);
      }),
    );
  }

  Widget _buildOffstageNavigator(int index) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouterInCurrentTab =
            !await widget.navigatorKeys![index].currentState!.maybePop();

        return isFirstRouterInCurrentTab;
      },
      child: Offstage(
        offstage: widget.selectedIndex != index,
        child: _BottomBarNavigator(
          navigatorKey: widget.navigatorKeys![index],
          child: widget.childrens![index],
        ),
      ),
    );
  }
}

class _BottomBarNavigator extends StatelessWidget {
  _BottomBarNavigator({
    @required this.child,
    this.navigatorKey,
  });

  final Widget? child;
  final GlobalKey<NavigatorState>? navigatorKey;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      '/': (context) {
        return child!;
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name]!(context),
        );
      },
    );
  }
}
