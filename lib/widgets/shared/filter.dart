import 'package:flutter/material.dart';
import '../../utils/shared.dart';

class Filter extends StatefulWidget {
  final List<dynamic> list;
  final List<String> path;

  Filter({Key? key, required this.list, required this.path}) : super(key: key);

  @override
  State<Filter> createState() => _Filter();
}

class _Filter extends State<Filter> {

  String filter = "";

  bool matchesFilter(Map<String, dynamic> item, List<String> path) {
    return filter.trim() == "" || "${Shared.getNestedValue(item, path)}".toUpperCase().trim().contains(filter.trim().toUpperCase());
  }

  @override
  Widget build(BuildContext context) {

    List<dynamic> list = widget.list;
    List<String> path = widget.path;

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            onChanged: (val) {
              setState(() {
                filter = "$val";
              });
            },
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: list
                  .where((item) => matchesFilter(item, path))
                  .map((dynamic country) => InkWell(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "${Shared.getNestedValue(country, path)}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}