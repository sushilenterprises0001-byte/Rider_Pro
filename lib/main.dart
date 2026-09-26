import 'package:flutter/material.dart';

void main() {
  runApp(const RiderProApp());
}

class RiderProApp extends StatelessWidget {
  const RiderProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final pin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RiderPro Stock")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.lock, size: 80),
            const SizedBox(height: 20),
            TextField(
              controller: pin,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Enter PIN",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (pin.text == "1234") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomePage(),
                    ),
                  );
                }
              },
              child: const Text("LOGIN"),
            )
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final brand = TextEditingController();
  final model = TextEditingController();
  final qty = TextEditingController();

  List<Map<String, dynamic>> stock = [];

  int get total =>
      stock.fold(0, (sum, item) => sum + (item["qty"] as int));

  void addProduct() {
    setState(() {
      stock.add({
        "brand": brand.text,
        "model": model.text,
        "qty": int.tryParse(qty.text) ?? 0,
      });
      brand.clear();
      model.clear();
      qty.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Helmet Stock")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text("Total Stock"),
                trailing: Text(
                  "$total",
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            TextField(
              controller: brand,
              decoration: const InputDecoration(labelText: "Brand"),
            ),
            TextField(
              controller: model,
              decoration: const InputDecoration(labelText: "Model"),
            ),
            TextField(
              controller: qty,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Quantity"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addProduct,
              child: const Text("Add Product"),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: stock.length,
                itemBuilder: (_, i) {
                  final p = stock[i];
                  return ListTile(
                    leading: const Icon(Icons.inventory),
                    title: Text("${p["brand"]} ${p["model"]}"),
                    trailing: Text("Qty ${p["qty"]}"),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}