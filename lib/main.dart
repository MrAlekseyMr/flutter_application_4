import 'package:flutter/material.dart';
import 'package:flutter_application_4/cubit/change_them_counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ThemeMode.system;
    return BlocProvider(
      create: (ctx) => ChangeThemCounter(),
      child: Builder(builder: (context) {
        return BlocBuilder<ChangeThemCounter, ChangeThemCounterState>(
          builder: (context, state) {
            if (state is ThemeChanged) {
              themeMode = state.nowTheme;
            }
            return MaterialApp(
              theme: ThemeData(
                brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
              ),
              themeMode: themeMode,
              title: 'Material App',
              home: Scaffold(
                appBar: AppBar(
                  title: Text('Практическая работа 4'),
                ),
                body: body(),
              ),
            );
          },
        );
      }),
    );
  }
}

class body extends StatefulWidget {
  body({
    Key? key,
  }) : super(key: key);

  @override
  State<body> createState() => _bodyState();
}

// ElevatedButton(
//     onPressed: () => context.read<ChangeThemCounter>().countheme(
//         Theme.of(context).brightness == Brightness.light
//             ? ThemeMode.light
//             : ThemeMode.dark),
//     child: Text("Прибавить значение")),
class _bodyState extends State<body> {
  int nowValue = 0;
  List<String> nowValues = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () => context.read<ChangeThemCounter>().changeTheme(
                    Theme.of(context).brightness == Brightness.light
                        ? ThemeMode.dark
                        : ThemeMode.light),
                child: Text("Изменить тему")),
            ElevatedButton(
                onPressed: () {
                  context.read<ChangeThemCounter>().countheme(
                      Theme.of(context).brightness == Brightness.light
                          ? ThemeMode.light
                          : ThemeMode.dark,
                      true);
                },
                child: Text("Прибавить значение")),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.read<ChangeThemCounter>().countheme(
                      Theme.of(context).brightness == Brightness.light
                          ? ThemeMode.light
                          : ThemeMode.dark,
                      false);
                },
                child: Text("Убавить значение")),
          ],
        ),
        BlocListener<ChangeThemCounter, ChangeThemCounterState>(
            listener: (context, state) {
              if (state is ThemeCounted) {
                setState(() {
                  nowValue += state.add;
                  nowValues.add(
                      "Тема - ${state.nowTheme.name}; счётчик = ${nowValue.toString()}");
                });
              }
            },
            child: Expanded(
              child: ListView(
                children: nowValues.map((e) => Text(e)).toList(),
              ),
            ))
      ],
    );
  }
}
