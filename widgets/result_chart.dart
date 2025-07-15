import 'package:flutter/material.dart';
import 'package:voting_app/models/poll.dart';
import 'package:fl_chart/fl_chart.dart';

class ResultChart extends StatelessWidget {
  final Poll poll;

  const ResultChart({super.key, required this.poll});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: poll.options.length <= 2
          ? BarChart(
              BarChartData(
                barGroups: poll.options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: poll.votes[option]?.toDouble() ?? 0,
                        color: _getColor(index),
                        width: 20,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                    showingTooltipIndicators: [0],
                  );
                }).toList(),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            poll.options[value.toInt()],
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold, // Added this line as replacement
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles:  AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles:  AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles:  AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData:  FlGridData(show: false),
                borderData: FlBorderData(show: false),
              ),
            )
          : PieChart(
              PieChartData(
                sections: poll.options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  return PieChartSectionData(
                    value: poll.votes[option]?.toDouble() ?? 0,
                    color: _getColor(index),
                    title: '${((poll.votes[option] ?? 0) / poll.totalVotes * 100).toStringAsFixed(1)}%',
                    radius: 60,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
                sectionsSpace: 2,
                centerSpaceRadius: 40,
              ),
            ),
    );
  }

  Color _getColor(int index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.pink,
    ];
    return colors[index % colors.length];
  }
}