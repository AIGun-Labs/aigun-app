import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money2/money2.dart';
import './currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit()
      : super(CurrencyState(selectedCurrency: CommonCurrencies().usd));
}
