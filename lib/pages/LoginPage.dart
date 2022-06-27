import 'dart:html';
import 'dart:ui';

import 'package:ecommerce_view/Uti/Support.dart';
import 'package:ecommerce_view/widgets/AppBarWidget.dart';
import 'package:ecommerce_view/widgets/CoolText.dart';
import 'package:ecommerce_view/widgets/CoolTextButton.dart';
import 'package:ecommerce_view/widgets/ProgressHUD.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Uti/Consts.dart';
import '../managers/Proxy.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool hidePassword = true;
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  String? _passwordError=null;
  String? _emailError=null;
  bool _canLogin=true;
  bool isApiCallProcess=false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uiSetup(context), inAsyncCall: isApiCallProcess,opacity: 0.3,circularColor: Theme.of(context).colorScheme.secondary,);
  }

  @override
  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBarWidget(index: 1,),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                      ]),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        CoolText(text: "Login", size: "m",color: Colors.white,),
                        SizedBox(height: 25),
                        TextFormField(
                          style: getTextStyle(size: Consts.smallText),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) => !input!.contains("@")
                              ? "Should be a valid email"
                              : null,
                          decoration: InputDecoration(
                            hintStyle: getTextStyle(size: Consts.smallText),

                              hintText: "Email",
                              errorText: _emailError,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Theme.of(context).colorScheme.secondary,
                              )),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: getTextStyle(size: Consts.smallText),
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                              input == null ? "Please enter a password" : null,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                              hintStyle: getTextStyle(size: Consts.smallText),
                              hintText: "Password",

                              errorText: _passwordError,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.4),
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(

                          children: [
                            CoolTextButton(gradient: Consts.SecondoGradient, text: "Login", press:(){ValidateAndLogin();
                            setState(() {
                              isApiCallProcess=true;
                            });

                            }),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(

                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CoolText(text: "Prima volta?", size: "s",color: Colors.black,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: CoolTextButton(gradient: Consts.PrimoGradient, text: "Registrati", press: (){Navigator.pushNamed(context, "RegistrationPage");},width: 130,height: 40,),
                                  )

                                ],
                              ),
                            )
                          ],
                        ),


                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  Color parseColor(String color) {
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
      '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }
  void ValidateAndLogin(){
    print(parseColor("#FF7E75"));
    _canLogin=true;
    if(Consts.TO_VALIDATE){
      setState(() {
        if(!_emailController.text.contains("@")){
          _emailError="Should be a valid email";
          _canLogin=false;
        }
        else{
          _emailError=null;
        }
        if(!(_passwordController.text.length>3)){
          _passwordError="password should be more than 3 char";
          _canLogin=false;
        }else{_passwordError=null;}
      });
    }

    if(_canLogin){
      Proxy.sharedProxy.logIn(_emailController.text,_passwordController.text)
          .then((value){
            if(value==LogInResult.logged){
              print(Proxy.appState.getValue(Consts.USER_LOGGED_DETAILS));
              Navigator.pushNamed(
                  context, 'HomePage');
              showCoolSnackbar(context, "Benvenuto ${Proxy.appState.getValue(Consts.USER_LOGGED_DETAILS).firstName}", "ok");

            }
            else{
              showCoolSnackbar(context, "errore", "err");
              print(LogInResult.error);


            }
            setState(() {
              isApiCallProcess=false;
            });

          });
    }

  }
}
