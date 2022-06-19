import 'package:intl/intl.dart';

class Calculator {
  final formatter = NumberFormat("#,###");
  double _resultNumber = 0;
  var _buffer = '0';
  var _operator = '';
  var _operatorBuffer = '';
  String? _x1 = null;
  String? _x2 = null;

  String calculateEvent(String? str) {
    if (str == '.' || isNumeric(str)) {
      if (_operator == 'equ') {
        _operator = '';
        _x1 = null;
        _x2 = null;
      }
      if (str == '.') {
        if (!_buffer.contains('.')) {
          _buffer += '.';
        }
      } else if (_buffer.length <= 15) {
        if (_buffer == '0') {
          _buffer = str!;
        } else {
          _buffer += str!;
        }
      }
    } else {
      switch (str) {
        case 'C':
          _buffer = '0';
          _operator = '';
          _x1 = null;
          _x2 = null;
          _resultNumber = 0;
          break;
        case 'CE':
          _buffer = '0';
          break;
        case 'del':
          if (_buffer.isNotEmpty) {
            _buffer = _buffer.substring(0, _buffer.length-1);
            if (_buffer.isEmpty) _buffer = '0';
          } else if (_x1 != null){
            return commaSeparate(_x1!);
          }
          break;
        case 'equ':
          if (_x1 == null) break;
          if (_buffer != '0') _x2 = _buffer;
          _x2 ??= _buffer;
          if (_operator == 'equ') _operator = _operatorBuffer;
          _resultNumber = resultOperating(_x1!, _x2!, _operator);
          _operatorBuffer = _operator;
          _operator = 'equ';
          _buffer = '0';
          _x1 = _resultNumber.toString();
          return commaSeparate(exponential(_resultNumber));
        case 'div':
        case 'mul':
        case 'min':
        case 'plu':
          if (_x1 == null) {
            _x1 = _buffer;
            _buffer = '0';
            _operator = str!;
            return commaSeparate(_x1!);
          } else if (_operator == 'equ') {
            if (_buffer == '0') _x2 = _x1;
            _x2 ??= _buffer;
            _buffer = '0';
            _operator = str!;
            return commaSeparate(_x2!);
          } else {
            if (_buffer != '0') _x2 = _buffer;
            _x2 ??= _buffer;
          }
          _buffer = '0';
          _resultNumber = resultOperating(_x1!, _x2!, _operator);
          _x1 = _resultNumber.toString();
          _operator = str!;
          return commaSeparate(exponential(_resultNumber));
      }
    }
    return commaSeparate(_buffer);
  }

  bool isNumeric(String? s) {
    if (s == null) return false;
    double? d = double.tryParse(s);
    return d != null && !d.isNaN && !d.isInfinite;
  }

  double resultOperating(String arg1, String arg2, String operator) {
    double dArg1 = double.parse(arg1);
    double dArg2 = double.parse(arg2);
    switch (operator) {
      case 'plu':
        return double.parse((dArg1 + dArg2).toStringAsFixed(15));
      case 'min':
        return double.parse((dArg1 - dArg2).toStringAsFixed(15));
      case 'mul':
        return double.parse((dArg1 * dArg2).toStringAsFixed(15));
      case 'div':
        if (dArg2 == 0.0) {
          throw Exception('0では割れません');
        }
        return double.parse((dArg1 / dArg2).toStringAsFixed(15));
    }
    throw Exception('存在しない演算です');
  }

  String exponential(double d) {
    if (d.toString().length > 17) return d.toStringAsExponential(28-d.toString().length);
    return d.toString();
  }

  String commaSeparate(String? str) {
    if (str == null) return '0';
    List<String> decimal = str.split('.');
    if (!isNumeric(decimal[0])) throw Exception('整数部分が数字じゃない');

    var retStr = str;
    if (retStr.length >= 20) retStr = double.parse(retStr).toStringAsFixed(1);
    if (decimal.length >= 2 && decimal[1]=='0') retStr = retStr.replaceFirst('.0', '');
    var separatedInt = int.parse(decimal[0]);
    retStr = retStr.replaceFirst(decimal[0], formatter.format(separatedInt));

    return retStr;
  }
}

