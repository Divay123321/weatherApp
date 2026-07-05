import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:weather_app/secrets.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/adittional_item.dart';
import 'package:weather_app/hourly_forecast_card.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weatherFuture;

  @override
  void initState() {
    super.initState();
    weatherFuture = getcurrentweather();
  }

  Future<Map<String, dynamic>> getcurrentweather() async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=$apiweatherkey',
        ),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'unexpectec_exception';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'WEATHER APP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weatherFuture = getcurrentweather();
              });
              print('refreshed');
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: weatherFuture,
        // ignore: non_constant_identifier_names
        builder: (context, Snapshot) {
          if (Snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (Snapshot.hasError) {
            return Center(child: Text(Snapshot.error.toString()));
          }
          final data = Snapshot.data!;
          final currtemp = data['list'][0]['main']['temp'];
          final currskydesciption =
              data['list'][0]['weather'][0]['description'];
          final currsky = data['list'][0]['weather'][0]['main'];
          final currhumidity = data['list'][0]['main']['humidity'];
          final currpressure = data['list'][0]['main']['pressure'];
          final windspeed = data['list'][0]['wind']['speed'];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                //main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: const Color.fromARGB(208, 37, 32, 44),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            spacing: 16,
                            children: [
                              Text(
                                '$currtemp k',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                (currsky == 'Clouds' || currsky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny),
                                size: 64,
                              ),
                              Text(
                                currskydesciption,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Hourly Forcast',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final datetime = DateTime.parse(
                        data['list'][index + 1]['dt_txt'],
                      );
                      return HourlyForecastCard(
                        time: DateFormat.j().format(datetime),
                        value: '${data['list'][index + 1]['main']['temp']} K',
                        icon:
                            (data['list'][index + 1]['weather'][0]['main'] ==
                                    'Clouds' ||
                                data['list'][index + 1]['weather'][0]['main'] ==
                                    'Rain'
                            ? Icons.cloud
                            : Icons.sunny),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                //additional information
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Additional information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: currhumidity.toString(),
                    ),
                    AdditionalItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: windspeed.toString(),
                    ),
                    AdditionalItem(
                      icon: Icons.beach_access_rounded,
                      label: 'pressure',
                      value: currpressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
