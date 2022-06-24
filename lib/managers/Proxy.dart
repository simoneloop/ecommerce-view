


import 'dart:async';
import 'dart:convert';

import 'package:ecommerce_view/Uti/Consts.dart';
import 'package:ecommerce_view/entities/AuthenticationData.dart';
import 'package:ecommerce_view/entities/ProductInPurchase.dart';
import 'package:ecommerce_view/entities/Purchase.dart';
import 'package:ecommerce_view/managers/RestManager.dart';
import 'package:ecommerce_view/managers/StateManager.dart';

import '../entities/Product.dart';
import '../entities/User.dart';
import 'StateManager.dart';
import 'StateManager.dart';

enum LogInResult {
  logged,
  error
}

enum RegistrationResult {
  registered,
  emailAlreadyExist,
  unknown
}

enum ModifyResult{
  modified,
  error
}
enum getProductResult{
  exist,
  notExist
}
enum addToCartResult{
  added,
  quantityUnavailable,
  setted,
  unknown
}
enum HttpResult{
  done,
  unknow,
  notAmountException,
  quantityUnavailable
}


class Proxy{
  static Proxy sharedProxy=Proxy();
  static StateManager appState = StateManager();
  RestManager _restManager=RestManager();
  late AuthenticationData _authenticationData;
  bool isLastPage=false;

  Future<LogInResult> logIn(String email,String password)async{
    try{
      Map<String,String> body={};
      body["email"]=email;
      body["password"]=password;
      String result=await _restManager.makePostRequest(Consts.ADDRESS_SERVER, Consts.REQUEST_LOGIN,body: body,type: TypeHeader.urlencoded);
      _authenticationData=AuthenticationData.fromJson(jsonDecode(result));
      _restManager.token = _authenticationData.accessToken;
      Timer.periodic(Duration(milliseconds: _authenticationData.expiresIn-50000), (timer) {

        _restManager.token=_authenticationData.refreshToken;
        _refreshToken();
        }
      );

      appState.addValue(Consts.USER_LOGGED_DETAILS, await getMyDetails());

      return LogInResult.logged;

    }catch(err){
      print(err);
      print(LogInResult.error);
      return LogInResult.error;
    }

  }
  Future<bool> _refreshToken() async {

    try {
      String result = await _restManager.makeGetRequest(
          Consts.ADDRESS_SERVER, Consts.REQUEST_REFRESH_TOKEN);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      _restManager.token = _authenticationData.accessToken;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  Future<RegistrationResult> addUser(User user) async {

    String rawResult = await _restManager.makePostRequest(
        Consts.ADDRESS_SERVER, Consts.REQUEST_ADD_USER,
        body: user.toJson());
    if(rawResult.contains(Consts.RESPONSE_ERROR_USER_ALREADY_EXIST)){
      print(Consts.RESPONSE_ERROR_USER_ALREADY_EXIST);
      return RegistrationResult.emailAlreadyExist;
    }
    /*appState.addValue(Consts.USER_LOGGED_DETAILS, User.fromJson(jsonDecode(rawResult)));*/
    return RegistrationResult.registered;

  }
  Future<User> getMyDetails() async {
    try {
      String rawResult = await _restManager.makeGetRequest(
          Consts.ADDRESS_SERVER, Consts.REQUEST_GET_MY_DETAILS,);

      print("roaw"+rawResult);
      return User.fromJson(jsonDecode(rawResult));
    }
    catch(err){
      print(err);
      return User.def();
    }
  }

  Future<List<Product>>getHotProduct()async{
    try{
      Map<String,String> params={};
      params["isHot"]="true";
      String rawResult=await _restManager.makeGetRequest(Consts.ADDRESS_SERVER, Consts.REQUEST_GET_HOT_PRODUCTS,params: params);
      List products = jsonDecode(rawResult);
      print(products);
      return products.map((e) => new Product.fromJson(e)).toList();

    }catch(err){
      print(err);
      return List.empty();
    }
  }
  Future<List<Product>> getProductPageable({String order="ascending",int page=0,int pageSize=20,String?typo})async{
    try{
      Map<String,String> params={};
      params['ordered']=order;
      params['pageSize']=pageSize.toString();
      params['page']=page.toString();
      print(params);
      if(typo!=null){
        params['typo']=typo;
      }
      String rawResult=await _restManager.makeGetRequest(Consts.ADDRESS_SERVER, Consts.REQUEST_GET_PRODUCT_PAGEABLE,params: params);
      print("raw: "+rawResult);//TODO refactor with pageable index

      Map<String, dynamic> res = jsonDecode(rawResult) as Map<String,dynamic>;

      List<dynamic> content=res['content'];
      //TODO is lastPage?
      List<Product> products=[];
      content.forEach((element) { products.add(new Product.fromJson(element));});
      return products;
    }catch(err){
      print("errore"+err.toString());
      return [];
    }
  }
  Future<List<Purchase>> getMyOrders()async{
    try{
      String rawResult=await _restManager.makeGetRequest(Consts.ADDRESS_SERVER, Consts.REQUEST_GET_MY_ORDERS);
      List purchases = jsonDecode(rawResult);
      List<Purchase> res=purchases.map((e) => new Purchase.fromJson(e)).toList();
      return res;
    }catch(err){
      print(err);
      return [];}
  }

  Future<List<ProductInPurchase>> removeFromMyCart(String productName)async{
    try{
      Map<String,String> params= {};
      params["productName"]=productName;
      String rawResult=await _restManager.makePostRequest(Consts.ADDRESS_SERVER, Consts.REQUEST_REMOVE_FROM_CART,params: params);
      List cart=jsonDecode(rawResult);
      return cart.map((e) => ProductInPurchase.fromJson(e)).toList();
    }
    catch(err){
      print(err);
      return [];
    }
  }
  Future<HttpResult> buyMyCart()async{
    try{
      String rawResult=await _restManager.makePostRequest(Consts.ADDRESS_SERVER, Consts.REQUEST_BUY_MY_CART);
      if(rawResult.contains(Consts.RESPONSE_ERROR_INSUFFICIENT_AMOUNT_EXCEPTION)){return HttpResult.notAmountException;}
      else if(rawResult.contains(Consts.RESPONSE_ERROR_QUANTITY_PRODUCT_UNAVAILABLE)){return HttpResult.quantityUnavailable;}
      else{return HttpResult.done;}
    }
    catch(err){
      print(err);
      return HttpResult.unknow;
    }
  }
  Future<List<ProductInPurchase>> getUserCart()async{
    try{
      String rawResult=await _restManager.makeGetRequest(Consts.ADDRESS_SERVER, Consts.REQUEST_GET_USER_CART);
      List pip=jsonDecode(rawResult);
      return pip.map((e) => ProductInPurchase.fromJson(e)).toList();

    }catch(err){
      print(err);
      return [];
    }
  }
  Future<addToCartResult>addToCart(String productName,int qty)async{
    try{
      Map<String,String> params={};
      params['productName']=productName;
      params['quantity']=qty.toString();
      String rawResult=await _restManager.makePostRequest(Consts.ADDRESS_SERVER, Consts.REQUEST_ADD_PRODUCT_TO_CART,params: params);
      if(rawResult.contains(Consts.RESPONSE_ERROR_QUANTITY_PRODUCT_UNAVAILABLE)){
        return addToCartResult.quantityUnavailable;
      }
      List pip=jsonDecode(rawResult);
      return addToCartResult.added;
    }catch(err){
      print(err);
      return addToCartResult.unknown;
    }
  }
  Future<addToCartResult>setQuantity(String productName,int qty)async{
    try{
      Map<String,String> params={};
      params['productName']=productName;
      params['quantity']=qty.toString();
      String rawResult=await _restManager.makePostRequest(Consts.ADDRESS_SERVER, Consts.REQUEST_SET_QUANTITY_TO_CART,params: params);
      if(rawResult.contains(Consts.RESPONSE_ERROR_QUANTITY_PRODUCT_UNAVAILABLE)){
        return addToCartResult.quantityUnavailable;
      }
      List pip=jsonDecode(rawResult);
      return addToCartResult.setted;
    }catch(err){
      print(err);
      return addToCartResult.unknown;
    }
  }
  Future<List<Product>>getAllProducts()async{
    try{
      String rawResult=await _restManager.makeGetRequest(Consts.ADDRESS_SERVER, Consts.REQUEST_GET_ALL_PRODUCTS);
      List products=jsonDecode(rawResult);

      return products.map((e) => Product.fromJson(e)).toList();
    }
    catch(err){
      print(err);
      return [];
    }
  }
  Future<Product?> addProduct(Product product)async{
    try{
      String rawResult=await _restManager.makePostRequest(Consts.ADDRESS_SERVER, Consts.REQUEST_ADD_PRODUCT,body: product);
      return Product.fromJson(jsonDecode(rawResult));
    }catch(err){print(err);return null;}
  }
  Future<Product?> modifyProduct(Product product,String oldName)async{
    try{
      Map<String,String>params={};
      params['oldName']=oldName;
      String rawResult=await _restManager.makePostRequest(Consts.ADDRESS_SERVER, Consts.REQUEST_MODIFY_PRODUCT,body: product,params: params);
      return Product.fromJson(jsonDecode(rawResult));
    }catch(err){print(err);return null;}
  }

  Future<ModifyResult> modifyMyDetails(User u)async{
    try{
      String rawResult=await _restManager.makePostRequest(Consts.ADDRESS_SERVER, Consts.REQUEST_MODIFY_MY_DETAILS,body: u);
      appState.updateValue(Consts.USER_LOGGED_DETAILS, User.fromJson(jsonDecode(rawResult)));
      return ModifyResult.modified;
    }catch(err){print(err);return ModifyResult.error;}
  }




  Future<dynamic> getProductByName(String name)async{
    try{
      Map<String,String>params={};
      params['name']=name;
      String rawResult=await _restManager.makeGetRequest(Consts.ADDRESS_SERVER, Consts.REQUEST_GET_PRODUCT,params: params);
      if(rawResult.contains(Consts.RESPONSE_ERROR_PRODUCT_DOES_NOT_EXIST)){
        return getProductResult.notExist;
      }
      else{return Product.fromJson(jsonDecode(rawResult));}

    }catch(err){
      print(err);
      return null;}
  }


}