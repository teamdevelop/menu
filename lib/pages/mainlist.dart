import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'newsList.dart';
import 'tabnavigater.dart';

class MainList extends StatefulWidget {
  const MainList({ Key key }) : super(key: key); //构造函数中增加参数
  @override
  _MainListState createState() => new _MainListState();
}

class _MainListState extends State<MainList> {

  NewsTab _currenttab = NewsTabs[0];

  void _selectTab(NewsTab tab){
    setState(() {
      _currenttab = tab;
    });
  }

  @override
  void initState() {
    super.initState();
    // print('${DateTime.now().toString()} News initState');
    // _tabController = new TabController(vsync: this, length: NewTabs.length,);
  }

 @override
 void dispose() {
  //  print('${DateTime.now().toString()} News dispose');
  //  _tabController.dispose();
   super.dispose();
 }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          new IconButton(
          icon: new Icon(Icons.person),
          tooltip: 'user center',
          onPressed: (){
            Navigator.pushNamed(context,'/user');
            },
          ),
        ],
        title: TabNavigation(
          currentTab: _currenttab,
          onSelectTab: _selectTab,
        ),
      ),
      body: Stack(
        children: NewsTabs.map((item) {
          return Offstage(
            offstage: _currenttab != item,
            child: NewsList(
              pageKey: PageStorageKey<NewsTab>(item),
              newsType: item.tab),
          );
        }).toList(),
      ),
    );
  }
}