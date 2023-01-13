import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:get/get.dart';

import '../../commons/Constants.dart';
import '../../models/Property.dart';
import '../components/ImageView.dart';


class Favoris extends GetView {

  var _pageController=PageController();
  var _currentIndex=0;

  var searchText = ''.obs;
  var currentTab = 0.obs;
  var _liked=false;

  Widget property =  ImageProperty(true,1, Constants.properties[1]);

  Favoris({Key? key, Property? localProperty}) : super(key: key) {
    if (localProperty != null) {
      property = ImageProperty(true,1, localProperty);
    }
  }
  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      //setState(() {
        _currentIndex=_pageController.page!.round();
     // });
    });


    return Scaffold(
      appBar: AppBar(
          title: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child:  IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 25,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                    ),
                  ),
                   const Expanded(child: SizedBox()),
                  Row(
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child:
                      IconButton(
                          icon: const Icon(
                            Icons.file_upload_outlined,
                            size: 25,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                    ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 2),
                        child:
                        IconButton(
                          icon: const Icon(
                            Icons.more_vert_outlined,
                            size: 25,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                  ],)
                ],
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          elevation: 0.00,
          toolbarHeight: 50,
          backgroundColor: Colors.white),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(15),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            property,
          ],
        ),
      ),
    );

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
