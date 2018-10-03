import 'package:flutter/material.dart';

class NewsTab {
  String text;
  String tab;
  NewsTab(this.text,this.tab);
}
//定义tab页基本数据结构
final List<NewsTab> NewsTabs = <NewsTab>[
  new NewsTab('金融','financial'),
  new NewsTab('科技','technology'),
  new NewsTab('医疗','medical'),
];

class TabNavigation extends StatelessWidget {
  TabNavigation({this.currentTab, this.onSelectTab});
  final NewsTab currentTab;
  final ValueChanged<NewsTab> onSelectTab;  //这个参数比较关键，需仔细理解下

  @override
  Widget build(BuildContext context) {
    return Row(
      children: NewsTabs.map((item){
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
            child: Text(item.text,style: TextStyle(color: _colorTabMatching(item: item)),), 
          ),
          onTap: ()=>onSelectTab(item,)
        );
      }).toList()       
    );
  }

  //定义tab被选中和没被选中的颜色样式
  Color _colorTabMatching({NewsTab item}) {
    return currentTab == item ? Colors.black : Colors.grey;
  }
}