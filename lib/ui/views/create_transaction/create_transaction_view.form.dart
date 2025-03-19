// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String AmountValueKey = 'amount';
const String NoteValueKey = 'note';
const String DateValueKey = 'date';

final Map<String, TextEditingController>
    _CreateTransactionViewTextEditingControllers = {};

final Map<String, FocusNode> _CreateTransactionViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _CreateTransactionViewTextValidations = {
  AmountValueKey: null,
  NoteValueKey: null,
};

mixin $CreateTransactionView {
  TextEditingController get amountController =>
      _getFormTextEditingController(AmountValueKey);
  TextEditingController get noteController =>
      _getFormTextEditingController(NoteValueKey);

  FocusNode get amountFocusNode => _getFormFocusNode(AmountValueKey);
  FocusNode get noteFocusNode => _getFormFocusNode(NoteValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_CreateTransactionViewTextEditingControllers.containsKey(key)) {
      return _CreateTransactionViewTextEditingControllers[key]!;
    }

    _CreateTransactionViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CreateTransactionViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CreateTransactionViewFocusNodes.containsKey(key)) {
      return _CreateTransactionViewFocusNodes[key]!;
    }
    _CreateTransactionViewFocusNodes[key] = FocusNode();
    return _CreateTransactionViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    amountController.addListener(() => _updateFormData(model));
    noteController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    amountController.addListener(() => _updateFormData(model));
    noteController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          AmountValueKey: amountController.text,
          NoteValueKey: noteController.text,
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

    for (var controller
        in _CreateTransactionViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CreateTransactionViewFocusNodes.values) {
      focusNode.dispose();
    }

    _CreateTransactionViewTextEditingControllers.clear();
    _CreateTransactionViewFocusNodes.clear();
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

  String? get amountValue => this.formValueMap[AmountValueKey] as String?;
  String? get noteValue => this.formValueMap[NoteValueKey] as String?;
  DateTime? get dateValue => this.formValueMap[DateValueKey] as DateTime?;

  set amountValue(String? value) {
    this.setData(
      this.formValueMap..addAll({AmountValueKey: value}),
    );

    if (_CreateTransactionViewTextEditingControllers.containsKey(
        AmountValueKey)) {
      _CreateTransactionViewTextEditingControllers[AmountValueKey]?.text =
          value ?? '';
    }
  }

  set noteValue(String? value) {
    this.setData(
      this.formValueMap..addAll({NoteValueKey: value}),
    );

    if (_CreateTransactionViewTextEditingControllers.containsKey(
        NoteValueKey)) {
      _CreateTransactionViewTextEditingControllers[NoteValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasAmount =>
      this.formValueMap.containsKey(AmountValueKey) &&
      (amountValue?.isNotEmpty ?? false);
  bool get hasNote =>
      this.formValueMap.containsKey(NoteValueKey) &&
      (noteValue?.isNotEmpty ?? false);
  bool get hasDate => this.formValueMap.containsKey(DateValueKey);

  bool get hasAmountValidationMessage =>
      this.fieldsValidationMessages[AmountValueKey]?.isNotEmpty ?? false;
  bool get hasNoteValidationMessage =>
      this.fieldsValidationMessages[NoteValueKey]?.isNotEmpty ?? false;
  bool get hasDateValidationMessage =>
      this.fieldsValidationMessages[DateValueKey]?.isNotEmpty ?? false;

  String? get amountValidationMessage =>
      this.fieldsValidationMessages[AmountValueKey];
  String? get noteValidationMessage =>
      this.fieldsValidationMessages[NoteValueKey];
  String? get dateValidationMessage =>
      this.fieldsValidationMessages[DateValueKey];
}

extension Methods on FormStateHelper {
  Future<void> selectDate({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate != null) {
      this.setData(
        this.formValueMap..addAll({DateValueKey: selectedDate}),
      );
    }

    if (_autoTextFieldValidation) {
      this.validateForm();
    }
  }

  setAmountValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AmountValueKey] = validationMessage;
  setNoteValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NoteValueKey] = validationMessage;
  setDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DateValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    amountValue = '';
    noteValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      AmountValueKey: getValidationMessage(AmountValueKey),
      NoteValueKey: getValidationMessage(NoteValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _CreateTransactionViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _CreateTransactionViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      AmountValueKey: getValidationMessage(AmountValueKey),
      NoteValueKey: getValidationMessage(NoteValueKey),
    });
