import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/theme/styles.dart';
import '../../blocs/auth/user_repository.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth.dart';
import 'create_account_button.dart';
import 'google_login_button.dart';
import 'login.dart';
import 'login_button.dart';
import 'package:flutter_svg/svg.dart';
import '/constants/assets.dart';
import '/services/services.dart';
import '/service_locator.dart';
import 'package:get_it/get_it.dart';
import 'login.i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:web_socket_channel/io.dart';

import '../../services/iot_core/iot_core.dart';

class LoginForm extends StatefulWidget {
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  LoginBloc? _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async{
        if (state.isFailure!) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                          'Error: ' + state.errorMsg.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        )),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting!) {
          FocusScope.of(context).requestFocus(new FocusNode());
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess!) {
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
          GetIt.I<NavigationService>().navTo('/', context: context, clearStack: true);

          // GetIt.I<IotCore>().getAuthService().
          // getService().then((channel) {
          //   channel.stream.listen((event) async{ 
          //     print(event.toString());
          //     if(event.toString()!="ok"){
          //       GetIt.I<LocalStorageService>().sToken = event;
          //     }
          //     await Future.delayed(Duration(seconds: 5)).whenComplete(() {
          //       channel.sink.add(GetIt.I<LocalStorageService>().sToken);
          //     });
          //   });
          // });
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final screenSize = MediaQuery.of(context).size;
          final logoWidget = Text(
            "PAS",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: screenSize.height / 16,),
          );

          return Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Positioned(
                top: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  decoration: BoxDecoration(color: Color.fromRGBO(228, 152, 110, 1)),
                ),
              ),
              Positioned(
                top: 30,
                height: (MediaQuery.of(context).size.height -30) * 0.4,
                child: Container(
                  padding: EdgeInsets.all(0.0),
                  color: Color.fromRGBO(228, 152, 110, 1),
                  width: MediaQuery.of(context).size.width,
                  height: (MediaQuery.of(context).size.height -30) * 0.4,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      // SvgPicture.asset(
                      //   AssetIcons.PASlogo,
                      //   height:50 ,
                      //   width: 50,
                      //   color: Color.fromRGBO(0, 122, 255, 1) ,
                      //   fit: BoxFit.fill,
                      // ),
                    ],
                  )
                  
                ),
              ),
              Positioned(
                height: (MediaQuery.of(context).size.height -30) * 0.65,
                width: MediaQuery.of(context).size.width *0.8,
                top: (30 + (MediaQuery.of(context).size.height -30) * 0.15),
                child: Container(
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(10)), boxShadow: [
                    BoxShadow(
                      blurRadius: 50,
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                    )
                  ]),
                  padding: EdgeInsets.all(0.0),    
                  width: MediaQuery.of(context).size.width*84,
                  child: Form(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage("assets/google_login_background.jpg"), fit: BoxFit.cover)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: (MediaQuery.of(context).size.height -30) * 0.3,
                          ),
                          Text("Ứng dụng quản lý thiết bị thời gian thực".i18n,textAlign: TextAlign.center,style: TextStyle(color: Colors.black),),
                          SizedBox(
                            height: (MediaQuery.of(context).size.height -30) * 0.1,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width *0.1, 5, MediaQuery.of(context).size.width *0.1, 5),
                            width: MediaQuery.of(context).size.width *0.2,
                            // height: 100,
                            child: GoogleLoginButton(),
                          ),

                        ],
                      ),
                    )
                    
                  ),
                ),
              ),
              Positioned(
                bottom: (MediaQuery.of(context).size.height -30) * 0.1,
                child: Column(
                  children: <Widget>[
                    Text("Version 0.0.0".i18n),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose login form");
  }
}
