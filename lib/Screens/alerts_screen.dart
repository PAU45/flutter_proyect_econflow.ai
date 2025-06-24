import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AlertData> alerts = [
      AlertData(
        title: 'Gasto alto detectado',
        description: 'Tus gastos superaron los \$5,000 este mes.',
        date: DateTime(2025, 6, 20),
        type: AlertType.warning,
        active: true,
      ),
      AlertData(
        title: 'Ingreso bajo',
        description: 'Tus ingresos bajaron un 20% respecto al mes pasado.',
        date: DateTime(2025, 6, 15),
        type: AlertType.error,
        active: true,
      ),
      AlertData(
        title: 'Inversión próxima a vencer',
        description: 'Tu inversión en Bonos vence el 30/06/2025.',
        date: DateTime(2025, 6, 10),
        type: AlertType.info,
        active: false,
      ),
      AlertData(
        title: 'Nuevo ingreso registrado',
        description: 'Se registró un ingreso de \$1,200.',
        date: DateTime(2025, 6, 5),
        type: AlertType.success,
        active: false,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Alertas Personalizadas')),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          return Card(
            color: alert.active
                ? (alert.type == AlertType.error
                    ? Colors.red[50]
                    : alert.type == AlertType.warning
                        ? Colors.orange[50]
                        : Colors.blue[50])
                : Colors.grey[100],
            child: ListTile(
              leading: Icon(
                alert.type.icon,
                color: alert.type.color,
              ),
              title: Text(alert.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: alert.active ? alert.type.color : Colors.grey)),
              subtitle: Text(alert.description),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${alert.date.day}/${alert.date.month}/${alert.date.year}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  if (alert.active)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Icon(Icons.notifications_active, color: Colors.amber, size: 18),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

enum AlertType { success, info, warning, error }

extension AlertTypeExtension on AlertType {
  IconData get icon {
    switch (this) {
      case AlertType.success:
        return Icons.check_circle;
      case AlertType.info:
        return Icons.info;
      case AlertType.warning:
        return Icons.warning;
      case AlertType.error:
        return Icons.error;
    }
  }

  Color get color {
    switch (this) {
      case AlertType.success:
        return Colors.green;
      case AlertType.info:
        return Colors.blue;
      case AlertType.warning:
        return Colors.orange;
      case AlertType.error:
        return Colors.red;
    }
  }
}

class AlertData {
  final String title;
  final String description;
  final DateTime date;
  final AlertType type;
  final bool active;

  AlertData({
    required this.title,
    required this.description,
    required this.date,
    required this.type,
    required this.active,
  });
}