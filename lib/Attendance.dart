// ignore_for_file: camel_case_types, library_private_types_in_public_api, constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  _facultypageState createState() => _facultypageState();
}

class _facultypageState extends State<Attendance> {
  Timer? timer;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _webViewController = Completer<WebViewController>();
  String _pastAtt = 'Updating',
      ab = '',
      _us = '',
      _ps = '',
      msg = 'loading',
      time = ' ';
  SharedPreferences? _prefs;
  bool sp = false, be = true;
  static const String PrefKey = 'demo_number_pref';
  static const String PrefKey1 = 'demo_number_pref1';
  static const String PrefKey2 = 'demo_number_pref2';
  static const String PrefKey3 = 'demo_number_pref3';
  @override
  void initState() {
    sp = false;
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => _prefs = prefs);
      loadold();
      loadpass();
      loadus();
      loadTime();
    });
  }

  Future<void> _getAttendance() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    setState(() {
      be = !be;
    });
    // Navigate to the login page
    await _webViewController.future.then((controller) {
      controller
          .loadUrl('https://automation.vnrvjiet.ac.in/EduPrime3/VNRVJIET');
    });
    // Wait for the login page to load and enter the credentials and click the login button
    await Future.delayed(Duration(seconds: 5));
    await _webViewController.future.then((controller) async {
      await controller.runJavascript(
        "document.getElementsByName('UserName')[0].value = '$username';"
        "document.getElementsByName('xPassword')[0].value = '$password';"
        "document.querySelector(\"button[type='submit']\").click();",
      );
    });
    // Wait for the dashboard page to load and click the attendance button
    await Future.delayed(Duration(seconds: 5));
    await _webViewController.future.then((controller) async {
      await controller.runJavascript(
        "document.querySelector('#attp').click();",
      );
    });
    // Wait for the attendance page to load and get the attendance percentage
    await Future.delayed(Duration(seconds: 10));
    await _webViewController.future.then((controller) async {
      final attendancePercentage =
          await controller.runJavascriptReturningResult(
        "document.querySelector('h4.font-medium.m-b-0').innerText;",
      );
      setState(() {
        _pastAtt = attendancePercentage;
        setus(_usernameController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextFormField(
                obscureText: !sp,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        sp = !sp;
                      });
                    },
                    child: Icon(
                      sp ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: !be
                    ? null
                    : () async {
                        await _getAttendance();
                        setus(_usernameController.text);
                        setpass(_passwordController.text);
                        setold(_pastAtt);
                        setTime();
                      },
                child: const Text('Get Attendance'),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  _pastAtt,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  "last loaded : " + time,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(
                width: 0.1,
                height: 0.1,
                child: WebView(
                  initialUrl:
                      'https://automation.vnrvjiet.ac.in/EduPrime3/VNRVJIET',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    _webViewController.complete(controller);
                  },
                  javascriptChannels: <JavascriptChannel>[
                    JavascriptChannel(
                      name: 'flutter_inappwebview',
                      onMessageReceived: (JavascriptMessage message) {
                        print(message.message);
                      },
                    )
                  ].toSet(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadold() {
    setState(() {
      _pastAtt = _prefs?.getString(PrefKey2) ?? "not stored";
      if (!be) {
        be = !be;
        loadTime();
      }
    });
  }

  Future<void> setold(String pa) async {
    await _prefs?.setString(PrefKey2, pa);
    loadold();
  }

  void loadus() {
    setState(() {
      _us = _prefs?.getString(PrefKey) ?? "20071A";
      _usernameController.text = _us;
    });
  }

  Future<void> setus(String us) async {
    await _prefs?.setString(PrefKey, us);
    loadus();
  }

  void loadpass() {
    setState(() {
      _ps = _prefs?.getString(PrefKey1) ?? "";
      _passwordController.text = _ps;
    });
  }

  Future<void> setpass(String pass) async {
    await _prefs?.setString(PrefKey1, pass);
    loadpass();
  }

  void loadTime() async {
    setState(() {
      time = _prefs?.getString(PrefKey3) ?? 'freshie';
    });
  }

  Future<void> setTime() async {
    String m =
        "${DateFormat('MMM').format(DateTime.now())} ${DateTime.now().toString().substring(8, 16)}";
    await _prefs!.setString(PrefKey3, m);
    loadTime();
  }
}
