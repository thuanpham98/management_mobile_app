import 'package:flutter/material.dart';
class SearchBar extends SearchDelegate{

  final List<String> listSearch;
  SearchBar(this.listSearch);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.device_hub),
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon:  Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String result="";
  @override
  Widget buildResults(BuildContext context) {
    // recentList.add(result);
    return Container(
      child: Center(
        child: Text(result),
      ),
    );
  }

  List<String> recentList =[];
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList =[];

    query.isEmpty ? suggestionList = recentList : suggestionList.addAll(listSearch.where((element) {
      return (element.contains(query.toLowerCase()) || element.contains(query.toUpperCase()));
    }));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context , index){
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          onTap: (){
            result = suggestionList[index];
            Navigator.of(context).pop(result);
          },
        );
      },
    );
  }
}