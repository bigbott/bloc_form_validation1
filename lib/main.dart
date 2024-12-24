import 'package:bloc_form_validation1/bloc/my_form_bloc.dart';
import 'package:bloc_form_validation1/view/my_form.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (_) => MyFormBloc(),
          child: const MyForm(),
        ),
      ),
    );
  }
}
