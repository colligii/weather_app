import 'package:flutter/material.dart';
import '../../service/location.service.dart';
import 'package:weather_app/widgets/shared/filter.dart';
import 'dart:convert';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<StatefulWidget> createState() => _LocationWidget();
}

class _LocationWidget extends State<LocationWidget> {
  LocationService locationService = const LocationService();
  String type = "country";
  String? countryValue = null;

  String getLabel() {
    switch (type) {
      case "country":
        return "Selecione um País:";
      default:
        return "Tipo Mão Indentificado";
    }
  }

  String getError() {
    switch (type) {
      case "country":
        return "Erro ao carregar os países!";
      default:
        return "Erro inesperado!";
    }
  }

  String? getNextStep() {
    switch(type) {
      case "country":
        return "state";
      default:
        return null;
    }
  }

  void handleNextStep(dynamic value) {
    String? nextStep = getNextStep();

    if(value is String && type == "country") {
      countryValue = value;
    }


    if(nextStep != null) {
      setState(() {
        type = nextStep;
      });
    }
  }

  List<String> getPathName() {
    switch (type) {
      case "country":
        return ["name", "common"];
      default:
        return [];
    }
  }

  List<String> getPathId() {
    switch (type) {
      case "country":
        return ["name", "common"];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    switch(type) {
      case "country":
        return FutureBuilder(
            future: locationService.getAllCountrys(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(snapshot.hasError)
                          Text(getError())
                        else
                          CircularProgressIndicator()
                      ],
                    )
                  ],
                );
              } else {
                List<dynamic> country = [];

                if (snapshot.data is String) {
                  country = jsonDecode(snapshot.data);
                }

                return Column(
                  children: [
                    Text(
                      getLabel(),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: Filter(
                        list: country,
                        pathLabel: getPathName(),
                        pathId: getPathId(),
                        nextStep: handleNextStep,
                      ),
                    ),
                  ],
                );
              }
            });
      default:
        return Text("Erro na aplicação! $countryValue");
    }
  }
}
