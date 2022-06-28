import 'package:ecommerce_view/Uti/Support.dart';
import 'package:ecommerce_view/widgets/CoolIcon.dart';
import 'package:flutter/material.dart';
import 'package:neon/neon.dart';
import '../Uti/Consts.dart';
import '../managers/Proxy.dart';
import '../managers/WebStorage.dart';
import 'CoolIconButton.dart';
import 'CoolText.dart';

class AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  const AppBarWidget({
    this.index,
    this.leadingFunction,
    Key? key,
  }) : super(key: key);
  final int? index;
  final Function()? leadingFunction;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(Consts.kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final bool isAdmin=Proxy.appState.existsValue(Consts.USER_LOGGED_IS_ADMIN)?Proxy.appState.getValue(Consts.USER_LOGGED_IS_ADMIN):false;

  @override
  Widget build(BuildContext context) {

    return AppBar(
      title:Neon(text: Consts.TITLE,
      color: Colors.yellow,
      fontSize: 35,
      font: NeonFont.Cyberpunk,
      flickeringText: true,
        flickeringLetters: null,
      )/*CoolText(text:Consts.TITLE,size:"b")*/,
      centerTitle: true,
      backgroundColor: Colors.black,
      elevation: 10,
      leading:widget.leadingFunction != null?
      CoolIconButton(
          icon: Icons.arrow_back_ios_outlined,
          press: widget.leadingFunction!,
          color: Colors.white,
          size: 20,
          colorShadow: widget.index == 0?Consts.secondary_color:null)
          :CoolIconButton(icon: Icons.home_rounded, press:() {
        Navigator.pushNamed(context, 'HomePage');
      }, color: Colors.white, size: 20, colorShadow: widget.index == 0?Consts.secondary_color:null),
      actions: isAdmin?adminWidgets(context):userWidgets(context),
    );
  }

  List<Widget> userWidgets(BuildContext context) {
    return <Widget>[
      CoolIconButton(
          icon: Icons.person,
          press: () {
            if (Proxy.appState.getValue(Consts.USER_LOGGED_DETAILS) != null) {

              Navigator.pushNamed(context, 'UserDetailsPage');
            } else {
              Proxy.sharedProxy.autoLogin(context, 1);
              /*Navigator.pushNamed(context, 'LoginPage');
              showCoolSnackbar(context, Consts.REQUIRED_LOGIN_EXCEPTION, "err");*/
            }
          },
          color: Colors.white,
          size: 20,
          colorShadow: widget.index == 1?Consts.secondary_color:null),
      CoolIconButton(
          icon: Icons.shopping_cart,
          press: () {
            if (Proxy.appState.getValue(Consts.USER_LOGGED_DETAILS) != null) {

              Navigator.pushNamed(context, 'UserCartPage');
            } else {
              Proxy.sharedProxy.autoLogin(context, 2);
              /*Navigator.pushNamed(context, 'LoginPage');
              showCoolSnackbar(context, Consts.REQUIRED_LOGIN_EXCEPTION, "err");*/
            }
          },
          color: Colors.white,
          size: 20,
          colorShadow: widget.index == 2?Consts.secondary_color:null),
      SizedBox(
        width: 10,
      )
    ];
  }

  List<Widget> adminWidgets(BuildContext context) {
    return <Widget>[
      CoolIconButton(
          icon: Icons.settings,
          press: () {
            Navigator.pushNamed(context, "AdminPage");
          },
          color: Colors.white,
          size: 20,
          colorShadow: widget.index == 1?Consts.secondary_color:null),
      SizedBox(
        width: 10,
      ),
      CoolIconButton(
          icon: Icons.account_balance_wallet,
          press: () {
            Navigator.pushNamed(context, "BalancePage");
          },
          color: Colors.white,
          size: 20,
          colorShadow: widget.index == 2?Consts.secondary_color:null),
      SizedBox(
        width: 10,
      )
    ];
  }


}
