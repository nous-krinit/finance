import 'package:flutter/material.dart';
import 'package:my_finance/ui/widgets/common/navigator_bar/navigator_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:my_finance/ui/common/app_colors.dart';
import 'package:my_finance/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: primaryColor,
      bottomNavigationBar: const NavigatorBar(selectedIndex: 0),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.navigateToCreate();
        },
        foregroundColor: primaryColor,
        backgroundColor: secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
