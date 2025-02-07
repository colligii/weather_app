import 'package:flutter/material.dart';
import '../../service/location.service.dart';
import 'package:weather_app/widgets/shared/filter.dart';
import 'dart:convert';

class LocationWidget extends StatelessWidget {
  const LocationWidget({ super.key });

  final LocationService locationService = const LocationService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: locationService.getAllCountrys(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Erro! ao carregar os estados');
          } else {
            List<dynamic> country = [];

            if (snapshot.data is String) {
              country = jsonDecode(snapshot.data);
            }

            return Filter(
              list: country,
              pathLabel: ["name", "common"],
              pathId: ['name', 'common'],
            );
          }
        });
  }
}