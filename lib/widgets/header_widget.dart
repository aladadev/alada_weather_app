import 'package:alada_weather_app/controller/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String city = '';
  String currentDate = DateFormat('yMMMMd').format(DateTime.now()).toString();

  //getx inititialize
  final GlobalController _globalController =
      Get.put(GlobalController(), permanent: true);

  //initialize
  @override
  void initState() {
    getAddress();
    super.initState();
  }

  //here refractoring to get data from directly getx Controller
  getAddress() {
    List cityDetails = _globalController.getPlaceDetails();
    var scity = cityDetails[0] as Placemark;
    city = scity.thoroughfare ?? 'City Data error retrieving';
    print(scity);
  }
//getting address details from latitude and longitude
  // getAddressDetails(lat, lon) async {
  //   List<Placemark> placeMark = await placemarkFromCoordinates(lat, lon);
  //   Placemark place = placeMark[0];

  //   setState(() {
  //     city = city;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 3),
              child: Row(
                children: [
                  Icon(
                    Icons.location_city_rounded,
                  ),
                  Text(
                    city,
                    softWrap: true,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 22, right: 20, bottom: 10),
              child: Text(
                currentDate,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.menu_rounded,
            size: 40,
          ),
        ),
      ],
    );
  }
}
