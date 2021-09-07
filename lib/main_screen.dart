import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import '/services/navigation_service.dart';
import '/widgets/tabbar.dart';
import '/services/services.dart';

import '/constants/assets.dart';
import '/auth/profile/profile_screen.dart';
import 'main_screen.i18n.dart';
import '/blocs/auth/user_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:web_socket_channel/io.dart';

import 'services/iot_core/iot_core.dart';

class MainScreen extends StatefulWidget {
  final int? pageIndex;
  MainScreen({Key? key,this.pageIndex}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String? _userName;
  String? _userEmail;
  String? _photoURL;
  
  int _selectedIndex = 0 ;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  Widget _buildIcon(BuildContext context, String asset, int index, {double? height}) {

    return SvgPicture.asset(
      asset,
      height: height ?? 24.0,
      color: _selectedIndex == index
          ? Theme.of(context).textSelectionColor
          : Theme.of(context).accentColor,
    );
  }

  Widget _renderBottomBar() {
    return BottomNavigationBar(
      elevation: 5,
      // backgroundColor: Theme.of(context).backgroundColor,
      currentIndex: _selectedIndex,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Theme.of(context).textSelectionColor,
      unselectedItemColor: Theme.of(context).accentColor,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).backgroundColor,
          icon: Icon(Icons.map_sharp),
          label: 'Monitoring'.i18n,
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).backgroundColor,
          icon: _buildIcon(context, AssetIcons.Farm, 1),
          label: 'Location'.i18n,
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).backgroundColor,
          icon: _buildIcon(context, AssetIcons.Pump, 2),
          label: 'Station'.i18n,
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).backgroundColor,
          icon: _buildIcon(context, AssetIcons.Automation, 3),
          label: 'Automation'.i18n,
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).backgroundColor,
          icon: Icon(Icons.notifications),
          label: 'Notification'.i18n,
        )
      ],
      onTap: (idx) {
        setState(() {
          _selectedIndex = idx;
        });
      },
    );
  }

  @override
  void initState() {
    _selectedIndex = widget.pageIndex??_selectedIndex;

    setState(() {
      GetIt.I<UserRepository>().getUserName().then((value) {
        _userName=value??"";

      });
      GetIt.I<UserRepository>().getUser().then((value) {
        _userEmail=value??"";

      });

      GetIt.I<UserRepository>().getUserAvatar().then((value) {
        _photoURL=value??"";

      });


    });
    if(GetIt.I<LocalStorageService>().hasLoggedIn){
      GetIt.I<IotCore>().getAuthService().getService().then((channel) {
      channel.stream.listen((event) async{ 
        print(event.toString());
        if(event.toString()!="ok"){
          GetIt.I<LocalStorageService>().sToken = event;
        }
        await Future.delayed(Duration(hours: 1)).whenComplete(() {
          channel.sink.add(GetIt.I<LocalStorageService>().sToken);
        });
      });
    });
    }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NavigationService.appContext = context; //FIXME: change that
    return Scaffold(
        drawer: Drawer(
          child: ProfileScreen(userName: _userName,userEmail: _userEmail,userPhoto: _photoURL),
        ),

        backgroundColor: Theme.of(context).backgroundColor,
        bottomNavigationBar: _renderBottomBar(),
        body: AppTabBar(
          selectedIndex: _selectedIndex,
          navigatorKeys: _navigatorKeys,
          childrens: <Widget>[
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
          ],
        ),
      );
  }
}