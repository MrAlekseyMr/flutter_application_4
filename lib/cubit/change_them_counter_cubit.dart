import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'change_them_counter_state.dart';

class ChangeThemCounter extends Cubit<ChangeThemCounterState> {
  ChangeThemCounter() : super(ChangeThemCounterInitial());

  void changeTheme(ThemeMode themeMode) {
    emit(ChangeThemCounterChangedState(theme: themeMode));
  }

  void themtadddegr(ThemeMode themeMode, bool isDescreasing) {
    var currentValue = themeMode == ThemeMode.light ? 1 : 2;
    if (isDescreasing) {
      currentValue = currentValue * -1;
    }
    emit(ChangeThemCounterAddedState(theme: themeMode, valu: currentValue));
  }
}
