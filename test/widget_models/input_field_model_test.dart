import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('InputFieldModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
