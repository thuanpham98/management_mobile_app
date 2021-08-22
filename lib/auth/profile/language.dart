import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n_extension/i18n_widget.dart';
import '../../services/language_service.dart';
import '../../services/localstorage_service.dart';
import 'profile.i18n.dart';

class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final GlobalKey<ScaffoldState> _scaffordKey = GlobalKey<ScaffoldState>();

  Function _getLanguagesList = () {
    return [
      {
        "name": "English".i18n,
        "icon": 'assets/images/country/gb.png',
        "code": "en",
        "text": "English",
        "storeViewCode": ""
      },
      {
        "name": "Vietnam".i18n,
        "icon": 'assets/images/country/vn.png',
        "code": "vi",
        "text": "Vietnam",
        "storeViewCode": ""
      }
    ];
  };

  void _showLoading(String language, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        'Change language successfully'.i18n,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(fontFamily: 'FontAwesome',fontSize: 15),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(context).accentColor,
      action: SnackBarAction(
        label: language,
        onPressed: () {
          print('press OK');
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // _scaffordKey.currentState?.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    List<Map<String, dynamic>> languages = _getLanguagesList();
    var lang = GetIt.I<LocalStorageService>().language;

    for (var i = 0; i < languages.length; i++) {
      list.add(
        ListTile(
            leading: Image.asset(
              languages[i]["icon"],
              width: 30,
              height: 20,
              fit: BoxFit.cover,
            ),
            title: Text(languages[i]["name"],style: Theme.of(context).textTheme.subtitle1?.copyWith(fontFamily: 'FontAwesome',),),
            trailing: lang == languages[i]["code"] ? Icon(Icons.check) : null,
            onTap: () {
              GetIt.I<LanguageService>().lang = languages[i]["code"];
              if (GetIt.I<LanguageService>().lang == "en") {
                I18n.of(context).locale = Locale("en", "us");
              } else {
                I18n.of(context).locale = Locale("vi", "");
              }
              _showLoading(languages[i]["text"],context);
            },
          ),
      );
      if (i < languages.length - 1) {
        list.add(
          Divider(
            color: Theme.of(context).dividerColor,
            height: 1.0,
//            indent: 75,
            //endIndent: 20,
          ),
        );
      }
    }
    return Container(
      height: MediaQuery.of(context).size.height/2,
      child: Scaffold(
        key: _scaffordKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Language'.i18n,
            style: Theme.of(context).textTheme.headline5?.copyWith(fontFamily: 'FontAwesome',color: Theme.of(context).accentColor,fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: list,
        ),
      ),
    );
  }
}
