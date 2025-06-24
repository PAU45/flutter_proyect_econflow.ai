import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalIngresos = 12500;
    final totalGastos = 8300;
    final totalInversiones = 4200;
    final alertasActivas = 2;

    final ingresosMensuales = [
      1000.0,
      1200.0,
      1500.0,
      1800.0,
      2100.0,
      2400.0,
      2500.0,
    ];
    final meses = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul'];

    final distribucionGastos = [
      PieData('Operativos', 3500, Colors.redAccent),
      PieData('Personal', 2500, Colors.orangeAccent),
      PieData('Marketing', 1200, Colors.blueAccent),
      PieData('Otros', 1100, Colors.greenAccent),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Panel de Control'),
        backgroundColor: Colors.black,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tarjetas resumen
              Row(
                children: [
                  _InfoCard(
                    title: 'Ingresos',
                    value: '\$${totalIngresos.toString()}',
                    icon: Icons.attach_money,
                    color: Colors.greenAccent,
                  ),
                  const SizedBox(width: 8),
                  _InfoCard(
                    title: 'Gastos',
                    value: '\$${totalGastos.toString()}',
                    icon: Icons.money_off,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(width: 8),
                  _InfoCard(
                    title: 'Inversiones',
                    value: '\$${totalInversiones.toString()}',
                    icon: Icons.trending_up,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Alertas activas
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                color: Colors.amber[900]?.withOpacity(0.15),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                  child: Row(
                    children: [
                      Icon(Icons.notifications_active, color: Colors.amber[400], size: 28),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Alertas Activas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                          Text('$alertasActivas', style: TextStyle(fontSize: 18, color: Colors.amber[400], fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/alerts'),
                        child: const Text('Ver alertas', style: TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Gráficos
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gráfico de barras
                  Expanded(
                    flex: 2,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      color: const Color(0xFF181A1B),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Ingresos Mensuales', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 120,
                              child: BarChart(
                                BarChartData(
                                  barGroups: List.generate(
                                    ingresosMensuales.length,
                                    (i) => BarChartGroupData(
                                      x: i,
                                      barRods: [
                                        BarChartRodData(
                                          toY: ingresosMensuales[i],
                                          width: 14,
                                          borderRadius: BorderRadius.circular(5),
                                          gradient: const LinearGradient(
                                            colors: [Colors.tealAccent, Colors.greenAccent],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) {
                                          final idx = value.toInt();
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 6.0),
                                            child: Text(
                                              idx >= 0 && idx < meses.length ? meses[idx] : '',
                                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white70),
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
                  const SizedBox(width: 8),
                  // Gráfico circular
                  Expanded(
                    flex: 1,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      color: const Color(0xFF181A1B),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            const Text('Gastos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                            SizedBox(
                              height: 80,
                              child: PieChart(
                                PieChartData(
                                  sections: distribucionGastos
                                      .map(
                                        (d) => PieChartSectionData(
                                          color: d.color,
                                          value: d.value.toDouble(),
                                          title: '',
                                          radius: 28,
                                        ),
                                      )
                                      .toList(),
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Leyenda
                            Wrap(
                              spacing: 8,
                              children: distribucionGastos.map((d) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(width: 8, height: 8, color: d.color, margin: const EdgeInsets.only(right: 4)),
                                    Text(d.label, style: const TextStyle(fontSize: 11, color: Colors.white70)),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Menú de navegación
              const Text('Accesos rápidos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
              const SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.7,
                children: [
                  _MenuButton(
                    icon: Icons.trending_up,
                    label: 'Registro de Inversiones',
                    route: '/investments',
                  ),
                  _MenuButton(
                    icon: Icons.attach_money,
                    label: 'Monitoreo de Ingresos',
                    route: '/income',
                  ),
                  _MenuButton(
                    icon: Icons.analytics,
                    label: 'Análisis de Rendimiento',
                    route: '/performance',
                  ),
                  _MenuButton(
                    icon: Icons.show_chart,
                    label: 'Proyecciones Futuras',
                    route: '/projections',
                  ),
                  _MenuButton(
                    icon: Icons.notifications,
                    label: 'Alertas Personalizadas',
                    route: '/alerts',
                  ),
                  _MenuButton(
                      icon: Icons.chat,
                      label: 'Chat IA',
                      route: '/chat',
                    ),
                ],
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class PieData {
  final String label;
  final int value;
  final Color color;
  PieData(this.label, this.value, this.color);
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        color: const Color(0xFF181A1B),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
          child: Column(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 6),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
              Text(value, style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF181A1B),
        foregroundColor: Colors.tealAccent,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        alignment: Alignment.centerLeft,
      ),
      icon: Icon(icon, color: Colors.tealAccent),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      onPressed: () => Navigator.pushNamed(context, route),
    );
  }
}