import 'dart:convert';
import 'dart:async';
import 'dart:io';  

class newsApi {
  //单例模式
  static final _newsApi = new newsApi._();

  newsApi._();

  static newsApi get(){
    return _newsApi;
  }

  final _httpClient = new HttpClient();
  final String _url = '此处大家用自己的请求地址吧';

  //获取新闻列表
  
  // Future<Map> getNewsList(String type,int limit,int offset) async {
  //   var request = await _httpClient.getUrl(Uri.parse('$_url?type=$type&limit=$limit&offset=$offset'));  
  //   var response = await request.close();
  //   var dataT = await response.transform(utf8.decoder).join();
  //   print(jsonDecode(dataT));
  //   return jsonDecode(dataT)['data']!=null?jsonDecode(dataT):[{'nomessage':''}];
  // }

  //和上面的被注释的代码效果一致，感受一下flutter版promise用法的优雅
  Future<Map> getNewsList(String type,int limit,int offset) async {
    return await _httpClient.getUrl(Uri.parse('$_url?type=$type&limit=$limit&offset=$offset'))
      .then((HttpClientRequest request) => request.close())
      .then((HttpClientResponse response) =>response.transform(utf8.decoder).join())
      .then((String data)=> jsonDecode(data)['error']==null?jsonDecode(data):[{'nonmessage':''}]);
  }

  //获取新闻详情
  Future<Map> getNewsDetail(String id) async {
    return await _httpClient.getUrl(Uri.parse('$_url/$id'))
      .then((HttpClientRequest request) => request.close())
      .then((HttpClientResponse response) =>response.transform(utf8.decoder).join())
      .then((String data)=> jsonDecode(data)['error']==null?jsonDecode(data)['data']:jsonDecode(data));
  }
}