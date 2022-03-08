import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weatherproject/model/weather_model.dart';
import 'package:weatherproject/network/api_helper.dart';
import 'package:weatherproject/util/bottom_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<weather_model> weatherObject;
  String _cityName = "Feni";
  double _temperature = 20;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // weatherObject = Network().getWeatherApi(cityName: _cityName,_temperature:_temperature);
    weatherObject =
        Network().getWeatherApi(cityName: _cityName, temperature: _temperature);
    // weatherObject.then((weather) => {
    //   print(weather.list?[0].deg)
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 209, 233, 210),
      appBar: AppBar(
        title: const Text("Weather"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SearchTextField(),
              FutureBuilder<weather_model>(
                  future: weatherObject,
                  builder: (BuildContext context,
                      AsyncSnapshot<weather_model> snapshot) {
                    var forecastList = snapshot.data?.list;
                    if (snapshot.hasData) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Population:${snapshot.data?.city?.population}",
                              style: TextStyle(fontSize: 10, color: Colors.red),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Icon(
                            //   FontAwesomeIcons.cloud,size: 150,color: Colors.pink,
                            // ),
                            Image.asset("asset/sunsky.jpg"),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${forecastList?[0].temp?.day?.toStringAsFixed(0)}°C",
                                    style: const TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  
                                  
                                ],
                              ),
                            ),
                            Text(
                              "${snapshot.data?.city?.name}.${snapshot.data?.city?.country}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            Text(
                                      "${forecastList?[0].weather?[0].description?.toUpperCase()}"),
                            
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Card(
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            "${forecastList?[0].speed?.toStringAsFixed(1)},ml/h"),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        const Icon(
                                          FontAwesomeIcons.wind,
                                          size: 20,
                                          color: Colors.brown,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text("Speed")
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            "${forecastList?[0].humidity?.toStringAsFixed(0)} %"),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        const Icon(
                                          FontAwesomeIcons.solidGrinBeamSweat,
                                          size: 20,
                                          color: Colors.brown,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text("Humidity")
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            "${forecastList?[0].temp?.day?.toStringAsFixed(0)} °C"),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        const Icon(
                                          FontAwesomeIcons.temperatureHigh,
                                          size: 20,
                                          color: Colors.brown,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text("Temp")
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                             bottomview(snapshot, (context))
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        child: const CircularProgressIndicator(),
                      );
                    }
                  })
            ],
          )
        ],
      ),
    );
  }

  Widget SearchTextField() {
    return Container(
      color: Colors.white,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Plase Enter Your City",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          prefixIcon: const Icon(Icons.search),
        ),
        onSubmitted: (value) {
          setState(() {
            _cityName = value;
            weatherObject = Network()
                .getWeatherApi(cityName: _cityName, temperature: _temperature);
          });
        },
      ),
    );
  }
}
