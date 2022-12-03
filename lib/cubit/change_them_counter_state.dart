part of 'change_them_counter_cubit.dart';

@immutable
abstract class ChangeThemCounterState {}

class ChangeThemCounterInitial extends ChangeThemCounterState {}

class ThemeChanged extends ChangeThemCounterState {
  ThemeMode nowTheme;
  ThemeChanged({
    required this.nowTheme,
  });
}

class ThemeCounted extends ChangeThemCounterState {
  late int add;
  ThemeMode nowTheme;
  ThemeCounted({
    required this.nowTheme,
  }) {
    if (nowTheme == ThemeMode.dark)
      add = 2;
    else
      add = 1;
  }
}
