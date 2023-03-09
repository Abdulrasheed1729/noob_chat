import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:noob_chat/cubits/cubits.dart';
import 'package:noob_chat/repositories/repositories.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SignUpCubit(
          context.read<AuthRepository>(),
          context.read<StorageRepository>(),
          context.read<UserRepository>(),
        ),
        child: const SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Sign up Failure'),
              ),
            );
        }
      },
      child: Align(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  'Create User Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16),
                _UploadImageButton(),
                SizedBox(height: 16),
                _EmailInput(),
                SizedBox(height: 8),
                _NameInput(),
                SizedBox(height: 8),
                _PasswordInput(),
                SizedBox(height: 8),
                _ConfirmPasswordInput(),
                SizedBox(height: 8),
                _SignUpButton(),
                // SizedBox(height: 8),
                // _LoginToAccountButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UploadImageButton extends StatelessWidget {
  const _UploadImageButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.imageUrl != current.imageUrl,
      builder: (context, state) {
        return GestureDetector(
          onTap: () => context.read<SignUpCubit>().uploadImage(),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: state.imageUrl.value.isEmpty
                    ? const AssetImage(
                        'assets/person.png',
                      )
                    : NetworkImage(state.imageUrl.value) as ImageProvider,
              ),
            ),
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.photo_camera_outlined,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
          decoration: InputDecoration(
            labelText: 'Name',
            helperText: '',
            filled: true,
            fillColor: Colors.white54,
            constraints: const BoxConstraints(
              minHeight: 50,
              maxHeight: 70,
            ),
            errorText: state.name.invalid ? 'invalid name' : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: '',
            filled: true,
            fillColor: Colors.white54,
            constraints: const BoxConstraints(
              minHeight: 50,
              maxHeight: 70,
            ),
            errorText: state.email.invalid ? 'invalid email' : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: '',
            filled: true,
            fillColor: Colors.white54,
            constraints: const BoxConstraints(
              minHeight: 50,
              maxHeight: 70,
            ),
            errorText: state.password.invalid ? 'invalid password' : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.confirmedPassword != current.confirmedPassword ||
          previous.password != current.password,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (confirmedPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmedPassword),
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            helperText: '',
            filled: true,
            fillColor: Colors.white54,
            constraints: const BoxConstraints(
              minHeight: 50,
              maxHeight: 70,
            ),
            errorText: state.confirmedPassword.invalid
                ? 'password do not match'
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator(
                color: Colors.indigo,
              )
            : ElevatedButton(
                onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUp()
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.indigo,
                ),
                child: const Text(
                  'REGISTER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
      },
    );
  }
}
