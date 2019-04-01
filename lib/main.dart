import 'dart:ui';
import 'package:flutter/material.dart';
// import 'flutter_utils/bridge/bridge.dart';
import 'news/news_list.dart';
// import 'flutter_utils/widgets/common/util_mixin.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_utils/flutter_utils.dart';

void main() => runApp(_widgetForRoute(window.defaultRouteName));

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'main':
      return MyHomePage(title: "setting",).makePage();
    case 'news_list':
      return NewsListPage().makePage(); 
    default:
      return Center(
        child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
      );
  }
}

class MyHomePage extends StatefulWidget with UIHelper {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  HBBridge bridge =HBBridge();
  var testEventHandle;

  @override
  void initState() {
    super.initState();

    testEventHandle = bridge.subscribeEvent("test_event", (Object data, String error) {
      print("flutter: receive event: $data, $error"); 
    });

    // bridge.unsubscribe("test_event", testEventHandle);

    bridge.updatePage(title: "测试事件");
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    bridge.openFlutter("main");
  }

  @override
  Widget build(BuildContext context) {
    bridge.setContext(context);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            PlatformCircularProgressIndicator(),
            FlatButton(onPressed: () {
              bridge.emitEvent("test_event", data:{ "hello": "world" }, error:"error");
            },
            child: Text("Notifiy Result"),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
