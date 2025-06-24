import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProjectionsScreen extends StatelessWidget {
  const ProjectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final proyecciones = [
      ProjectionData('Jul', 2600),
      ProjectionData('Ago', 2750),
      ProjectionData('Sep', 2900),
      ProjectionData('Oct', 3100),
      ProjectionData('Nov', 3200),
      ProjectionData('Dic', 3400),
    ];

    final totalProyectado = proyecciones.fold<int>(0, (sum, item) => sum + item.valor);

    return Scaffold(
      appBar: AppBar(title: const Text('Proyecciones Futuras')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Colors.teal[100],
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Icon(Icons.trending_up, color: Colors.teal, size: 48),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total proyectado', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          Text('\$${totalProyectado.toString()}',
                              style: const TextStyle(fontSize: 28, color: Colors.teal, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text('Ingresos proyectados', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(
                        height: 220,
                        child: BarChart(
                          BarChartData(
                            barGroups: List.generate(
                              proyecciones.length,
                              (i) => BarChartGroupData(
                                x: i,
                                barRods: [
                                  BarChartRodData(
                                    toY: proyecciones[i].valor.toDouble(),
                                    gradient: const LinearGradient(
                                      colors: [Colors.teal, Colors.greenAccent],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                    width: 22,
                                    borderRadius: BorderRadius.circular(8),
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
                                    final meses = ['Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
                                    final idx = value.toInt();
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        idx >= 0 && idx < meses.length ? meses[idx] : '',
                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Recomendaciones', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 8),
                      Text('• Mantén tus gastos bajo control para cumplir la proyección.'),
                      Text('• Considera invertir el excedente mensual.'),
                      Text('• Revisa tus alertas para evitar sorpresas.'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text('Descargar reporte'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '¡Sigue así! Tus ingresos proyectados muestran una tendencia positiva.',
              style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class ProjectionData {
  final String mes;
  final int valor;
  ProjectionData(this.mes, this.valor);
}