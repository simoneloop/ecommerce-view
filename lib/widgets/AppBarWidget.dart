import 'package:ecommerce_view/Uti/Support.dart';
import 'package:ecommerce_view/widgets/CoolIcon.dart';
import 'package:flutter/material.dart';
import 'package:neon/neon.dart';
import '../Uti/Consts.dart';
import '../managers/Proxy.dart';
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
      title: /*Neon(text: "3DMade",
      color: Colors.yellow,
      fontSize: 35,
      font: NeonFont.Beon,
      flickeringText: true,
        flickeringLetters: null,
      )*/CoolText(text:Consts.TITLE,size:"b"),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 10,
      leading:widget.leadingFunction != null?IconButton(
        icon: Icon(Icons.arrow_back_ios_outlined),
        onPressed: widget.leadingFunction,
      ): /*CoolIconButton(icon: Icons.home_rounded, press:() {
        Navigator.pushNamed(context, 'HomePage');
      }, color: Colors.white, size: 20, colorShadow: widget.index == 0?Colors.deepPurple:null)*/IconButton(
        icon:Icon(Icons.home_rounded),
        onPressed:() {
                Navigator.pushNamed(context, 'HomePage');
              },
        color: widget.index == 0 ? Colors.amber : null,
      ),
      actions: isAdmin?adminWidgets(context):userWidgets(context),
    );
  }

  List<Widget> userWidgets(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          if (Proxy.appState.getValue(Consts.USER_LOGGED_DETAILS) != null) {
            Navigator.pushNamed(context, 'UserDetailsPage');
          } else {
            Navigator.pushNamed(context, 'LoginPage');
            showCoolSnackbar(context, Consts.REQUIRED_LOGIN_EXCEPTION, "err");
          }
        },
        icon: Icon(Icons.person),
        color: widget.index == 1 ? Colors.amber : null,
      ),
      IconButton(
        onPressed: () {
          if (Proxy.appState.getValue(Consts.USER_LOGGED_DETAILS) != null) {
            Navigator.pushNamed(context, 'UserCartPage');
          } else {
            Navigator.pushNamed(context, 'LoginPage');
            showCoolSnackbar(context, Consts.REQUIRED_LOGIN_EXCEPTION, "err");
          }
        },
        icon: Icon(Icons.shopping_cart),
        color: widget.index == 2 ? Colors.amber : null,
      ),
      SizedBox(
        width: 10,
      )
    ];
  }

  List<Widget> adminWidgets(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "AdminPage");
        },
        icon: Icon(Icons.settings),
        color: widget.index == 1 ? Colors.amber : null,
      ),
      SizedBox(
        width: 10,
      ),
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "BalancePage");
        },
        icon: Icon(Icons.account_balance_wallet),
        color: widget.index == 2 ? Colors.amber : null,
      ),
      SizedBox(
        width: 10,
      )
    ];
  }


}
