import 'package:flutter/material.dart';
import 'weather.dart';

class WeatherArguments {
  final String country;

  WeatherArguments(this.country);
}

class ViewWeather extends StatelessWidget {
  const ViewWeather({Key? key}) : super(key: key);

  static const routeName = "/seeWeather";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Weather;
    return Scaffold(
      appBar: AppBar(
        title: Text("Tempo em "+args.country),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child:
          ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.location_on_sharp),
                title: Text(args.country),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(args.date),
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: Text(args.text),
              )
            ],
          )
      ),
    );
  }
}