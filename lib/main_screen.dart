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

import 'home/home_screen.dart';

import 'dart:async';

class MainScreen extends StatefulWidget {
  final int? pageIndex;
  MainScreen({Key? key,this.pageIndex}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 1;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  bool _holdTimer = false;

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
          icon: Icon(Icons.schedule_outlined),
          label: 'Schedule'.i18n,
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).backgroundColor,
          icon: Icon(Icons.home_outlined),
          label: 'Home'.i18n,
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).backgroundColor,
          icon: Icon(Icons.settings_accessibility_outlined),
          label: 'Accessibility'.i18n,
        )
      ],
      onTap: (idx) {
        setState(() {
          _selectedIndex = idx;
        });
      },
    );
  }

  Future <Map<String,String>> _getUserInfor() async{
    Map<String,String> ret = {};

    ret['userName']=  (await GetIt.I<UserRepository>().getUserName())??"";
    
    ret['userEmail'] = (await GetIt.I<UserRepository>().getUser()) ?? "" ;

    ret['userPhoto']= (await GetIt.I<UserRepository>().getUserAvatar()) ?? "" ;

    return await Future.value(ret);
  }

  @override
  void initState() {
    _selectedIndex = widget.pageIndex??_selectedIndex;

    new Timer.periodic(Duration(minutes: 30), (timer) { 
      if(GetIt.I<LocalStorageService>().hasLoggedIn){
        // GetIt.I<IotCore>().getAuthService().refreshToken();
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
    });




    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NavigationService.appContext = context; //FIXME: change that
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        bottomNavigationBar: _renderBottomBar(),
        body: AppTabBar(
          selectedIndex: _selectedIndex,
          navigatorKeys: _navigatorKeys,
          childrens: <Widget>[
            Container(),
            HomeScreen(),
            FutureBuilder<Map<String,String>>(
              future: _getUserInfor(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.connectionState==ConnectionState.done){
                  return ProfileScreen(userName: snapshot.data["userName"],userEmail: snapshot.data["userEmail"],userPhoto: snapshot.data["userPhoto"]);
                }return Container(child: LinearProgressIndicator(),);
              }
            ),
          ],
        ),
      );
  }
}