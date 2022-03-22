import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Text(
          'Echec de lancement de firebase',
          style: TextStyle(fontSize: 50.0),
        ),
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return SpinKitHourGlass(
        color: Colors.white,
        size: 50.0,
      );
    }

    return StreamProvider<CostumUser?>.value(
        initialData: null, catchError: (User,CostumUser) => null, value: AuthService().costumuser, child: Wrapper());

    // return Container(
    //   alignment: Alignment.center,
    //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    //   child: Text('COUCOU FLUTTER FIIRE'),
    // );
  }
}
