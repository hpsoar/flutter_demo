
import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

class SettingsPage extends StatefulWidget with UIHelper {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  ListModel model = new ListModel();

  void initialize() {
    
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f0ee),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[ 
            new Expanded(
              child: model.build(context),
            ) 
          ],
      ),
    );
  }
}