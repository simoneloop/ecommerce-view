import 'dart:html';

class WebStorage {

  //Singleton
  WebStorage._internal();
  static final WebStorage instance = WebStorage._internal();
  factory WebStorage() {
    return instance;
  }

  void storeData(Map<String,String> data){
    data.forEach((key, value) {window.localStorage[key] = value; });
  }
  Map<String,dynamic> loadData(List<String>list){
    Map<String,dynamic> res={};
    list.forEach((element) {res[element]=window.localStorage[element]; });
    return res;
  }
  void eraseData(){
    window.localStorage.clear();
  }

  /*String get sessionId => window.localStorage['SessionId']!=null?window.localStorage['SessionId']!:"";
  set sessionId(String sid) => (sid == null) ? window.localStorage.remove('SessionId') : window.localStorage['SessionId'] = sid;*/
}