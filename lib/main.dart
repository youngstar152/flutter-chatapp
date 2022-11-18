import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './screen/register_master.dart';
import './screen/signin_page.dart';
import './screen/welcome.dart';
import './screen/chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter ChatApp',
        initialRoute: WelcomePage.id,
        routes: {
          RegisterPage.id: (context) => RegisterPage(),
          SignInPage.id: (context) => SignInPage(),
          WelcomePage.id: (context) => WelcomePage(),
          ChatPage.id: (context) => ChatPage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  int _counter = 0;

  void _incrementCounter() async {
    DocumentSnapshot doc = await _db.collection('counter').doc('test').get();
    Map<String, dynamic> fields = {'count': doc['count']} ?? {'count': 0};
    setState(() {
      _counter = fields['count'] + 1;
    });
    await _db.collection('counter').doc('test').set({
      'count': _counter,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   int _counter = 0;

//   void _incrementCounter() async {
//     SharedPreferences prefs = await _prefs;
//     setState(() {
//       _counter = (prefs.getInt('counter') ?? 0) + 1;
//     });
//     await prefs.setInt("counter", _counter);
//   }

//   Future<int> _getCount() async {
//     SharedPreferences prefs = await _prefs;
//     return Future<int>.value(prefs.getInt('counter') ?? 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     _getCount().then((value) {
//       setState(() {
//         _counter = value;
//       });
//     });
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
