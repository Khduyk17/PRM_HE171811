import 'package:flutter/material.dart';

void main() {
  runApp(const Lab4App());
}

class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    // Exercise 5: Applying ThemeData (Định dạng chủ đề cho toàn app)
    return MaterialApp(
      title: 'Lab 4 Flutter UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Biến cho Exercise 2: Input Widgets
  double _sliderVal = 20.0;
  bool _switchVal = true;
  int? _radioVal = 1;

  @override
  Widget build(BuildContext context) {
    // Exercise 4: Building Screen Structure using Scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lab 4 - Flutter UI Fundamentals"),
        backgroundColor: Colors.blueAccent,
      ),
      // Exercise 3: Layout Composition (Dùng ListView để cuộn trang)
      body: ListView(
        padding: const EdgeInsets.all(16.0), // Padding cho layout
        children: [
          // Exercise 1: Core Widgets (Card, ListTile, Icon, Text)
          const Card(
            elevation: 4,
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text("Nguyễn Khánh Duy", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("MSSV: HE171811"),
              trailing: Icon(Icons.verified),
            ),
          ),

          const SizedBox(height: 20),
          const Text("Exercise 2: Input Widgets Demo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          // Slider
          Slider(
            value: _sliderVal,
            max: 100,
            divisions: 5,
            label: _sliderVal.round().toString(),
            onChanged: (val) => setState(() => _sliderVal = val),
          ),

          // Switch
          SwitchListTile(
            title: const Text("Chế độ thông báo"),
            value: _switchVal,
            onChanged: (val) => setState(() => _switchVal = val),
          ),

          // Radio Buttons (Exercise 2)
          RadioListTile<int>(
            title: const Text("Lựa chọn A"),
            value: 1,
            groupValue: _radioVal,
            onChanged: (val) => setState(() => _radioVal = val),
          ),
          RadioListTile<int>(
            title: const Text("Lựa chọn B"),
            value: 2,
            groupValue: _radioVal,
            onChanged: (val) => setState(() => _radioVal = val),
          ),

          const SizedBox(height: 20),
          // Exercise 3: Row Layout
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text("Lưu")),
              OutlinedButton(onPressed: () {}, child: const Text("Hủy")),
            ],
          ),

          const SizedBox(height: 20),
          // Exercise 1: Image Widget (Dùng ảnh tạm thời từ mạng)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://picsum.photos/400/200',
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}