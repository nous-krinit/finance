import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_finance/app/app.router.dart';
import 'package:my_finance/ui/common/app_colors.dart';
import 'package:my_finance/ui/common/app_text_styles.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/category.dart';
import '../../../models/transaction.dart';
import '../../../services/database_service.dart';

class StatsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _databaseService = locator<DatabaseService>();

  List<AppTransaction> get transactions =>
      _databaseService.getCachedTransactions();
  List<TxCategory> get categories => _databaseService.getCachedCategories();
  String todayDate =
      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
  double get totalIncome => transactions.where((tx) {
        List<String> txDateParts = tx.date.split('/');
        if (txDateParts.length != 3) return false;
        List<String> dateParts = todayDate.split('/');
        DateTime today = DateTime(
            int.parse(dateParts[2]), // year
            int.parse(dateParts[1]), // month
            int.parse(dateParts[0]) // day
            );
        DateTime txDate = DateTime(
            int.parse(txDateParts[2]), // year
            int.parse(txDateParts[1]), // month
            int.parse(txDateParts[0]) // day
            );
        return txDate.year == today.year &&
            txDate.month == today.month &&
            tx.type == 'Income';
      }).fold(0, (sum, tx) => sum + tx.amount);
  double get totalExpense => transactions.where((tx) {
        List<String> txDateParts = tx.date.split('/');
        if (txDateParts.length != 3) return false;
        List<String> dateParts = todayDate.split('/');
        DateTime today = DateTime(
            int.parse(dateParts[2]), // year
            int.parse(dateParts[1]), // month
            int.parse(dateParts[0]) // day
            );
        DateTime txDate = DateTime(
            int.parse(txDateParts[2]), // year
            int.parse(txDateParts[1]), // month
            int.parse(txDateParts[0]) // day
            );
        return txDate.year == today.year &&
            txDate.month == today.month &&
            tx.type == 'Expense';
      }).fold(0, (sum, tx) => sum + tx.amount);

  List<PieChartSectionData> get pieChartSections {
    Map<String, int> categoryNameToId = {
      for (var category in categories) category.name: category.id ?? 0
    };

    Map<int, double> categoryTotals = {};

    for (var tx in transactions) {
      if (tx.type == 'Expense') {
        int? categoryId = categoryNameToId[tx.category];
        if (categoryId != null) {
          categoryTotals[categoryId] =
              (categoryTotals[categoryId] ?? 0) + tx.amount;
        }
      }
    }

    double totalExpenseSum =
        categoryTotals.values.fold(0, (sum, value) => sum + value);

    return categoryTotals.entries.map((entry) {
      final category = categories.firstWhere(
        (c) => c.id == entry.key,
        orElse: () => TxCategory(
            name: "Unknown", color: greyColor.toARGB32(), icon: 'F036B'),
      );
      final percentage = (entry.value / totalExpenseSum) * 100;

      return PieChartSectionData(
        color: Color(category.color),
        value: entry.value,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 80,
        titleStyle:
            TextStyles.statsValue.copyWith(color: primaryColor, fontSize: 14),
      );
    }).toList();
  }

  Future navigatorBar(int index) async {
    if (index == 0) {
      await _databaseService.getTransactions();
      await _databaseService.getCategories();
      _navigationService.replaceWithHomeView();
    } else if (index == 1) {
      await _databaseService.getTransactions();
      await _databaseService.getCategories();
      _navigationService.replaceWithStatsView();
    } else {
      await _databaseService.getCategories();
      _navigationService.replaceWithCategoriesView();
    }
  }
}
