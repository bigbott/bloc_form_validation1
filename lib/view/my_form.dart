
import 'package:bloc_form_validation1/bloc/my_form_bloc.dart';
import 'package:bloc_form_validation1/widgets/email_input.dart';
import 'package:bloc_form_validation1/widgets/password_input.dart';
import 'package:bloc_form_validation1/widgets/submit_button.dart';
import 'package:bloc_form_validation1/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyFormBloc, MyFormState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showDialog<void>(
            context: context,
            builder: (_) => const SuccessDialog(),
          );
        }
        if (state.status.isInProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Submitting...')),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: const Alignment(0, -3 / 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              EmailInput(focusNode: _emailFocusNode),
              PasswordInput(focusNode: _passwordFocusNode),
              const SizedBox(height: 40,),
              const SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
