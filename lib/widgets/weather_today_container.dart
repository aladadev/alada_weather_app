import 'package:flutter/material.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:proste_bezier_curve/utils/type/index.dart';

class WeatherTodayContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    return ClipPath(
        clipper: ProsteBezierCurve(
          position: ClipPosition.top,
          list: [
            BezierCurveSection(
              start: Offset(screenWidth, 0),
              top: Offset(screenWidth / 2, 30),
              end: Offset(0, 0),
            ),
          ],
        ),
        child: Container(
          height: size.height * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      height: 3,
                      width: 40,
                      color: Color.fromARGB(255, 200, 196, 195),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Weather Today',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              WeatherTodayAllStamps()
            ],
          ),
        ));
  }
}

class WeatherTodayAllStamps extends StatelessWidget {
  const WeatherTodayAllStamps({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: WeatherTodayTimeStamp(
              icon: Icons.sunny, time: '04.00 AM', temp: '24'),
        ),
        Expanded(
          child: WeatherTodayTimeStamp(
              icon: Icons.snowing, time: '10.00 PM', temp: '-4'),
        ),
        Expanded(
          child: WeatherTodayTimeStamp(
              icon: Icons.ramen_dining_outlined, time: '12.00 PM', temp: '14'),
        ),
        Expanded(
          child: WeatherTodayTimeStamp(
              icon: Icons.ac_unit_outlined, time: '02.00 AM', temp: '-20'),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}

class WeatherTodayTimeStamp extends StatelessWidget {
  const WeatherTodayTimeStamp({
    super.key,
    required this.icon,
    required this.time,
    required this.temp,
  });
  final IconData icon;
  final String time;
  final String temp;
  @override
  Widget build(BuildContext context) {
    final thmCxt = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 35,
            color: Colors.amber,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              time,
              style: thmCxt.textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            '$temp°',
            style: thmCxt.textTheme.labelLarge!.copyWith(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
