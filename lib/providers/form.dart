import 'package:riverpod/riverpod.dart';

final formProvider =
    StateNotifierProvider<FormController, FormStateModel>((ref) {
  return FormController();
});

class FormStateModel {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;

  FormStateModel({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
  });

  FormStateModel copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
  }) {
    return FormStateModel(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError,
      passwordError: passwordError,
    );
  }

  bool get isValid => emailError == null && passwordError == null;
}

class FormController extends StateNotifier<FormStateModel> {
  FormController() : super(FormStateModel());

  void updateEmail(String email) {
    state = state.copyWith(email: email, emailError: null);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password, passwordError: null);
  }

  bool validate() {
    String? emailError;
    String? passwordError;

    if (state.email.trim().isEmpty) {
      emailError = 'Email tidak boleh kosong';
    } else if (!state.email.contains('@')) {
      emailError = 'Format email tidak valid';
    }

    if (state.password.isEmpty) {
      passwordError = 'Password tidak boleh kosong';
    } else if (state.password.length < 6) {
      passwordError = 'Password minimal 6 karakter';
    }

    state = state.copyWith(
      emailError: emailError,
      passwordError: passwordError,
    );

    return emailError == null && passwordError == null;
  }
}
