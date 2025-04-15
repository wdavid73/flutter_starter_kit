import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:front_scaffold_flutter_v2/ui/blocs/blocs.dart';
import 'package:front_scaffold_flutter_v2/ui/shared/inputs/inputs.dart';
import 'package:front_scaffold_flutter_v2/utils/utils.dart';

part 'register_form_state.dart';

class RegisterFormCubit extends Cubit<RegisterFormState> {
  final AuthBloc authBloc;

  RegisterFormCubit({required this.authBloc})
      : super(const RegisterFormState());

  void onSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    emit(state.copyWith(isPosting: true));

    authBloc.register(
      email: state.email.value,
      password: state.password.value,
      fullName: state.fullname.value,
    );

    // Wait for the authentication status to change
    await waitForState(
      stream: authBloc.stream,
      condition: (state) =>
          state.authStatus == AuthStatus.authenticated ||
          state.authStatus == AuthStatus.notAuthenticated,
    );

    emit(state.copyWith(isPosting: false));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value: value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate(
        [email, state.fullname, state.password],
      ),
    ));
  }

  void fullNameChanged(String value) {
    final fullname = Text.dirty(value: value);
    emit(state.copyWith(
      fullname: fullname,
      isValid: Formz.validate(
        [fullname, state.email, state.password],
      ),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value: value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate(
        [password, state.email, state.fullname],
      ),
    ));
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword = ConfirmPassword.dirty(
      value: value,
      password: state.password.value,
    );
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      isValid: Formz.validate(
        [confirmPassword, state.password, state.email, state.fullname],
      ),
    ));
  }

  void toggleObscure() {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  void _touchEveryField() {
    final email = Email.dirty(value: state.email.value);
    final password = Password.dirty(value: state.password.value);
    final fullname = Text.dirty(value: state.fullname.value);
    final confirmPassword = ConfirmPassword.dirty(
      password: state.password.value,
      value: state.confirmPassword.value,
    );

    emit(state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      fullname: fullname,
      confirmPassword: confirmPassword,
      isValid: Formz.validate([email, password, fullname, confirmPassword]),
    ));
  }
}
