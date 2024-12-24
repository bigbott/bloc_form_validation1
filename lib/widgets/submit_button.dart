
import 'package:bloc_form_validation1/bloc/my_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isValid = context.select((MyFormBloc bloc) => bloc.state.isValid);
    return ElevatedButton(
      onPressed: isValid
          ? () => context.read<MyFormBloc>().add(FormSubmitted())
          : null,
      child: const Text('Submit'),
    );
  }
}