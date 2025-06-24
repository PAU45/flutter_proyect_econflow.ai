import 'package:flutter/material.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ingresos = [
      IncomeData('Venta producto A', 1200, DateTime(2025, 6, 20)),
      IncomeData('Servicio consultoría', 800, DateTime(2025, 6, 18)),
      IncomeData('Venta producto B', 950, DateTime(2025, 6, 15)),
      IncomeData('Ingreso extra', 400, DateTime(2025, 6, 10)),
      IncomeData('Venta producto C', 700, DateTime(2025, 6, 5)),
    ];

    final total = ingresos.fold<double>(0, (sum, item) => sum + item.amount);

    return Scaffold(
      appBar: AppBar(title: const Text('Monitoreo de Ingresos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: Colors.green[50],
              child: ListTile(
                leading: const Icon(Icons.attach_money, color: Colors.green, size: 32),
                title: const Text('Total del mes', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, color: Colors.green)),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: ingresos.length,
                itemBuilder: (context, index) {
                  final ingreso = ingresos[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.monetization_on, color: Colors.blue),
                      title: Text(ingreso.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${ingreso.date.day}/${ingreso.date.month}/${ingreso.date.year}'),
                      trailing: Text('\$${ingreso.amount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.blue)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IncomeData {
  final String title;
  final double amount;
  final DateTime date;

  IncomeData(this.title, this.amount, this.date);
  
  }