part of 'change_them_counter_cubit.dart';

@immutable
abstract class ChangeThemCounterState {}

class ChangeThemCounterInitial extends ChangeThemCounterState {}

class ChangeThemCounterChangedState extends ChangeThemCounterState {
  ThemeMode theme;
  ChangeThemCounterChangedState({
    required this.theme,
  });
}

class ChangeThemCounterAddedState extends ChangeThemCounterState {
  ThemeMode theme;
  int valu;
  ChangeThemCounterAddedState({required this.theme, required this.valu});
}
