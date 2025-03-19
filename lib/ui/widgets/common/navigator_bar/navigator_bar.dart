import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import 'navigator_bar_model.dart';

class NavigatorBar extends StackedView<NavigatorBarModel> {
  final int selectedIndex;
  const NavigatorBar({Key? key, required this.selectedIndex}) : super(key: key);

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
      onDestinationSelected: (index) {},
      destinations: const <Widget>[
        NavigationDestination(
            icon: Icon(
              Icons.task_alt_rounded,
              color: tertiaryColor,
            ),
            label: 'Transactions'),
        NavigationDestination(
          icon: Icon(
            Icons.bar_chart,
            color: secondaryColor,
          ),
          label: 'Overview',
        ),
        NavigationDestination(
            icon: Icon(
              Icons.account_circle_rounded,
              color: secondaryColor,
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
