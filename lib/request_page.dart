import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:core';
import 'dart:async';
import 'weather.dart';
import 'weather_service.dart';
import 'view_weather.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  static const routeName = '/loadWeather';
  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends MessageState<LoadingScreen> {
  set args(WeatherArguments args) {}

  @override
  void initState() {
    super.initState();
  }

  /// This method calls the initializers and once they complete redirects to
  /// the widget provided in navigateAfterInit
  @protected
  Future runInitTasks() async {
    /// Run each initializer method sequentially

    Weather response = await WeatherService.fetchWeather('BR', 'apiToken');
    print(response);
    Future.value(response).whenComplete(() {
      Navigator.of(context).pushReplacementNamed(
          ViewWeather.routeName,
          arguments: response,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as WeatherArguments;
    print(args.country);
    print(widget.toString());
    return Scaffold(
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            /// Paint the area where the inner widgets are loaded with the
            /// background to keep consistency with the screen background

            /// Render the Title widget, loader and messages below each other
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30.0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /// Loader Animation Widget
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(getMessage),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

abstract class MessageState<T extends StatefulWidget> extends State<T> {
  String _message = 'Carregando informações da API';

  set initialMessage(String message) => _message = message;

  set setMessage(String message) => setState(() {
    _message = message;
  });

  /// Getter for the message variable
  String get getMessage => _message;

}