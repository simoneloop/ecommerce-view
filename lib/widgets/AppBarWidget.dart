import 'package:flutter/material.dart';
import '../Uti/Consts.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const AppBarWidget({
    this.index,
    Key? key,
  }) : super(key: key);
  final int? index;

  @override
  Widget build(BuildContext context) {
    return AppBar(

      title: Text("ECOMMERCE",style:Theme.of(context).textTheme.headline3),
      centerTitle: true,

      backgroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 10,
      leading: IconButton(icon: Icon(Icons.home_rounded),
        onPressed: () { Navigator.pushNamed(
            context, 'HomePage'); },
        color: index==0?Colors.amber:null,
      ),
      actions: <Widget>[
        IconButton(onPressed: (){
          Navigator.pushNamed(
              context, 'LoginPage');
        },
          icon: Icon(Icons.person),
          color: index==1?Colors.amber:null,
        ),
        IconButton(onPressed: (){},
            icon: Icon(Icons.shopping_cart),
            color: index==2?Colors.amber:null,

        ),
        SizedBox(width: 10,)
      ],

    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(Consts.kToolbarHeight);
}