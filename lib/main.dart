import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/cubit/change_them_counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  ThemeMode currentMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: currentMode,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      title: 'Практическая работа №4',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Практическая работа №4'),
        ),
        body: BlocProvider(
          create: (context) => ChangeThemCounter(),
          child: body(
            changeMode: (currentMode) => setState(() {
              this.currentMode = currentMode;
            }),
          ),
        ),
      ),
    );
  }
}

class body extends StatefulWidget {
  body({Key? key, required this.changeMode}) : super(key: key);
  void Function(ThemeMode currentMode) changeMode;

  @override
  State<body> createState() => _BodyState();
}

class _BodyState extends State<body> {
  List<String> values = [];
  late Timer _timer;
  SharedPreferences? shared_preferences;
  int currentValue = 0;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      shared_preferences = value;
      if (shared_preferences!.containsKey("Schetchik")) {
        setState(() {
          shared_preferences = value;
          values = value.getStringList("Schetchik")!;
          currentValue = value.getInt("Znavhenie")!;
        });
      }
      if (shared_preferences!.containsKey('Tema')) {
        context
            .read<ChangeThemCounter>()
            .changeTheme(ThemeMode.values[value.getInt('Tema')!]);
      }
    });
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      context.read<ChangeThemCounter>().themtadddegr(
          Theme.of(context).brightness == Brightness.light
              ? ThemeMode.light
              : ThemeMode.dark,
          false);
    });
    super.initState();
  }

  Timer getTimer() => Timer.periodic(Duration(seconds: 5), (timer) {
        context.read<ChangeThemCounter>().themtadddegr(
            Theme.of(context).brightness == Brightness.light
                ? ThemeMode.light
                : ThemeMode.dark,
            false);
      });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              onPressed: () {
                _timer.cancel();
                _timer = getTimer();
                context.read<ChangeThemCounter>().themtadddegr(
                    Theme.of(context).brightness == Brightness.light
                        ? ThemeMode.light
                        : ThemeMode.dark,
                    false);
              },
              child: Text("Добавить значение")),
          ElevatedButton(
              onPressed: () => context.read<ChangeThemCounter>().changeTheme(
                  Theme.of(context).brightness == Brightness.light
                      ? ThemeMode.dark
                      : ThemeMode.light),
              child: Text("Изменить тему")),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              onPressed: () {
                _timer.cancel();
                _timer = getTimer();
                context.read<ChangeThemCounter>().themtadddegr(
                    Theme.of(context).brightness == Brightness.light
                        ? ThemeMode.light
                        : ThemeMode.dark,
                    true);
              },
              child: Text("Убавить значение")),
          ElevatedButton(
              onPressed: () {
                shared_preferences!.clear();
                setState(() {
                  values.clear();
                  currentValue = 0;
                  _timer.cancel();
                  _timer = getTimer();
                });
              },
              child: Text("Очистить историю")),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(child: Text("Текущее значние: ")),
        Center(child: Text(currentValue.toString()))
      ]),
      BlocListener<ChangeThemCounter, ChangeThemCounterState>(
          listener: (context, state) {
            if (state is ChangeThemCounterAddedState) {
              setState(() {
                currentValue += state.valu;
                values.add(
                    "Счётчик равен: $currentValue; тема: ${state.theme.name}");
              });

              shared_preferences?.setStringList("Schetchik", values);
              shared_preferences?.setInt("Znavhenie", currentValue);
            } else if (state is ChangeThemCounterChangedState) {
              widget.changeMode(state.theme);
              shared_preferences?.setInt("Tema", state.theme.index);
            }
          },
          child: Expanded(
            child: ListView(
              children: values.map((e) => Text(e)).toList(),
            ),
          ))
    ]);
  }
}
