part of 'register_form_cubit.dart';

class RegisterFormState extends Equatable {
  final Email email;

  final Password password;

  final ConfirmPassword confirmPassword;

  final Text fullname;

  final bool isValid;

  final bool isFormPosted;

  final bool isPosting;

  final bool isObscure;

  const RegisterFormState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.fullname = const Text.pure(),
    this.isValid = false,
    this.isFormPosted = false,
    this.isPosting = false,
    this.isObscure = true,
  });

  @override
  List<Object> get props => [
        email,
        password,
        confirmPassword,
        fullname,
        isValid,
        isFormPosted,
        isPosting,
        isObscure,
      ];

  RegisterFormState copyWith({
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    Text? fullname,
    bool? isValid,
    bool? isFormPosted,
    bool? isPosting,
    bool? isObscure,
  }) =>
      RegisterFormState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        fullname: fullname ?? this.fullname,
        isValid: isValid ?? this.isValid,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isPosting: isPosting ?? this.isPosting,
        isObscure: isObscure ?? this.isObscure,
      );
}
