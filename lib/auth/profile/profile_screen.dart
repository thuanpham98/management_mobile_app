import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:management/services/iot_core/auth_service.dart';

import 'package:permission_handler/permission_handler.dart';
import '../../blocs/auth/auth.dart';
import '../../blocs/auth/user_repository.dart';
import '../../constants/background.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../services/navigation_service.dart';
import '../../services/services.dart';
import 'language.dart';
import 'profile.i18n.dart';

import 'package:app_settings/app_settings.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../services/iot_core/iot_core.dart';

class ProfileScreen extends StatefulWidget {

  final bannerHigh = 150.0;

  final String? userName;
  final String? userEmail;
  final String? userPhoto;
  // bool _tracking;
  
  const ProfileScreen({this.userEmail,this.userName,this.userPhoto});

  @override
  State createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> with WidgetsBindingObserver{
  bool _isDarkMode = GetIt.I<LocalStorageService>().darkMode;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState stateLife) async {
    super.didChangeAppLifecycleState(stateLife);
    if (stateLife == AppLifecycleState.paused) {
      print("Pause");
    } else if (stateLife == AppLifecycleState.resumed) {
      print("resume");
    }
  }


  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  Widget _buildUserAvatar(BuildContext context) {
    return Container(
      height: 80,
      child: CircleAvatar(
        radius: 40.0,
        // child: Container(color: Colors.amberAccent,),
        backgroundImage: NetworkImage(widget.userPhoto!)
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 80,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.userName!,
              style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold,color: (_isDarkMode)?Colors.white:Colors.black),
            ),
            Text(
              widget.userEmail!,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold,color: (_isDarkMode)?Colors.white:Colors.black)
            ),
          ],
        ),
      
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    double bannerHeight = 150;

    return PreferredSize(
      preferredSize: Size.fromHeight(bannerHeight),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          padding:
              const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 40),
          child: SafeArea(
            child: Container(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildUserAvatar(context),
                    SizedBox(width: 8),
                    _buildUserInfo(context),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      color: Colors.black12,
      height: 1.0,
      indent: 75,
      //endIndent: 20,
    );
  }

  Widget _space(double sz) {
    return SizedBox(height: sz);
  }

  Widget _header(BuildContext context,String text) {
    return Text(text,
      style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold,fontFamily: 'FontAwesome',fontSize: 14), //TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
    );
  }

  List<Widget> _buildListSettings(BuildContext context) {
    List<Widget> ret = [];
    ret.add(
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context,'Tùy chọn'.i18n),
            _space(15.0),
            _buildItemLanguage(context),
            _space(15.0),
            _buildItemDarkTheme(context),
            _space(15.0),
            _header(context,'Others'.i18n),
            _space(15.0),
            _buildItemRate(context),
            _space(15.0),
            _buildItemAboutUs(context),
            _space(15.0),
            _buildItemLogout(context),
          ],
        ),
      )
    );

    return ret;
  }

  Widget _buildItemLanguage(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.only(bottom: 2.0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: GetIt.I<NavigationService>().getParentContext(),
            backgroundColor: Theme.of(context).backgroundColor,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              ),
            ),
            builder: (BuildContext context) => Language()
          );
        },
        child: Container(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.language_outlined,color: Colors.white,),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20,0,0,0),
                  child: Text("Language".i18n,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold,fontFamily: 'FontAwesome',fontSize: 16),
                  ),
                ),
                flex: 4,
              ),
              Expanded(
                child: Container(
                ),
                flex: 2,
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget _buildItemDarkTheme(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.only(bottom: 2.0),
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (_isDarkMode!)? Colors.white24.withOpacity(0.2) : Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.brightness_2,color: Colors.white,),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(20,0,0,0),
                child: Text('Dark Theme'.i18n,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold,fontFamily: 'FontAwesome',fontSize: 16),
                ),
              ),
              flex: 4,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child:  Switch(
                  value: GetIt.I<ThemeService>().darkMode,
                  onChanged: (bool value){
                    GetIt.I<ThemeService>().darkMode = value;
                  },
                  activeTrackColor: Colors.blue,
                  activeColor: Color(0xFF0066B4),
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTrackingTheme(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.only(bottom: 2.0),
      child:  Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.location_city,color: Colors.white,),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(20,0,0,0),
                child: Text('Tracking'.i18n,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold,fontFamily: 'FontAwesome',fontSize: 16),
                ),
              ),
              flex: 4,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child:  Switch(
                  value: GetIt.I<ThemeService>().darkMode,
                  onChanged: (bool value) async{
                    await AppSettings.openNotificationSettings().whenComplete(() async{
                      print("after setting");
                    });
                  },
                  activeTrackColor: Colors.blue,
                  activeColor: Color(0xFF0066B4),
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRate(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.only(bottom: 2.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.star_border_rounded,color: Colors.white,),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20,0,0,0),
                  child: Text('Rate this App'.i18n,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold,fontFamily: 'FontAwesome',fontSize: 16),
                  ),
                ),
                flex: 4,
              ),
              Expanded(
                child: Container(
                ),
                flex: 2,
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget _buildItemAboutUs(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.only(bottom: 2.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.info_outline,color: Colors.white,),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20,0,0,0),
                  child: Text('About Us'.i18n,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold,fontFamily: 'FontAwesome',fontSize: 16),
                  ),
                ),
                flex: 4,
              ),
              Expanded(
                child: Container(
                ),
                flex: 2,
              ),
            ],
          ),
        )
      ),
    );
        // onTap: () => {
        //   Navigator.push(
        //       NavigationService.appContext,
        //       MaterialPageRoute(
        //           builder: (context) => Scaffold(
        //                 appBar: AppBar(),
        //                 body: WebView(initialUrl: 'https://google.com'),
        //               )))
        // },
  }

  Widget _buildItemLogout(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(userRepository: GetIt.I<UserRepository>()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Container(
            height: 50,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.only(bottom: 2.0),
            child: GestureDetector(
              onTap: () async {
                await GetIt.I<IotCore>().getAuthService().getService().then((value) async{
                  await value.sink.close();
                  await AuthService.clearService();
                });
                GetIt.I<NavigationService>().navTo('/login', context: context, clearStack: true);
                BlocProvider.of<AuthBloc>(context).add(LoggedOut(context));
              },
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.settings_power,color: Colors.white,),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20,0,0,0),
                        child: Text('Logout'.i18n,
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold,fontFamily: 'FontAwesome',fontSize: 16,color: Colors.red),
                        ),
                      ),
                      flex: 4,
                    ),
                    Expanded(
                      child: Container(
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              )
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    BlocProvider.of<AuthBloc>(context).add(AppStarted());
    _isDarkMode = GetIt.I<LocalStorageService>().darkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(context),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(
                width: screenSize.width,
                child: Container(
                  width: screenSize.width /
                      (2 / (screenSize.height / screenSize.width)),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildListSettings(context),
                    ),
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
