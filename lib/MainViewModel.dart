import 'package:flutter/cupertino.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:money_formatter/money_formatter.dart';
import 'dart:math';
import 'package:lottie/lottie.dart';

class MainViewModel extends ChangeNotifier {
  int _savedAmount = 0;
  int _timeHorizon = 10;
  bool _invest = true;
  Currency _currency = CurrencyService().findByCode('DKK')!;
  double _interestRate = 7.0;
  bool _animation = false;

  TextEditingController controller = TextEditingController();

  int get savedAmount => _savedAmount;
  int get timeHorizon => _timeHorizon;
  bool get invest => _invest;
  String get currencySymbol => _currency.symbol;
  String get currencyCode => _currency.code;
  double get interestRate => _interestRate;
  bool get animation => _animation;

  void addSavings(int value) {
    _savedAmount = _savedAmount + value;
    _animation = true;
    notifyListeners();
  }

  void setTimeHorizon(int value) {
    _timeHorizon = value;
    notifyListeners();
  }

  void setInvest(bool value) {
    _invest = value;
    notifyListeners();
  }

  void setCurrency(Currency value) {
    _currency = value;
    notifyListeners();
  }

  void setInterestRate(double value) {
    _interestRate = value;
    notifyListeners();
  }

  void switchInvest() {
    _invest = !_invest;
    notifyListeners();
  }

  int getInvestmentReturn() {
    double interestRate = _interestRate / 100;
    double interest =
        _savedAmount.toDouble() * pow(1 + interestRate, _timeHorizon);
    return interest.toInt();
  }

  String getFormattedCurrency(int value) {
    MoneyFormatter fmf = MoneyFormatter(
        amount: value.toDouble(),
        settings: MoneyFormatterSettings(
            symbol: _currency.symbol,
            thousandSeparator: _currency.thousandsSeparator,
            decimalSeparator: _currency.decimalSeparator,
            symbolAndNumberSeparator:
                _currency.spaceBetweenAmountAndSymbol ? ' ' : '',
            fractionDigits: _currency.decimalDigits,
            compactFormatType: CompactFormatType.short));
    // return fmf.output.compactNonSymbol;
    if (_currency.symbolOnLeft) {
      return fmf.output.compactSymbolOnLeft;
    } else {
      return fmf.output.compactSymbolOnRight;
    }
  }
}
