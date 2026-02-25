// Phần 4: Ví dụ về OOP
class Vehicle {
  String brand;
  Vehicle(this.brand);
  void drive() => print("$brand is moving");
}

void main() async {
  // --- Phần 1: Basic Syntax ---
  int age = 25; // Kiểu số nguyên
  print("Tuổi: $age");

  // --- Phần 2: Collections ---
  List<String> fruits = ['Apple', 'Banana'];
  fruits.add('Orange');

  // --- Phần 3: Functions ---
  int sum(int a, int b) => a + b;
  print("Tổng: ${sum(5, 10)}");

  // --- Phần 5: Async & Null Safety ---
  print("Đang tải dữ liệu...");
  String data = await fetchData();
  print(data);
}

Future<String> fetchData() async {
  return Future.delayed(Duration(seconds: 2), () => "Dữ liệu đã về!");
}