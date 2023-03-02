import 'package:alada_weather_app/controller/global_controller.dart';
import 'package:alada_weather_app/screens/testing.dart';
import 'package:alada_weather_app/widgets/header_widget.dart';
import 'package:alada_weather_app/widgets/weather_today_container.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController _globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  void initState() {
    _globalController.getLoaction();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentWeather = _globalController.getCurrentWeather();
    final thmCxt = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    final double wholeHeight = size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => _globalController.checkLoadingStatus().isTrue
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: wholeHeight,
                          child: Image.network(
                            'https://images.unsplash.com/photo-1603729451468-c29f7f414a3c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGNhcnRvb24lMjB2aWxsYWdlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=1000&q=100',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Header(),
                        Positioned(
                          top: 100,
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              currentWeather.value.main!.temp.toString(),
                              style: thmCxt.textTheme.displayLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: WeatherTodayContainer(),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
