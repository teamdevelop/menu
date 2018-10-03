import 'package:flutter/material.dart';

class UserINFO extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: User()
      
    );
  }
}

class User extends StatelessWidget {
  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  var userAvatar;
  var userName;
  var titles = ["我的消息", "阅读历史", "我的评论", "我的问答", "我的活动", "我的团队", "邀请好友"];
  var imagePaths = [
    "lib/asset/image/ic_my_message.png",
    "lib/asset/image/ic_my_blog.png",
    "lib/asset/image/ic_my_question.png",
    "lib/asset/image/ic_discover_pos.png",
    "lib/asset/image/ic_my_team.png",
    "lib/asset/image/ic_my_recommend.png"
  ];

  var titleTextStyle = new TextStyle(fontSize: 16.0);
  var rightArrowIcon = new Image.asset(
    'lib/asset/image/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );

  @override
  Widget build(BuildContext context) {
//    return showCustomScrollView();
    var listView = new ListView.builder(
      itemBuilder: (context, i) => renderRow(context,i),
      itemCount:   titles.length * 2,
    );
    return listView;
  }

  renderRow(context, i) {
    final userHeaderHeight = 200.0;
    if (i == 0) {
      var userHeader = new Container(
          height: userHeaderHeight,
          color: Colors.blue,
          child: new Center(
              child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              userAvatar == null
                ? new Image.asset(
                    "lib/asset/image/ic_avatar_default.png",
                    width: 60.0,
                  )
                : new Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      image: new DecorationImage(
                          image: new NetworkImage(userAvatar),
                          fit: BoxFit.cover),
                      border:
                          new Border.all(color: Colors.white, width: 2.0)),
                  ),
              new Container(
                margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: new Text(
                  userName == null ? '点击头像登录' : userName,
                  style: new TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              )
            ],
          )));
      return new GestureDetector(
        onTap: () {
          Navigator.pushNamed(context,'/login');
        },
        child: userHeader,
      );
    }
    --i;
    if (i.isOdd) {
      return new Divider(
        height: 1.0,
      );
    }
    i = i ~/ 2;
    String title = titles[i];
    var listItemContent = new Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new Text(
            title,
            style: titleTextStyle,
          )),
          rightArrowIcon
        ],
      ),
    );
    return new InkWell(
      child: listItemContent,
      onTap: () {
        // Scaffold.of(context).showSnackBar(SnackBar(
        //   content: Text('Tap'),
        //   )
        // );
        Navigator.pushNamed(context,'/login');
      },
    );
  }
}

Widget showCustomScrollView() {
  return new CustomScrollView(
    slivers: <Widget>[
      const SliverAppBar(
        pinned: true,
        expandedHeight: 250.0,
        flexibleSpace: const FlexibleSpaceBar(
          title: const Text('Demo'),
        ),
      ),
      new SliverGrid(
        gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
          //横轴的最大长度
          maxCrossAxisExtent: 200.0,
          //主轴间隔
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          //横轴间隔
          childAspectRatio: 1.0,
        ),
        delegate: new SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return new Container(
              alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: new Text('grid item $index'),
            );
          },
          childCount: 20,
        ),
      ),
      new SliverFixedExtentList(
        itemExtent: 50.0,
        delegate:
            new SliverChildBuilderDelegate((BuildContext context, int index) {
          return new Container(
            alignment: Alignment.center,
            color: Colors.lightBlue[100 * (index % 9)],
            child: new Text('list item $index'),
          );
        }, childCount: 10),
      ),
    ],
  );
}
