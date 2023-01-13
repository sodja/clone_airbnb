import 'dart:collection';
import 'dart:convert';

import 'package:airbnb_clone/database/entities/type_article.dart';
import 'package:airbnb_clone/models/Appartement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:get/get.dart';
import 'package:string_2_icon/string_2_icon.dart';

import '../../commons/Constants.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/property_controller.dart';
import '../../models/Hotel.dart';
import '../../models/Property.dart';
import '../components/ImageView.dart';
import 'maps.dart';


class Articles extends GetView<PropertyController> {

  @override
  PropertyController controller = Get.put(PropertyController());

  var _pageController=PageController();
  var _currentIndex=0;

  var searchText = ''.obs;
  var currentTab = 0.obs;
  var _liked=false;


  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      //setState(() {
        _currentIndex=_pageController.page!.round();
     // });
    });
    Future.delayed(const Duration(seconds: 2), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.getAllArticlesBySearch(searchText.value);
      });
    });
    return Scaffold(
      appBar: AppBar(
          title: Column(
            children: [
              Row(
                children: [
                  Obx(() => Expanded(
                      child: Container(
                        margin:
                        const EdgeInsets.only(right: 0, left: 8, top: 0),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.transparent,
                                  blurRadius: 4,
                                  offset: Offset(0, 3))
                            ]),
                        child: TextFormField(
                          initialValue: searchText.value,
                          onChanged: (value) =>
                          {searchText.value = value.toString(),controller.getAllArticlesBySearch(searchText.value.toLowerCase())},
                          autofocus: false,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            hintText: "Rechercher",
                            hintStyle: const TextStyle(fontSize: 12),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                left: 25, right: 10, top: 5, bottom: 5),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1.5, color: Colors.black),
                              borderRadius:
                              BorderRadius.circular(50.0), //<-- SEE HERE
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                      ))),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 05.0),
                height: 60.0,
                child: Obx(()=>ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    for(TypeArticle type in controller.typeArticles)
                      Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: SizedBox.fromSize(
                            size: Size(90, 70),
                            child: ClipRect(
                              child: Material(
                                color: Colors.white,
                                child: InkWell(
                                  splashColor: Constants.greenAirbnb,
                                  onTap: () {
                                    searchText.value = " ";
                                    controller.currentArticle.value = type.titre;
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        IconData(int.parse(type.iconUrl), fontFamily: 'MaterialIcons'),
                                        color: Colors.black,
                                      ), // <-- Icon
                                      Text(type.titre, style: TextStyle(fontSize: 11),), // <-- Text
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                  ],
                ),),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          elevation: 0.00,
          toolbarHeight: 150,
          backgroundColor: Colors.white),
      body: SafeArea(
        child: Obx(()=> controller.map.value?MapsView():(controller.currentArticle.value.isNotEmpty && controller.currentArticle.value != "All")? ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            for(ImageProperty property in controller.properties)
              if(property.property.titre == controller.currentArticle.value)
                property,
          ],
        ):Obx(() =>  ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            for(ImageProperty property in controller.properties)
              property,
          ],
        ))),
      ),
      floatingActionButton: Obx(()=>controller.map.value?SizedBox(child: IconButton(icon: Icon(Icons.close), color: Colors.black, onPressed: (){controller.map.value = false;},),):
      FloatingActionButton.extended(
        onPressed: () {
          controller.map.value = true;
        },
        label: const Text('Carte'),
        icon: const Icon(Icons.map_rounded),
        backgroundColor: Colors.black,
        elevation: 5,
      ),
    ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,);

  }
  Container buildImageSlider(BuildContext context,PageController p,int index,Property property) {
    return Container(
      // margin: EdgeInsets.all(20),
        child: PageView.builder(
            controller: p..addListener(() {
            //  setState(() {
                index=p.page!.round();
             // });
            }),
            itemCount: property.images.length,
            itemBuilder: (
                context,index){
              return ClipRRect(
                  child:Image.asset(property.images[index],fit: BoxFit.cover,));
            }
        )
    );
  }

  Align buildWidgetImageIndicator(BuildContext context,Property property, int currentindex) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: SliderIndicator(
            length: property.images.length,
            activeIndex: currentindex,
            indicator:Padding( padding:EdgeInsets.all(3),child:Icon(Icons.fiber_manual_record,color: Colors.white70,size: 10,)),
            activeIndicator: Padding(padding:EdgeInsets.all(3),child:Icon(Icons.fiber_manual_record,color: Colors.white,size: 14,),)
        ),
      ),
    );
  }

  buildHeartWidget(BuildContext context) {

    return Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.topRight,
        child:GestureDetector(
          child:Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              //  borderRadius: BorderRadius.circular(25)
            ),
            child: Icon(!_liked?Icons.favorite_border:Icons.favorite,color:!_liked? Colors.black:Constants.redAirbnb,size: 25,),
          ),
          onTap: (){
           // setState(() {
              _liked=!_liked;
          //  });
          },
        )
    );
  }

  _buildPadding(Property property) {
    return   Padding(
      padding: EdgeInsets.only(bottom: 5),
      child:   InkWell(
        onTap: (){
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PropertyDetails(property)),
          );*/
        },
        child:Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0,0,0,15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),

              ),
              height: 200,
              child: Stack(
                children: <Widget>[
              /*    buildImageSlider(context,PageController(),_currentIndex,property),
                  buildWidgetImageIndicator(context,Constants.properties[1],_currentIndex),
                  buildHeartWidget(context),*/
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB( 35,0,35, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child:  Text("ORAN",style: TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w400),),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:  Text("Maison entière",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:  Text("EL-BEY",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:  Text("4200 CFA/nuit",style: TextStyle(color: Colors.black54,fontSize: 13,fontWeight: FontWeight.w400),),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.star,color: Constants.greenAirbnb,size: 12,),
                          Align(
                            alignment: Alignment.topLeft,
                            child:  Text("5,0",style: TextStyle(color: Colors.black87,fontSize: 13,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
                          ) ,
                          Align(
                            alignment: Alignment.topLeft,
                            child:  Text("(25)",style: TextStyle(color: Colors.black54,fontSize: 13,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
                          ) ,
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Constants.greenAirbnb
                    ),
                    child: InkWell(
                      child: Text("Reserver",style: TextStyle(color: Colors.white),),
                      onTap: (){
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Payer()),
                        );*/
                      },
                    ),
                  )
                ],
              ),
            ),


          ],
        ), ),
    );
  }

}
