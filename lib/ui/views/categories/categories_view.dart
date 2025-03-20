import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/app_text_styles.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/common/navigator_bar/navigator_bar.dart';
import 'categories_viewmodel.dart';

class CategoriesView extends StackedView<CategoriesViewModel> {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CategoriesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: primaryColor,
      bottomNavigationBar: NavigatorBar(
        selectedIndex: 2,
        onDestinationSelected: (index) {
          viewModel.navigatorBar(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.createCategory();
        },
        foregroundColor: primaryColor,
        backgroundColor: secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpaceSmall,
                  Text('Categories', style: TextStyles.stats),
                  verticalSpaceSmall,
                  Expanded(
                      child: ListView.builder(
                          itemCount: viewModel.categories.length,
                          itemBuilder: (context, index) {
                            final category = viewModel.categories[index];
                            return Card(
                              color: secondaryColor,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0,
                                    right: 4.0,
                                    top: 8.0,
                                    bottom: 8.0),
                                child: Row(
                                  children: [
                                    horizontalSpaceSmall,
                                    Icon(
                                      IconData(
                                        int.parse(category.icon, radix: 16),
                                        fontFamily: 'MaterialIcons',
                                      ),
                                      size: 32,
                                      color: Color(category.color),
                                    ),
                                    Expanded(
                                        child: ListTile(
                                      title: Text(
                                        category.name,
                                        style: TextStyles.cardTitle,
                                      ),
                                    )),
                                    horizontalSpaceSmall,
                                    IconButton(
                                        onPressed: () {
                                          viewModel.editCategory(category);
                                        },
                                        icon: Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          viewModel.showDialog(category);
                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            );
                          }))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  CategoriesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CategoriesViewModel();
}
