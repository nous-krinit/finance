// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String CategoryValueKey = 'category';

final Map<String, TextEditingController>
    _CreateCategoryViewTextEditingControllers = {};

final Map<String, FocusNode> _CreateCategoryViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _CreateCategoryViewTextValidations = {
  CategoryValueKey: null,
};

mixin $CreateCategoryView {
  TextEditingController get categoryController =>
      _getFormTextEditingController(CategoryValueKey);

  FocusNode get categoryFocusNode => _getFormFocusNode(CategoryValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_CreateCategoryViewTextEditingControllers.containsKey(key)) {
      return _CreateCategoryViewTextEditingControllers[key]!;
    }

    _CreateCategoryViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CreateCategoryViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CreateCategoryViewFocusNodes.containsKey(key)) {
      return _CreateCategoryViewFocusNodes[key]!;
    }
    _CreateCategoryViewFocusNodes[key] = FocusNode();
    return _CreateCategoryViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    categoryController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    categoryController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          CategoryValueKey: categoryController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _CreateCategoryViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CreateCategoryViewFocusNodes.values) {
      focusNode.dispose();
    }

    _CreateCategoryViewTextEditingControllers.clear();
    _CreateCategoryViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get categoryValue => this.formValueMap[CategoryValueKey] as String?;

  set categoryValue(String? value) {
    this.setData(
      this.formValueMap..addAll({CategoryValueKey: value}),
    );

    if (_CreateCategoryViewTextEditingControllers.containsKey(
        CategoryValueKey)) {
      _CreateCategoryViewTextEditingControllers[CategoryValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasCategory =>
      this.formValueMap.containsKey(CategoryValueKey) &&
      (categoryValue?.isNotEmpty ?? false);

  bool get hasCategoryValidationMessage =>
      this.fieldsValidationMessages[CategoryValueKey]?.isNotEmpty ?? false;

  String? get categoryValidationMessage =>
      this.fieldsValidationMessages[CategoryValueKey];
}

extension Methods on FormStateHelper {
  setCategoryValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CategoryValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    categoryValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      CategoryValueKey: getValidationMessage(CategoryValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _CreateCategoryViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _CreateCategoryViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      CategoryValueKey: getValidationMessage(CategoryValueKey),
    });
