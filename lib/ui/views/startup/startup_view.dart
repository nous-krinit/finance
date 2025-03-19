import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_finance/ui/common/app_text_styles.dart';
import 'package:stacked/stacked.dart';
import 'package:my_finance/ui/common/ui_helpers.dart';

import '../../common/app_colors.dart';
import '../../common/quotes.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
          child: SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(randomQuote,
                textAlign: TextAlign.center, style: TextStyles.quote),
            verticalSpaceSmall,
            Text(randomAuthor!,
                textAlign: TextAlign.center, style: TextStyles.quoteAuthor),
          ],
        ),
      )),
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
