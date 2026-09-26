
import 'package:flutter/material.dart';

void main() => runApp(const RiderProApp());

class RiderProApp extends StatelessWidget {
  const RiderProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final model = TextEditingController();
  final qty = TextEditingController();
  final buy = TextEditingController();
  final sell = TextEditingController();

  List<Map<String, dynamic>> items = [];
  double profit = 0;

  void addProduct() {
    if (model.text.isEmpty) return;

    int q = int.tryParse(qty.text) ?? 0;
    double b = double.tryParse(buy.text) ?? 0;
    double s = double.tryParse(sell.text) ?? 0;

    setState(() {
      items.add({
        "model": model.text,
        "qty": q,
        "buy": b,
        "sell": s,
      });
      profit += (s - b) * q;
      model.clear();
      qty.clear();
      buy.clear();
      sell.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RiderPro Gear")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Profit: ₹${profit.toStringAsFixed(0)}",
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            TextField(
                controller: model,
                decoration: const InputDecoration(labelText: "Model")),
            TextField(
                controller: qty,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Qty")),
            TextField(
                controller: buy,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Buy Price")),
            TextField(
                controller: sell,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Sell Price")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: addProduct,
                child: const Text("Save Product")),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, i) {
                  final p = items[i];
                  return ListTile(
                    title: Text(p["model"]),
                    subtitle: Text(
                        "Qty: ${p["qty"]} | Buy ₹${p["buy"]} | Sell ₹${p["sell"]}"),
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
