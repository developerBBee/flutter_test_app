import 'package:flutter_test_app/calculator/calculator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'calculator_test.mocks.dart';

@GenerateMocks([Calculator])
void main() {
  final calc = Calculator();
  final mockCalc = MockCalculator();

  const inf = 1.0/0.0;
  const nan = (1.0/0.0) / inf;
  var testList = [inf.toString(), nan.toString(), '.', '00', '0', '-1', '0.'];
  var expectList = [false, false, false, true, true, true, true];
  for (int i=0; i<testList.length; i++) {
    test('Testing calculator isNumber method. ${testList[i]}', () {
      print(i);
      expect(calc.isNumeric(testList[i]), expectList[i]);
    });
  }

  test('Testing Mock calculator isNumber method.', () {
    when(mockCalc.isNumeric('a')).thenReturn(true);
    verifyNever(mockCalc.isNumeric('a'));
    expect(mockCalc.isNumeric('a'), true);
    verify(mockCalc.isNumeric('a'));
    expect(mockCalc.isNumeric('a'), true);

    when(mockCalc.isNumeric('b')).thenReturn(false);
    verifyNever(mockCalc.isNumeric('b'));
    expect(mockCalc.isNumeric('b'), false);
    verify(mockCalc.isNumeric('b'));
    expect(mockCalc.isNumeric('b'), false);
  });
}