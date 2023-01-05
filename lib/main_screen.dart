import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'line_graph.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseReference database = FirebaseDatabase().reference();
  double? sensorReading1;
  double? sensorReading2;
  List<double> values1 = [];
  List<double> values2 = [];

  @override
  void initState() {
    database.child("sensors").child("sensor1").onValue.listen((event) {
      sensorReading1 = event.snapshot.value * 1.0;
      values1.add(sensorReading1!);
      print("get $sensorReading1");
      setState(() {});
    });
    database.child("sensors").child("sensor2").onValue.listen((event) {
      sensorReading2 = event.snapshot.value * 1.0;
      values2.add(sensorReading2!);
      print("get $sensorReading2");
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(34, 45, 57, 1),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(34, 45, 57, 1),
        onPressed: () {
          values2 = [sensorReading1 ?? 0];
          values1 = [sensorReading2 ?? 0];

          setState(() {});
        },
        child: const Icon(Icons.clear),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(10, 214, 102, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        leading: const Icon(Icons.precision_manufacturing_outlined),
        title: const Text("SAVING OYSTERS",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            )),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Water analysis',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(34, 45, 57, 1),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: screenLayout(),
      ),
    );
  }

  List<Widget> screenLayout() {
    return [
      sensorReadingWidget(
          "Solubility", sensorReading1, const Color.fromRGBO(10, 214, 102, 1)),
      sensorReadingWidget("Conductivity", sensorReading2,
          const Color.fromRGBO(23, 234, 234, 1.0)),
      Container(
        width: double.infinity,
        height: 300,
        padding: const EdgeInsets.all(15.0).copyWith(left: 0),
        child: LineGraph(values1, values2),
      ),
    ];
  }

  Widget sensorReadingWidget(String label, double? value, Color color) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: color)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  label,
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      FittedBox(
                        child: Text(
                          value == null ? "..." : '$value',
                          style: TextStyle(
                              fontSize: 50,
                              color: color,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'm',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
