import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:management/services/navigation_service.dart';
import '../services/localstorage_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: new BoxDecoration(
            color: GetIt.I<LocalStorageService>().darkMode? Colors.black:Colors.white
          ),
          // child: null
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink[200],
            elevation: 5,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              padding: const EdgeInsets.only(top: 40, left: 20),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Home Screen',
                        style: Theme.of(context).textTheme.headline6?.copyWith(),
                      ),
                    ),
                    flex: 8,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: IconButton(
                        onPressed: () async{
                          // await GetIt.I<NavigationService>().showBottomSheet(
                          //   context: GetIt.I<NavigationService>().getParentContext(),
                          //   builder: (_){
                          //     return Container(
                          //       color: Colors.black,
                          //       height: MediaQuery.of(context).size.height*0.95,
                          //     );
                          //   }
                          // );
                        }, 
                        icon: Icon(Icons.add_outlined,size: 32,)
                      ),
                    ),
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            child:null
          ),
          
        )
      ],
    );
  }
}