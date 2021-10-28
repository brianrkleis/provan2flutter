/// Flutter code sample for Navigator

// The following example demonstrates how a nested [Navigator] can be used to
// present a standalone user registration journey.
//
// Even though this example uses two [Navigator]s to demonstrate nested
// [Navigator]s, a similar result is possible using only a single [Navigator].
//
// Run this example with `flutter run --route=/signup` to start it with
// the signup flow instead of on the home page.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/weather_service.dart';
import 'view_weather.dart';
import 'weather.dart';

const apiToken = 'e430f22fd46716695a29e458f0297e8e';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for Navigator',
      // MaterialApp contains our top-level Navigator
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const MainMenu(),
        ViewWeather.routeName: (BuildContext context) => const ViewWeather(),
      },
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App do tempo"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Bem vindo(a) ao app do tempo"),
              GestureDetector(
                child: ElevatedButton(
                  onPressed: () async {
                    Weather weather = await WeatherService.fetchWeather("BR", apiToken);

                    //tentativa de botão de carregando vvv
                    //WidgetInspector(selectButtonBuilder: (BuildContext context, void Function() onPressed) { return const Icon(Icons.downloading); },
                    //child: const Icon(Icons.downloading));
                    Future.value(weather).whenComplete(() => Navigator.pushNamed(
                        context,
                        ViewWeather.routeName,
                        arguments: weather
                    ));

                  },
                child: const Text("Clima do Brasil"),
                )
              ),
            ]
        ),
      ),
    );
  }
}
