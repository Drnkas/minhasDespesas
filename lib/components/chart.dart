import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minhas_financas/components/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentsTransaction;

  const Chart(this.recentsTransaction, {super.key});

  // Reponsável por pega os dias da semana e subtrair o dia atual
  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
          Duration(days: index),
      );

      double totalSum = 0.0;

      for(var i = 0; i < recentsTransaction.length; i++) {
        bool sameDay = recentsTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentsTransaction[i].date.month == weekDay.month;
        bool sameYear = recentsTransaction[i].date.year == weekDay.year;

        if(sameDay && sameMonth && sameYear) {
          totalSum += recentsTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransaction.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransaction.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: tr['day'].toString(),
                  value: (tr['value'] as double),
                  percentage: _weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue
              ),
            );
          }).toList()
        ),
      ),
    );
  }
}
