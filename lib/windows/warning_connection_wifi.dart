

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WarningWidgetCubit extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 60,
      color: Colors.red,
      child: Row(
        children: const [
          Icon(Icons.wifi_off),
          SizedBox(width: 8.0),
          Text('Sin conexión a internet'),

        ],
      ),
    );
  }

}