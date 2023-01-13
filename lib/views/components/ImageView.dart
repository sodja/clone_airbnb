import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../commons/Constants.dart';
import '../../controllers/property_controller.dart';
import '../../models/Property.dart';
import '../pages/DetailsArticle.dart';

class ImageProperty extends StatefulWidget {
  PropertyController propertyController = Get.find<PropertyController>();
  bool _liked;
  Property property;
  int _currentIndex=0;
  int _currentId;

  ImageProperty(this._liked,  this._currentId, this.property);

  @override
  _ImagePropertyState createState() => _ImagePropertyState();
}

class _ImagePropertyState extends State<ImageProperty> {



  Container buildImageSlider(BuildContext context,PageController p,int index,Property property) {
    return Container(
      // margin: EdgeInsets.all(20),
        child: PageView.builder(
            controller: p..addListener(() {
              setState(() {
                index=p.page!.round();
                widget._currentIndex=p.page!.round();
              });
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
            indicator:const Padding( padding:EdgeInsets.all(3),child:Icon(Icons.fiber_manual_record,color: Colors.white70,size: 10,)),
            activeIndicator: const Padding(padding:EdgeInsets.all(3),child:Icon(Icons.fiber_manual_record,color: Colors.white,size: 14,),)
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
              color: Colors.transparent,
              shape: BoxShape.circle,
              //  borderRadius: BorderRadius.circular(25)
            ),
            child: Icon(!widget._liked?Icons.favorite_border:Icons.favorite,color:!widget._liked? Colors.black:Constants.redAirbnb,size: 25,),
          ),
          onTap: (){
            setState(() {
              widget._liked=!widget._liked;
              if(widget._liked){
                print(widget._currentId);
                widget.propertyController.databaseService.updateArticleById(widget._currentId, true);
              }
            });

          },
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsets.only(bottom: 5),
      child:   InkWell(
        onTap: (){
          Get.to(() => DetailsArticle(localProperty: widget.property,));
        },
        child:Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0,0,0,15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),

              ),
              height: 200,
              child: Stack(
                children: <Widget>[
                  buildImageSlider(context,PageController(),widget._currentIndex,widget.property),
                  buildWidgetImageIndicator(context,Constants.properties[1],widget._currentIndex),
                  buildHeartWidget(context),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB( 0,0,35, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child:  Text(widget.property.titre,style: TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w400),),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child:  Text(widget.property.address.wilaya,style: TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w200)),
                        ),
                        if(!widget._liked)
                          const Align(
                            alignment: Alignment.topLeft,
                            child:  Text("1-6févr", style: TextStyle(color: Colors.black87,fontSize: 12)),
                          ),
                        Align(
                          alignment: Alignment.topLeft,
                          child:  Text("${widget.property.prix} F CFA par nuit",style: TextStyle(color: Colors.black54,fontSize: 13,fontWeight: FontWeight.w400),),
                        )
                      ],
                    ),
                  )
                 ,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child:  Row(
                        children: <Widget>[
                          Icon(Icons.star,color: Constants.blackAirbnb,size: 15,),
                          Align(
                            alignment: Alignment.topLeft,
                            child:  Text(" ${widget.property.raiting}",style: TextStyle(color: Colors.black87,fontSize: 13,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
                          ) ,
                        ],
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
