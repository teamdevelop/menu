import 'package:flutter/material.dart';

class login extends StatelessWidget {
  TextEditingController _accountcontroller = new TextEditingController();
  TextEditingController _passwordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Image.asset('lib/asset/image/logo_menu.png',height: 200.0,width: 200.0,),
                Container(
                  margin: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                        child: Row(
                          children: <Widget>[
                            Text('账号',textScaleFactor: 1.5,),
                            Flexible(
                              child: TextField(
                                controller: _accountcontroller,
                                decoration: InputDecoration(
                                  hintText: '     请输入账号',
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.clear,color: Colors.grey,),
                                    onPressed: () {
                                      _accountcontroller.clear();
                                      _passwordcontroller.clear();
                                    },
                                  )
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                        child: Row(
                        children: <Widget>[
                          Text('密码',textScaleFactor: 1.5,),
                          Flexible(
                            child: TextField(
                              controller: _passwordcontroller,
                              decoration: InputDecoration(
                                hintText: '     请输入账号',
                                // suffixIcon: IconButton(
                                //   icon: Icon(Icons.clear,color: Colors.grey,),
                                //   onPressed: () {
                                //     _passwordcontroller.clear();
                                //   },
                                // )
                              ),
                              obscureText: true,
                            ),
                          )
                        ],
                      )
                    ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        iconSize: 64.0,
                        icon: Image.asset('lib/asset/image/icon64_wx_logo.png'),
                        onPressed: (){},
                      ),
                      IconButton(
                        iconSize: 64.0,
                        icon: Image.asset('lib/asset/image/icon64_wx_logo.png'),
                        onPressed: (){},
                      ),
                      IconButton(
                        iconSize: 64.0,
                        icon: Image.asset('lib/asset/image/icon64_wx_logo.png'),
                        onPressed: (){},
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}