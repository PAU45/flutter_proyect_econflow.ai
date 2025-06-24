import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rendimientoMensual = [
      PerformanceData('Ene', 1200),
      PerformanceData('Feb', 1500),
      PerformanceData('Mar', 1100),
      PerformanceData('Abr', 1800),
      PerformanceData('May', 1700),
      PerformanceData('Jun', 2100),
    ];

    final promedio = rendimientoMensual.fold<double>(0, (sum, item) => sum + item.valor) / rendimientoMensual.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Análisis de Rendimiento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: Colors.purple[50],
              child: ListTile(
                leading: const Icon(Icons.show_chart, color: Colors.purple, size: 32),
                title: const Text('Promedio mensual', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('\$${promedio.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, color: Colors.purple)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Rendimiento por mes', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 220,
              child: BarChart(
                BarChartData(
                  barGroups: List.generate(
                    rendimientoMensual.length,
                    (i) => BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: rendimientoMensual[i].valor.toDouble(),
                          color: Colors.purple,
                          width: 18,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final meses = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'];
                          final idx = value.toInt();
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              idx >= 0 && idx < meses.length ? meses[idx] : '',
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '¡Buen trabajo! Tu rendimiento ha mejorado en los últimos meses.',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class PerformanceData {
  final String mes;
  final int valor;
  PerformanceData(this.mes, this.valor);
}