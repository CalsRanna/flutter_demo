import 'package:flutter/material.dart';
import 'package:flutter_demo/page/cached_view.dart';
import 'package:flutter_demo/page/snow_man.dart';

import 'page/book_reader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(useMaterial3: true),
      title: 'Flutter Demo',
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> demos = [
    {'name': 'Book Reader', 'route': const BookReaderDemo()},
    {'name': 'Cache View', 'route': const CachedView()},
    {'name': 'Snow Man', 'route': const SnaowMan()},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => demos[index]['route']),
            );
          },
          child: Container(
            color: Colors.primaries[index % 18],
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                color: Colors.transparent.withOpacity(0.25),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                height: 72,
                child: Text(
                  demos[index]['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        itemCount: demos.length,
      ),
      // Center(
      //   child: ElevatedButton(
      //     onPressed: () => navigate(context, const BookReaderDemo()),
      //     child: const Text('Book Reader Demo'),
      //   ),
      // ),
    );
  }

  void navigate(BuildContext context, Widget route) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => route));
  }
}
