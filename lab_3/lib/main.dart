import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const Lab3App());
}

class Lab3App extends StatelessWidget {
  const Lab3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Lab3Screen(),
    );
  }
}

class Lab3Screen extends StatefulWidget {
  const Lab3Screen({super.key});

  @override
  State<Lab3Screen> createState() => _Lab3ScreenState();
}

class _Lab3ScreenState extends State<Lab3Screen> {
  // Logic từ Lab 3 của bạn
  List<String> results = [];

  @override
  void initState() {
    super.initState();
    runLab3Logic();
  }

  void runLab3Logic() async {
    // Ex 3: Microtask
    scheduleMicrotask(() => setState(() => results.add("Ex 3: [Microtask] đã chạy")));

    // Ex 4: Stream
    Stream.fromIterable([1, 2, 3, 4, 5])
        .where((n) => n % 2 == 0)
        .map((n) => n * n)
        .listen((val) {
      setState(() => results.add("Ex 4: Stream Value Square: $val"));
    });

    // Ex 2: Giả lập Fetch User
    setState(() => results.add("Ex 2: Đang tải danh sách User..."));
    await Future.delayed(const Duration(seconds: 1));
    setState(() => results.add("Ex 2: Đã tải xong User: Duy NK, Gemini"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lab 3 - Advanced Dart on Web")),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.check_circle, color: Colors.green),
            title: Text(results[index]),
          );
        },
      ),
    );
   } //end
}