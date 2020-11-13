import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application info by Mimba',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Application info by Mimba'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String appName = "";
  String appID = "";
  String version = "";
  String buildNumber = "";
  String appDocPath = "";
  String appTempPath = "";

  @override
  void initState() {
    super.initState();
    getAppInfo();
  }

  void getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Directory tempDir = await getTemporaryDirectory();
    Directory docDir = await getApplicationDocumentsDirectory();

    setState(() {
      appName = packageInfo.appName;
      appID = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      appDocPath = docDir.path;
      appTempPath = tempDir.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: Text("App Name"),
                    subtitle: Text(appName),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Package Name (AppID)"),
                    subtitle: Text(appID),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Version"),
                    subtitle: Text(version),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Build Number"),
                    subtitle: Text(buildNumber),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("App document path"),
                    subtitle: Text(appDocPath),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("App tempory path"),
                    subtitle: Text(appTempPath),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
