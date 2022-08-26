import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vikas/db/vikas_database.dart';
import 'package:vikas/model/vikas.dart';
import 'package:vikas/server/api.dart';

final _lightColors = [
  Colors.white,
];

class VikasCardWidget extends StatefulWidget {
  final Vikas vikas;
  final int index;
  VikasCardWidget({
    Key? key,
    required this.vikas,
    required this.index,
  }) : super(key: key);
  @override
  State<VikasCardWidget> createState() => _VikasCardWidgetState();
}

class _VikasCardWidgetState extends State<VikasCardWidget> {
  @override
  Widget build(BuildContext context) {
    final color = _lightColors[widget.index % _lightColors.length];
    final time =
        DateFormat.yMMMMEEEEd().add_Hms().format(widget.vikas.createdTime);

    return Card(
        elevation: 0,
        color: color,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.vikas.name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ));
  }
}
