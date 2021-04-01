import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:convert';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int temperature;
  var minTemperatureForecast = List(7);
  var maxTemperatureForecast = List(7);
  var abbreviationForecast = List(7);
  String location = 'Jabalpur';
  String weather = 'clear';
  String searchApiUrl =
      'https://www.metaweather.com/api/location/search/?query=';
  int woeid = 2295386;
  String locationApiUrl = 'https://www.metaweather.com/api/location/';
  String abbreviation = '';
  String errorMessage = '';

  void initState() {
    super.initState();
    fetchLocation();
    fetchLocationDay();
  }

// Void function to search the location.
  void fetchSearch(String input) async {
    try {
      var searchResult = await http.get(searchApiUrl + input);
      var result = json.decode(searchResult.body)[0];

      setState(() {
        location = result["title"];
        woeid = result["woeid"];
        errorMessage = '';
      });
    } catch (error) {
      setState(() {
        errorMessage =
            "Sorry, we don't have data about this city. This app is still in early phase.";
      });
    }
  }

// Void function to get the current info of the searched location.
  void fetchLocation() async {
    var locationResult = await http.get(locationApiUrl + woeid.toString());
    var result = json.decode(locationResult.body);
    var consolidatedWeather = result["consolidated_weather"];
    var data = consolidatedWeather[0];

    setState(() {
      temperature = data["the_temp"].round();
      weather = data["weather_state_name"].replaceAll(' ', '').toLowerCase();
      abbreviation = data["weather_state_abbr"];
    });
  }

  void fetchLocationDay() async {
    var today = new DateTime.now();
    for (var i = 0; i < 7; i++) {
      var locationDayResult = await http.get(locationApiUrl +
          woeid.toString() +
          '/' +
          new DateFormat('y/M/d')
              .format(today.add(new Duration(days: i + 1)))
              .toString());
      var result = json.decode(locationDayResult.body);
      var data = result[0];

      setState(() {
        minTemperatureForecast[i] = data["min_temp"].round();
        maxTemperatureForecast[i] = data["max_temp"].round();
        abbreviationForecast[i] = data["weather_state_abbr"];
      });
    }
  }

  void onTextFieldSubmitted(String input) async {
    await fetchSearch(input);
    await fetchLocation();
    await fetchLocationDay();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/$weather.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop))),
          child: temperature == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  backgroundColor: Colors.transparent,
                  // resizeToAvoidBottomInset: false,
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 60)),
                            Center(
                              child: Image.network(
                                'https://www.metaweather.com/static/img/weather/png/' +
                                    abbreviation +
                                    '.png',
                                width: 90,
                              ),
                            ),
                            Center(
                                child: Text(
                              temperature.toString() + ' °C',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 50),
                            )),
                            Center(
                              child: Text(
                                location,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 35),
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 60)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              for (var i = 0; i < 7; i++)
                                forecastElement(
                                    i + 1,
                                    abbreviationForecast[i],
                                    minTemperatureForecast[i],
                                    maxTemperatureForecast[i]),
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(top: 50)),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(205, 212, 228, 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 330,
                              child: TextField(
                                onSubmitted: (String input) {
                                  onTextFieldSubmitted(input);
                                },
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                                decoration: InputDecoration(
                                    hintText: 'Search another location..',
                                    hintStyle: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            Text(
                              errorMessage,
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 15),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        ));
  }
}

Widget forecastElement(
    daysFromNow, abbreviation, minTemperature, maxTemperature) {
  var now = new DateTime.now();
  var oneDayFromNow = now.add(new Duration(days: daysFromNow));
  return Padding(
    padding: const EdgeInsets.only(left: 14.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(205, 212, 228, 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(
              new DateFormat.E().format(oneDayFromNow),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Text(
              new DateFormat.MMMd().format(oneDayFromNow),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Image.network(
                'https://www.metaweather.com/static/img/weather/png/' +
                    abbreviation +
                    '.png',
                width: 50,
              ),
            ),
            Text(
              'High: ' + maxTemperature.toString() + ' °C',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            Text(
              'Low: ' + minTemperature.toString() + ' °C',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ],
        ),
      ),
    ),
  );
}
