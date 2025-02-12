import 'package:flutter/material.dart';
import '../../utils/shared.dart';

class Filter extends StatefulWidget {
  final List<dynamic> list;
  final List<String> pathLabel;
  final List<String> pathId;
  final void Function(dynamic) nextStep;

  Filter({
    Key? key,
    required this.list,
    required this.pathLabel,
    required this.pathId,
    required this.nextStep
  }) : super(key: key);

  @override
  State<Filter> createState() => _Filter();
}

class _Filter extends State<Filter> {

  String filter = "";
  late List<dynamic> _listClone;

  @override
  void initState() {
    super.initState();
    _listClone = widget.list;
  }

  bool matchesFilter(Map<String, dynamic> item, List<String> path) {
    return filter.trim() == "" ||
        "${Shared.getNestedValue(item, path)}".toUpperCase().trim().contains(filter.trim().toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> list = widget.list;
    List<String> pathLabel = widget.pathLabel;
    List<String> pathId = widget.pathId;
    void Function(dynamic) nextStep = widget.nextStep;

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            onChanged: (val) {
              setState(() {
                filter = "$val";
                _listClone = list
                    .where((item) => matchesFilter(item, pathLabel))
                    .toList();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _listClone.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  nextStep(Shared.getNestedValue(_listClone[index], pathId));
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "${Shared.getNestedValue(_listClone[index], pathLabel)}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
