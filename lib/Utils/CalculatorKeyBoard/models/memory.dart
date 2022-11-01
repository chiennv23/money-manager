import 'package:coresystem/Components/widgets/SnackBar.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:math_expressions/math_expressions.dart';

class Memory {
  String _equation = '0';
  String _result = '0';
  String expression = '';

  void applyCommand(String command) {
    if (command == 'AC') {
      _allClear();
    } else if (command == '⌫') {
      _deleteEquation();
    } else if (_equation.startsWith('÷') ||
        _equation.startsWith('×') ||
        _equation.startsWith('-') ||
        _equation.startsWith('+')) {
      _equation = '0';
    } else if (command == '=') {
      _finalResult();
    } else {
      _typing(command);
    }
    // print(_equation);
  }

  void setStringResult(String vl) {
    _equation = vl.replaceAll('.', '');
    _result = vl.replaceAll('.', '');
  }

  void allClearInputted() {
    _equation = '0';
    _result = '0';
  }

  void _allClear() {
    _equation = '0';
    _result = '0';
  }

  void _deleteEquation() {
    _equation = _equation.substring(0, _equation.length - 1);
    if (_equation == '') {
      _equation = '0';
    }
  }

  void _finalResult() {
    expression = _equation;
    expression = expression.replaceAll('×', '*');
    expression = expression.replaceAll('÷', '/');

    try {
      final Parser parser = Parser();
      final Expression exp = parser.parse(expression);

      final ContextModel cm = ContextModel();
      _result = '${exp.evaluate(EvaluationType.REAL, cm)}';

      _equation = _result.split('.')[0];
    } catch (e) {
      SnackBarCore.warning(isBottom: true, title: 'Syntax error, try again.');
      _equation = '0';
      _result = '0';
    }
  }

  void _typing(String command) {
    // print(command);
    if (_equation == '0') {
      _equation = command;
    } else {
      _equation += command;
    }
  }

  bool get moneyHasSign => _equation.contains(RegExp(r'[÷|×\-+]'));

  String get equation {
    return moneyHasSign
        ? _equation
        : '${double.parse(_equation).wToMoney(0)}'.replaceAll('.', ',');
  }

  String get result {
    return double.parse(_result).wToMoney(0);
  }
}
