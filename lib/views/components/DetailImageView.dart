import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../commons/Constants.dart';
import '../../controllers/property_controller.dart';
import '../../models/Property.dart';
import '../pages/DetailsArticle.dart';

class DetailImageProperty extends StatefulWidget {
  PropertyController propertyController = Get.find<PropertyController>();
  bool _liked;
  Property property;
  int _currentIndex=0;
  int _currentId;

  DetailImageProperty(this._liked,  this._currentId, this.property);

  @override
  _DetailImagePropertyState createState() => _DetailImagePropertyState();
}

class _DetailImagePropertyState extends State<DetailImageProperty> {



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
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
          margin: EdgeInsets.all(3),
          width: 60,
          height: 20,
          decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.vertical(top: Radius.circular(4.0), bottom: Radius.circular(4.0)),
              shape: BoxShape.rectangle
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${currentindex+1}", style: TextStyle(fontSize: 12,
                  fontWeight: FontWeight.w300, color: whiteColor),),
              Text(" / ", style: TextStyle(fontSize: 10,
                  fontWeight: FontWeight.normal, color: whiteColor),),
              Text("${property.images.length}", style: TextStyle(fontSize: 12,
                  fontWeight: FontWeight.w300, color: whiteColor),),
            ],),
        ),
      ),
    );
  }

  buildActionBarWidget(BuildContext context) {

    return Container(
        margin: EdgeInsets.only(top: 55,bottom: 5, left: 5, right: 5),
        alignment: Alignment.topRight,
        child: Row(
          children: [
            GestureDetector(
              child:Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  //  borderRadius: BorderRadius.circular(25)
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                ),
              ),
              onTap: (){
                Get.back();

              },
            ),
            const Expanded(child: SizedBox()),
            Row(
              children: [
                GestureDetector(
                  child:Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      //  borderRadius: BorderRadius.circular(25)
                    ),
                    child: Icon(
                      Icons.file_upload_outlined,
                      size: 20,
                    ),
                  ),
                  onTap: (){
                      //TODO action après clique sur l'icon coeur

                  },
                ),
                SizedBox(width: 8,),
                GestureDetector(
                  child:Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      //  borderRadius: BorderRadius.circular(25)
                    ),
                    child: Icon(Icons.favorite_border, size: 20),
                  ),
                  onTap: (){
                    setState(() {
                     //TODO action après clique sur l'icon coeur
                    });

                  },
                )
              ],
            )
          ],
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
              height: 250,
              child: Stack(
                children: <Widget>[
                  buildImageSlider(context,PageController(),widget._currentIndex,widget.property),
                  buildWidgetImageIndicator(context,Constants.properties[1],widget._currentIndex),
                  buildActionBarWidget(context),
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
