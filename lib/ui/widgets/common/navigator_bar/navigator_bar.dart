import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import 'navigator_bar_model.dart';

class NavigatorBar extends StackedView<NavigatorBarModel> {
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  const NavigatorBar(
      {Key? key,
      required this.selectedIndex,
      required this.onDestinationSelected})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NavigatorBarModel viewModel,
    Widget? child,
  ) {
    return NavigationBar(
      backgroundColor: primaryColor,
      indicatorColor: transparentColor,
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const <Widget>[
        NavigationDestination(
            icon: Icon(
              Icons.task_alt_rounded,
            ),
            label: 'Transactions'),
        NavigationDestination(
          icon: Icon(
            Icons.bar_chart,
          ),
          label: 'Overview',
        ),
        NavigationDestination(
            icon: Icon(
              Icons.account_circle_rounded,
            ),
            label: 'Categories'),
      ],
    );
  }

  @override
  NavigatorBarModel viewModelBuilder(
    BuildContext context,
  ) =>
      NavigatorBarModel();
}
