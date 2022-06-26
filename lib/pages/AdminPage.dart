import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_view/Uti/Consts.dart';
import 'package:ecommerce_view/Uti/Support.dart';
import 'package:ecommerce_view/widgets/AppBarWidget.dart';
import 'package:ecommerce_view/widgets/CoolText.dart';
import 'package:ecommerce_view/widgets/CoolTextButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../entities/Product.dart';
import '../managers/Proxy.dart';
class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  late Future<List<Product>> productList;
  Map<String,bool>mapSelectedHotProduct={};
  Map<String,bool>mapSelectedProduct={};

  TextEditingController _nameController=TextEditingController();
  TextEditingController _descriptionController=TextEditingController();
  TextEditingController _priceController=TextEditingController();
  TextEditingController _quantityController=TextEditingController();




  String? _priceError=null;
  String? _descriptionError=null;
  String? _nameError=null;
  File? image=null;
  Uint8List webImage=Uint8List(8);
  String _radioValue = "";


  TextEditingController _nameModifingController=TextEditingController();
  TextEditingController _descriptionModifingController=TextEditingController();
  TextEditingController _priceModifingController=TextEditingController();
  TextEditingController _quantityModifingController=TextEditingController();

  String _modifingRadioValue="";
  bool _canModify=false;
  bool _isModifing=false;

  File? modifingImage=null;
  Uint8List modifingWebImage=Uint8List(8);


  @override
  void initState() {
    productList=Proxy.sharedProxy.getAllProducts();
    productList.then((value) {
      setState(() {
        value.forEach((element) {
          mapSelectedHotProduct['${element.name}']=element.hot;
          mapSelectedProduct['${element.name}']=false;
        });
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(index: 1,),
      backgroundColor: Theme.of(context).colorScheme.secondary,

      body:Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    /*width: double.infinity,*/
                    /*margin: EdgeInsets.only(top: 10,bottom: 10),*/
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).hintColor.withOpacity(0.2),
                              offset: Offset(0,10),
                              blurRadius: 2
                          )
                        ]
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        CoolText(text: "Modifica vetrina", size: "m"),
                        SizedBox(height: 15,),

                        SingleChildScrollView(
                          child: Container(
                            constraints:BoxConstraints(/*minWidth:size.width/3,*/minHeight: size.height/4,/*maxWidth: size.width/3,*/maxHeight: size.height/1.5),
                            child: FutureBuilder(
                              future: productList,
                                builder: (BuildContext ctx,AsyncSnapshot<List> snapshot){
                                  if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                                    return ScrollConfiguration(behavior: ScrollConfiguration.of(context).copyWith(
                                        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context,i){

                                            return Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                  border: Border(bottom: BorderSide(width: 1.0,color:i<snapshot.data!.length-1? Colors.blueGrey.withOpacity(0.5):Colors.transparent))
                                              ),
                                                child: CheckboxListTile(
                                                  title: CoolText(text:snapshot.data![i].name, size: 's',),
                                                    value: mapSelectedHotProduct[snapshot.data![i].name],
                                                    onChanged: (bool? value){
                                                    setState(() {
                                                      mapSelectedHotProduct[snapshot.data![i].name]=value!;
                                                    });
                                                    }),
                                              ),
                                            );
                                            return Text(snapshot.data![i].purchaseTime.toString());
                                          }),);
                                  }
                                  else{
                                    return CircularProgressIndicator();
                                  }
                                }),
                          ),
                        ),
                        CoolTextButton(gradient: Consts.kBlueGradient,
                            text: "SALVA",
                            press: (){
                          Proxy.sharedProxy.modifyHots(mapSelectedHotProduct).then((value) {
                            if(value==HttpResult.done){
                              showCoolSnackbar(context, "Vetrina modificata con successo", "ok");
                            }
                            else{
                              showCoolSnackbar(context, "Errore sconoscito", "err");
                            }
                          });
                        })
                      ],
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).hintColor.withOpacity(0.2),
                              offset: Offset(0,10),
                              blurRadius: 2
                          )
                        ]
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        CoolText(text: "Aggiungi prodotto", size: "m"),
                        SizedBox(height: 15,),




                        TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,

                          decoration: InputDecoration(
                              hintStyle: Consts.smallTextStyle,

                              hintText: "Nome del prodotto",
                              errorText: _nameError,
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
                                Icons.drive_file_rename_outline,
                                color: Theme.of(context).colorScheme.secondary,
                              )),

                        ),
                        SizedBox(height: 10),



                        TextFormField(
                          controller: _descriptionController,
                          keyboardType: TextInputType.name,

                          decoration: InputDecoration(
                              hintStyle: Consts.smallTextStyle,

                              hintText: "Descrizione del prodotto",
                              errorText: _descriptionError,
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
                                Icons.description_outlined,
                                color: Theme.of(context).colorScheme.secondary,
                              )),

                        ),
                        SizedBox(height: 10),


                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: _priceController,
                                keyboardType: TextInputType.phone,

                                decoration: InputDecoration(
                                    hintStyle: Consts.smallTextStyle,

                                    hintText: "Prezzo",
                                    errorText: _priceError,
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
                                      Icons.price_change_outlined,
                                      color: Theme.of(context).colorScheme.secondary,
                                    )),

                              ),
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: _quantityController,
                                keyboardType: TextInputType.number,

                                decoration: InputDecoration(
                                    hintStyle: Consts.smallTextStyle,

                                    hintText: "Quantità",
                                    errorText: _priceError,
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
                                      Icons.production_quantity_limits_outlined,
                                      color: Theme.of(context).colorScheme.secondary,
                                    )),

                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        CoolText(text: "Categoria", size: "s"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Radio(
                                    value: "bracciale",
                                    groupValue: _radioValue,
                                    onChanged: (value){
                                      setState(() {
                                        _radioValue=value.toString();
                                      });
                                    },
                                  ),
                                  CoolText(text: "Bracciale", size: "xs")
                                ],
                              ),
                              Column(
                                children: [
                                  Radio(
                                    value: "collana",
                                    groupValue: _radioValue,
                                    onChanged: (value){
                                      setState(() {
                                        _radioValue=value.toString();
                                      });
                                    },
                                  ),
                                  CoolText(text: "Collana", size: "xs")
                                ],
                              ),
                              Column(
                                children: [
                                  Radio(
                                    value: "orecchino",
                                    groupValue: _radioValue,
                                    onChanged: (value){
                                      setState(() {
                                        _radioValue=value.toString();
                                      });
                                    },
                                  ),
                                  CoolText(text: "Orecchino", size: "xs")
                                ],
                              )
                            ],
                          ),
                        ),

                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: (){pickImage();},
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child:DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(16),

                                child: Container(
                                  width: 200,
                                  height: 200,
                                  child: image==null?Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image_outlined),
                                      CoolText(text: "Carica una foto del prodotto", size: "xs"),
                                    ],
                                  ):kIsWeb?Image.memory(webImage,fit: BoxFit.fill,):Image.file(image!,fit: BoxFit.fill,),
                                ),)
                          ),
                        ),

                        /*ElevatedButton(onPressed: (){pickImage();},
                            child:Row(

                              children: [
                                Icon(Icons.image),
                                Expanded(child: CoolText(text: "Carica foto prodotto", size: "s",textAlign: TextAlign.center,color: Colors.white,))
                              ],
                            )),*/
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: CoolTextButton(gradient: Consts.kBlueGradient, text: "AGGIUNGI", press: (){addProduct(); })),
                            ))

                      ],
                    ),



                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Stack(
                children: [
                  Container(

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).hintColor.withOpacity(0.2),
                              offset: Offset(0,10),
                              blurRadius: 2
                          )
                        ]
                    ),
                    child:!_isModifing? Column(
                      children: [
                        SizedBox(height: 10,),
                        CoolText(text: "Magazzino", size: "m"),
                        SizedBox(height: 15,),

                        SingleChildScrollView(
                          child: Container(
                            constraints:BoxConstraints(/*minWidth:size.width/3,*/minHeight: size.height/4,/*maxWidth: size.width/3,*/maxHeight: size.height/1.5),
                            child: FutureBuilder(
                                future: productList,
                                builder: (BuildContext ctx,AsyncSnapshot<List> snapshot){
                                  if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                                    return ScrollConfiguration(behavior: ScrollConfiguration.of(context).copyWith(
                                        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context,i){
                                            return Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border(bottom: BorderSide(width: 1.0,color:i<snapshot.data!.length-1? Colors.blueGrey.withOpacity(0.5):Colors.transparent))
                                                ),
                                                child: CheckboxListTile(
                                                    title: CoolText(text:snapshot.data![i].name, size: 's',),
                                                    value: mapSelectedProduct[snapshot.data![i].name],
                                                    onChanged: (bool? value){
                                                      setState(() {
                                                        mapSelectedProduct[snapshot.data![i].name]=value!;
                                                        updateCanModify();
                                                      });
                                                    }),
                                              ),
                                            );
                                            return Text(snapshot.data![i].purchaseTime.toString());
                                          }),);
                                  }
                                  else{
                                    return CircularProgressIndicator();
                                  }
                                }),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Row(
                            children: [
                              CoolTextButton(gradient:_canModify? Consts.kBlueGradient:Consts.kGreyGradient, text: "MODIFICA", press: (){
                                if(_canModify){
                                  setState(() {
                                    _isModifing=true;
                                  });
                                }
                                else{
                                  showCoolSnackbar(context, "Seleziona uno e un solo prodotto", "err");
                                }
                              }),
                              CoolTextButton(gradient: Consts.kOrangeGradient, text: "RIMUOVI", press: (){deleteProducts();})
                            ],
                          ),
                        )

                      ],
                    )://TODO da qui
                    Column(

                      children: [
                        SizedBox(height: 10,),
                        Row(

                          children: [
                            Flexible(
                              flex: 1,
                              child: IconButton(icon:Icon(Icons.arrow_back_ios_outlined),color: Colors.deepPurpleAccent, onPressed: () {
                                setState(() {
                                  _isModifing=false;
                                });
                              },),
                            ),
                            Flexible(
                                flex: 4,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: CoolText(text: "Modifica prodotto", size: "m",textAlign: TextAlign.center,))),
                          ],
                        ),
                        SizedBox(height: 15,),




                        TextFormField(
                          controller: _nameModifingController,
                          keyboardType: TextInputType.name,

                          decoration: InputDecoration(
                              hintStyle: Consts.smallTextStyle,

                              hintText: "Nome del prodotto",
                              errorText: _nameError,
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
                                Icons.drive_file_rename_outline,
                                color: Theme.of(context).colorScheme.secondary,
                              )),

                        ),
                        SizedBox(height: 10),



                        TextFormField(
                          controller: _descriptionModifingController,
                          keyboardType: TextInputType.name,

                          decoration: InputDecoration(
                              hintStyle: Consts.smallTextStyle,

                              hintText: "Descrizione del prodotto",
                              errorText: _descriptionError,
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
                                Icons.description_outlined,
                                color: Theme.of(context).colorScheme.secondary,
                              )),

                        ),
                        SizedBox(height: 10),


                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: _priceModifingController,
                                keyboardType: TextInputType.phone,

                                decoration: InputDecoration(
                                    hintStyle: Consts.smallTextStyle,

                                    hintText: "Prezzo",
                                    errorText: _priceError,
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
                                      Icons.price_change_outlined,
                                      color: Theme.of(context).colorScheme.secondary,
                                    )),

                              ),
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: _quantityModifingController,
                                keyboardType: TextInputType.number,

                                decoration: InputDecoration(
                                    hintStyle: Consts.smallTextStyle,

                                    hintText: "Quantità",
                                    errorText: _priceError,
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
                                      Icons.production_quantity_limits_outlined,
                                      color: Theme.of(context).colorScheme.secondary,
                                    )),

                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        CoolText(text: "Categoria", size: "s"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Radio(
                                    value: "bracciale",
                                    groupValue: _modifingRadioValue,
                                    onChanged: (value){
                                      setState(() {
                                        _modifingRadioValue=value.toString();
                                      });
                                    },
                                  ),
                                  CoolText(text: "Bracciale", size: "xs")
                                ],
                              ),
                              Column(
                                children: [
                                  Radio(
                                    value: "collana",
                                    groupValue: _modifingRadioValue,
                                    onChanged: (value){
                                      setState(() {
                                        _modifingRadioValue=value.toString();
                                      });
                                    },
                                  ),
                                  CoolText(text: "Collana", size: "xs")
                                ],
                              ),
                              Column(
                                children: [
                                  Radio(
                                    value: "orecchino",
                                    groupValue: _modifingRadioValue,
                                    onChanged: (value){
                                      setState(() {
                                        _modifingRadioValue=value.toString();
                                      });
                                    },
                                  ),
                                  CoolText(text: "Orecchino", size: "xs")
                                ],
                              )
                            ],
                          ),
                        ),

                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: (){pickImage();},
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child:DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(16),

                                child: Container(
                                  width: 200,
                                  height: 200,
                                  child: modifingImage==null?Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image_outlined),
                                      CoolText(text: "Carica una foto del prodotto", size: "xs"),
                                    ],
                                  ):kIsWeb?Image.memory(modifingWebImage,fit: BoxFit.fill,):Image.file(modifingImage!,fit: BoxFit.fill,),
                                ),)
                          ),
                        ),

                        /*ElevatedButton(onPressed: (){pickImage();},
                            child:Row(

                              children: [
                                Icon(Icons.image),
                                Expanded(child: CoolText(text: "Carica foto prodotto", size: "s",textAlign: TextAlign.center,color: Colors.white,))
                              ],
                            )),*/
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: CoolTextButton(gradient: Consts.kBlueGradient, text: "SALVA MODIFICHE", press: (){print("modify"); })),
                            ))

                      ],
                    ),

                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
Future pickImage() async{
    if(!kIsWeb){
      final ImagePicker _picker=ImagePicker();
      XFile? image=await _picker.pickImage(source: ImageSource.gallery);
      if(image!=null){
        final imageTmp=File(image.path);
        setState(() {
          this.image=imageTmp;
        });

      }
      else{return;}
    }
    else if(kIsWeb){
      final ImagePicker _picker=ImagePicker();
      XFile? image=await _picker.pickImage(source: ImageSource.gallery);
      if(image!=null){
        var f=await image.readAsBytes();
        setState(() {
          webImage=f;
          this.image=File('a');
        });
      }
      else{
        return;
      }
    }

  }

  void addProduct(){
    bool _canAdd=true;
    if(_nameController.text.isEmpty){
      _canAdd=false;
    }
    if(_quantityController.text.isEmpty){
      _canAdd=false;
    }
    if(_descriptionController.text.isEmpty){
      _canAdd=false;
    }
    if(_priceController.text.isEmpty){
      _canAdd=false;
    }
    if(_radioValue==""){
      _canAdd=false;
    }
    if(image==null){
      _canAdd=false;
    }
    if(!_canAdd){
      showCoolSnackbar(context, "Compila tutti i campi del prodotto per poter aggiungerlo", "err");
    }
    else{
      Proxy.sharedProxy.getProductByName(_nameController.text).then((value) {
        if(value!=getProductResult.notExist){
          _canAdd=false;
          showCoolSnackbar(context, "Esiste già un prodotto con questo nome!", "err");
        }
        else{
          Proxy.sharedProxy.addProPic(webImage, _nameController.text).then((value) {
            Proxy.sharedProxy.addProduct(new Product(name: _nameController.text, description: _descriptionController.text, quantity: int.parse(_quantityController.text), price: double.parse((_priceController.text)), typo: _radioValue, hot: false,urlPropic: value)).then((value) {
              if(value==HttpResult.done){
                showCoolSnackbar(context,"Prodotto aggiunto con successo","ok");
                setState(() {

                });
              }
            });
          });
        }
      });

    }

  }
  void deleteProducts(){
    List<String> selected=[];
    mapSelectedProduct.forEach((key, value) {
      if(value==true){
        selected.add(key);
      }
    });
    String text=selected.length>1?"Cancellati":"Cancellato";
    if(selected.length==0){
      showCoolSnackbar(context,"Seleziona almeno un prodotto","err");
      return;
    }
    Proxy.sharedProxy.deleteProducts(selected).then((value) {
      if(value==HttpResult.done){
        showCoolSnackbar(context, text+" con successo", "ok");
      }
      else{
        showCoolSnackbar(context, "Errore sconosciuto", "err");
      }
    });
    print(selected);
  }

  void updateCanModify(){
    List<String> selected=[];
    mapSelectedProduct.forEach((key, value) {
      if(value==true){
        selected.add(key);
      }
    });
    _canModify=selected.length==1?true:false;
  }

}
