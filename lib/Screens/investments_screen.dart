import 'package:flutter/material.dart';

class InvestmentsScreen extends StatelessWidget {
  const InvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final inversiones = [
      InvestmentData('Bonos del Estado', 2000, DateTime(2025, 12, 31)),
      InvestmentData('Acciones Tech', 1500, DateTime(2026, 3, 15)),
      InvestmentData('Fondo Inmobiliario', 700, DateTime(2027, 1, 10)),
      InvestmentData('Criptomonedas', 500, DateTime(2025, 8, 20)),
    ];

    final total = inversiones.fold<double>(0, (sum, item) => sum + item.amount);

    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Inversiones')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: Colors.blue[50],
              child: ListTile(
                leading: const Icon(Icons.trending_up, color: Colors.blue, size: 32),
                title: const Text('Total invertido', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, color: Colors.blue)),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: inversiones.length,
                itemBuilder: (context, index) {
                  final inv = inversiones[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.account_balance_wallet, color: Colors.indigo),
                      title: Text(inv.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Vence: ${inv.due.day}/${inv.due.month}/${inv.due.year}'),
                      trailing: Text('\$${inv.amount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.indigo)),
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

class InvestmentData {
  final String title;
  final double amount;
  final DateTime due;

  InvestmentData(this.title, this.amount, this.due);
 
 }