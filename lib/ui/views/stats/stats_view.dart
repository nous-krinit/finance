import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../common/app_colors.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/common/navigator_bar/navigator_bar.dart';
import 'stats_viewmodel.dart';

class StatsView extends StackedView<StatsViewModel> {
  const StatsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StatsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: primaryColor,
        bottomNavigationBar: NavigatorBar(
          selectedIndex: 1,
          onDestinationSelected: (index) {
            viewModel.navigatorBar(index);
          },
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpaceSmall,
                Text('Overview', style: TextStyles.stats),
                verticalSpaceSmall,
                Text('Spend by Category', style: TextStyles.statsTitle),
                verticalSpaceSmall,
                Column(
                  children: [
                    SizedBox(
                      height: 400,
                      child: PieChart(
                        PieChartData(
                          sections: viewModel.pieChartSections,
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: viewModel.categories.map((category) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(category.color),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(category.name, style: TextStyles.mapTitle),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),

                verticalSpaceMedium,
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: 'Income',
                    style: TextStyles.statsTitle,
                  ),
                  TextSpan(
                    text: ' (in last one month)',
                    style: TextStyles.statsSubHeading,
                  ),
                ])),
                verticalSpaceSmall,
                Text('${viewModel.totalIncome}', style: TextStyles.statsValue),
                verticalSpaceMedium,
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: 'Expense',
                    style: TextStyles.statsTitle,
                  ),
                  TextSpan(
                    text: ' (in last one month)',
                    style: TextStyles.statsSubHeading,
                  ),
                ])),
                verticalSpaceSmall,
                Text('${viewModel.totalExpense}', style: TextStyles.statsValue),
                verticalSpaceMedium,
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: 'Income',
                    style: TextStyles.statsTitle,
                  ),
                  TextSpan(
                    text: ' (in last one month)',
                    style: TextStyles.statsSubHeading,
                  ),
                ])),
                verticalSpaceSmall,
                Text('${viewModel.totalIncome - viewModel.totalExpense}',
                    style: TextStyles.statsValue),
                verticalSpaceMedium,
              ],
            ),
          ),
        )));
  }

  @override
  StatsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StatsViewModel();
}
