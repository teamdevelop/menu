import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import './../API/newsApi.dart';

class NewsDetail extends StatelessWidget{
  final String id;//接口请求所需参数
  const NewsDetail({ Key key , this.id}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.share),
            tooltip: 'Air it',
            onPressed: (){},
            ),
          new IconButton(
            icon: new Icon(Icons.event),
            tooltip: 'Restitch it',
            onPressed: (){},
          ),
      ],
      ),
      body: _content(),
    );
  }

  //返回给body的值，用到了FutureBuilder来处理API数据请求，省事不少
  _content(){
    return FutureBuilder(
      future: newsApi.get().getNewsDetail(id),
      builder: (BuildContext context,AsyncSnapshot snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.none:        //get未执行时
          case ConnectionState.waiting:     //get正在执行时
            return Center(
              child:  Container(
                child:  Text('loading...'),    //在页面中央显示正在加载
              ),
            );
          default:
            if (snapshot.hasError)    //get执行完成但出现异常
              return Center(
              child:  Container(
                child:  Text('Error: ${snapshot.error}'),    //在页面中央显示正在加载
              ),
            );
            else  //get正常执行完成
              // 创建列表，列表数据来源于snapshot的返回值，而snapshot就是get(widget.newsType)执行完毕时的快照
              // get(widget.newsType)执行完毕时的快照即函数最后的返回值。
              return _contentDetail(context, snapshot);
          }
      },
    );
  }
  //正文内容
  _contentDetail(BuildContext context,AsyncSnapshot snapshot){
    // print('snapshot.data:'+snapshot.data.toString());
    switch (snapshot.data){
      case Null:
        return Center(
              child:  Container(
                child:  Text('抱歉！出错了...'),    //在页面中央显示正在加载
              ),
            );
      default:
        return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //标题
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Text(snapshot.data['title'],textScaleFactor: 1.5,),
            ),
            
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //日期
                  Text(snapshot.data['created_at'],style: TextStyle(color:Colors.grey),textScaleFactor: 1.2,),
                  //浏览量
                  Container(
                    margin: EdgeInsets.fromLTRB(20.0, 0.0, 5.0, 0.0),
                    child:Icon(Icons.label,color: Colors.grey,),
                  ),
                  Text(snapshot.data['view_count'].toString(),style: TextStyle(color:Colors.grey),textScaleFactor: 1.2,),
                  
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                    child:Icon(Icons.inbox,color: Colors.grey,),
                  ),
                  //收藏量
                  Text(snapshot.data['forward_count'].toString(),style: TextStyle(color:Colors.grey),textScaleFactor: 1.2,),
                  
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(20.0, 0.0, 5.0, 0.0),
                  //   child:Text(_tag,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),textScaleFactor: 1.2,),
                  // ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: MarkdownBody(data:snapshot.data['content'].toString(),),
              // Text(snapshot.data['content'],style: TextStyle(),textScaleFactor: 1.3,)
            ),
            Divider(color: Colors.blueGrey,),
          ]
        ),
      );
    }
  }

}