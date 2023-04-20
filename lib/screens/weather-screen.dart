import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import '../controllers/weather-conroller.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  late Future<String> _weatherData;

  @override
  void initState() {
    super.initState();
    _weatherData = WeatherController().fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather in Tallinn'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _weatherData = WeatherController().fetchWeather();
              });
            },
          ),
        ],
      ),
      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/city-architecture-tower-old-tallinn-estonia.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
        child: FutureBuilder(
          future: _weatherData,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data ?? '',
                    style: TextStyle(fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }
          },
        ),
      ),

      //backgroundColor: Colors.blueGrey,

    );
  }
}