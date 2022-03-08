import 'package:flutter/material.dart';
import 'package:weatherproject/model/weather_model.dart';


Widget foreCastCard(AsyncSnapshot<weather_model>snapshot,int index){
  
  var forecastList=snapshot.data?.list;
  var dayOfWeek="";
  return Container(
    child: Column(
      children: <Widget>[
        SizedBox(height: 10,),
        Text("Date ${forecastList?[0].dt}"),
        SizedBox(height: 05,),
            Text("sunset ${forecastList?[0].sunrise}"),
            SizedBox(height: 05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text("min ${forecastList?[0].temp?.min?.toStringAsFixed(0)}°C"),
              SizedBox(width: 15,),
              Text("max ${forecastList?[0].temp?.max?.toStringAsFixed(0)}°C"),
              ],
            ),
            
      ],
    ),
  );

}