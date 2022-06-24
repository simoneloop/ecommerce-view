
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

enum TypeHeader {
  json,
  urlencoded
}

class RestManager{
  String token="";


  // ignore: unused_element
  Future<String> _makeRequest(String serverAddress,String servicePath,String method,TypeHeader type,{ Map<String, String>? params, dynamic body})async{
    Uri uri = Uri.http(serverAddress, servicePath, params);
    int i=0;
    int tents=3;

    while(i<tents) {
      i++;
      try {
        var response;
        String contentType;
        dynamic formattedBody;
        if (type == TypeHeader.json) {
          contentType = "application/json;charset=utf-8";
          formattedBody = json.encode(body);
        }
        else {
          contentType = "application/x-www-form-urlencoded";
          formattedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
        }
        Map<String, String> headers = {};
        headers[HttpHeaders.contentTypeHeader] = contentType;
        if (token != "") {
          headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
        }
        switch (method) {

          case "post":
            response = await post(
              uri,
              headers: headers,
              body: formattedBody,
              
            );
            break;
          case "get":
            response = await get(
              uri,
              headers: headers,
            );
            break;
        }
        return response.body;
      } catch (err) {
        print(err.toString());
        await Future.delayed(const Duration(seconds: 5), () => null);
      }
    }
    return "fail";
  }

  Future<String> makePostRequest(String serverAddress, String servicePath, {dynamic body,Map<String, String>? params, TypeHeader type = TypeHeader.json}) async {
    return _makeRequest(serverAddress, servicePath, "post", type, body: body,params: params);
  }

  Future<String> makeGetRequest(String serverAddress, String servicePath, {Map<String, String>? params, TypeHeader type = TypeHeader.json}) async {
    return _makeRequest(serverAddress, servicePath, "get", type, params: params);
  }


}