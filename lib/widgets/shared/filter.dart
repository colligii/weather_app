import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  final List<dynamic> list;

  Filter({Key? key, required this.list}) : super(key: key);

  @override
  State<Filter> createState() => _Filter();
}

class _Filter extends State<Filter> {

  String filter = "";

  @override
  Widget build(BuildContext context) {

    List<dynamic> list = widget.list;

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
                  .where((item) => filter.trim() == "" || filter.trim().toUpperCase() == "${item["name"]["common"]}".toUpperCase().trim())
                  .map((dynamic country) => InkWell(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "${country['name']['common']}",
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