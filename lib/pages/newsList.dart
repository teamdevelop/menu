import 'package:flutter/material.dart';
import './../API/newsApi.dart';
import 'newsDetail.dart';
import 'tabnavigater.dart';

//新闻列表

class NewsList extends StatefulWidget{
  @override
  NewsList({this.newsType,this.pageKey});

  final PageStorageKey<NewsTab> pageKey; //当前控件唯一标识Key
  final String newsType; 
  
  NewsListState createState() => new NewsListState();
}

class NewsListState extends State<NewsList>{

  List<Map> dataList = new List();//注意要给dataList分配空间，否则无法直接使用List对象的内置函数

  //当控件插入控件树时触发，适合初始化变量
  @override
  void initState(){
    super.initState();
    print('${DateTime.now().toString()} NewsList ${widget.newsType} initState');
    getData();
  }
  //紧跟在initState之后调用
  @override
  void didChangeDependencies() {
    print('${DateTime.now().toString()} NewsList ${widget.newsType} didChangeDependencies');
    super.didChangeDependencies();
  }
  //当组件的状态改变的时候就会调用
  @override
  void didUpdateWidget(NewsList oldWidget) {
    print('${DateTime.now().toString()} NewsList ${widget.newsType} didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }
  //在控件dispose之前，会调用这个函数
  @override
  void deactivate() {
    print('${DateTime.now().toString()} NewsList ${widget.newsType} deactivate');
    super.deactivate();
  }
  //在控件dispose之后调用，组件已销毁，一般用于移除监听，清理环境
  @override
  void dispose() {
    print('${DateTime.now().toString()} NewsList ${widget.newsType} dispose');
    super.dispose();
  }

  //获取数据并更新状态
  getData() async {
    await newsApi.get().getNewsList(widget.newsType,10,0)
      .then((request) {
        List<Map> a = new List();   //这句new很重要，数组对象实例化，否则无法运行a.add()
        if (request['success']==true){
          for(int i=0;i<request['data']['items'].length;i++){
            a.add(request['data']['items'][i]);
          }
          return a;   //此处的意义便是把网络请求获取到的数据标准化，否则无法直接赋值给dataList
        }else return null;
      })
      .then((list){
        setState((){
        dataList.addAll(list);
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return _list(context, dataList);
  }

//这里加入了BuildContext context，是为了把获取到的context传递到子控件，以用于Navigator做页面跳转
_list(BuildContext context, List dataList){
    
    switch (dataList) {
      case null:   //没有获取到数据，则返回请求失败的原因
        return Center(
          child: Card(
            child: Text('加载ing...'),
          ),
        );
      default:
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: dataList.length,
          itemBuilder: (context, i) {
              //context参数相当于当前控件在控件树中的锚点，
              //缺少这个参数会导致列表中的项目无法通过MaterialPageRoute进入下一个页面
              return _newsRow(dataList[i],context);
            }
          );
    }
  }

  //新闻列表单个item
  _newsRow(Map newsInfo,BuildContext context){
    return ListTile(
      title: Card(
        margin: EdgeInsets.all(0.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(newsInfo["title"],textScaleFactor: 1.2) ,
              margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              ),
            Container(
              margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: 
                Text(
                  newsInfo["content"],
                  overflow: TextOverflow.ellipsis,
                  maxLines:3
                  ),
                
            ),
            new Container(
              padding:const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 10.0),
              child:new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Expanded(   
                    child: new Text(newsInfo["author"]),
                  ),
                  new Expanded(
                    child: new Text(newsInfo["created_at"],style: new TextStyle(color: Colors.grey)),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => NewsDetail(
              id:newsInfo["id"].toString()
              )
            )
          );
      },
    );
  }
}