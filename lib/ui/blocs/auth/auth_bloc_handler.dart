part of 'auth_bloc.dart';

/// [AuthBlocHandler] is a mixin that provides handlers for authentication-related
/// events in the [AuthBloc].
///
/// This mixin contains methods to handle login, check authentication status,
/// logout, register, and Google Sign-In events. It also includes a utility
/// method to clear the authentication token and emit a not-authenticated state.
mixin AuthBlocHandler on Bloc<AuthEvent, AuthState> {
  /// Handles the [LoginEvent].
  ///
  /// This method performs the login process using the provided email and
  /// password. It updates the [AuthState] to `checking` while the login is in
  /// progress. If the login is successful, it stores the authentication token
  /// and updates the [AuthState] to `authenticated`. If the login fails, it
  /// clears the token and updates the [AuthState] to `notAuthenticated`.
  ///
  /// Parameters:
  ///   - [event]: The [LoginEvent] containing the email and password.
  ///   - [emit]: The [Emitter] used to emit new [AuthState]s.
  Future<void> handlerLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.checking));

    final response = await (this as AuthBloc).useCase.login(
          event.email,
          event.password,
        );

    if (response is ResponseFailed) {
      await _clearTokenAndEmitNotAuthenticated(
        emit,
        response.error!.message.toString(),
      );
      return;
    }

    AuthResponseModel authResponse = response.data;

    await (this as AuthBloc).keyValueStorageService.setKeyValue(
          'token',
          authResponse.token,
        );
    emit(state.copyWith(
      authStatus: AuthStatus.authenticated,
      user: authResponse.user,
      errorMessage: '',
    ));
  }

  /// Handles the [CheckAuthStatusEvent].
  ///
  /// This method checks the authentication status by verifying the presence of
  /// a stored token. If a token is found, it attempts to validate it. If the
  /// token is valid, it updates the [AuthState] to `authenticated`. If no
  /// token is found or the token is invalid, it clears the token and updates
  /// the [AuthState] to `notAuthenticated`.
  ///
  /// Parameters:
  ///   - [event]: The [CheckAuthStatusEvent].
  ///   - [emit]: The [Emitter] used to emit new [AuthState]s.
  Future<void> handlerCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final String? token =
        await (this as AuthBloc).keyValueStorageService.getValue('token');

    if (token == null) {
      await _clearTokenAndEmitNotAuthenticated(emit);
      return;
    }

    try {
      final response = await (this as AuthBloc).useCase.checkAuthStatus(token);
      if (response is ResponseFailed) {
        await _clearTokenAndEmitNotAuthenticated(emit);
        return;
      }

      // * this is part is particular of api service used
      final authResponse = response.data as AuthResponseModel;
      await (this as AuthBloc)
          .keyValueStorageService
          .setKeyValue('token', authResponse.token);
      emit(state.copyWith(
        authStatus: AuthStatus.authenticated,
        user: authResponse.user,
        errorMessage: '',
      ));
    } catch (e) {
      await _clearTokenAndEmitNotAuthenticated(emit);
    }
  }

  /// Handles the [LogoutEvent].
  ///
  /// This method performs the logout process by removing the stored
  /// authentication token and signing out from Google. It then updates the
  /// [AuthState] to `notAuthenticated`.
  ///
  /// Parameters:
  ///   - [event]: The [LogoutEvent].
  ///   - [emit]: The [Emitter] used to emit new [AuthState]s.
  Future<void> handlerLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await (this as AuthBloc).keyValueStorageService.removeKey('token');
    await (this as AuthBloc).googleAuthUseCase.signOutGoogle();
    emit(state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      errorMessage: '',
      user: null,
    ));
  }

  /// Handles the [RegisterEvent].
  ///
  /// This method is currently a placeholder for the registration process.
  /// It prints a debug message when called.
  ///
  /// Parameters:
  ///   - [event]: The [RegisterEvent].
  ///   - [emit]: The [Emitter] used to emit new [AuthState]s.
  Future<void> handlerRegister(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (kDebugMode) {
      print("handler register");
    }
  }

  /// Handles the [GoogleSignInEvent].
  ///
  /// This method performs the Google Sign-In process. It updates the
  /// [AuthState] to `checking` and sets `googleSignInLoading` to `true` while
  /// the sign-in is in progress. If the sign-in is successful, it stores the
  /// authentication token and updates the [AuthState] to `authenticated`. If
  /// the sign-in fails, it clears the token and updates the [AuthState] to
  /// `notAuthenticated`.
  ///
  /// Parameters:
  ///   - [event]: The [GoogleSignInEvent].
  ///   - [emit]: The [Emitter] used to emit new [AuthState]s.
  Future<void> handlerGoogleSignIn(
    GoogleSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      authStatus: AuthStatus.checking,
      googleSignInLoading: true,
    ));

    final response =
        await (this as AuthBloc).googleAuthUseCase.signInWithGoogle();

    if (response is ResponseFailed) {
      await _clearTokenAndEmitNotAuthenticated(
        emit,
        response.error!.message.toString(),
      );
      return;
    }

    /// Token by google auth provider
    // final token = await (this as AuthBloc).googleAuthUseCase.getToken();

    // final AdditionalUserInfo userInfo = response.data.additionalUserInfo;
    // final UserCredential user = response.data['userCredential'];
    final String? idToken = response.data['idToken'];

    /// From this point on you can modify the google login interaction as you see fit.

    /**
     * We are going to send the google idToken and uid to the api so that it returns an access token to the app.
     */

    if (idToken == null) {
      await _clearTokenAndEmitNotAuthenticated(emit, "invalid_token");
      return;
    }

    final authResponse = await (this as AuthBloc).useCase.googleSignIn(idToken);
    if (authResponse is ResponseFailed) {
      await _clearTokenAndEmitNotAuthenticated(
        emit,
        authResponse.error!.message.toString(),
      );
      return;
    }

    final authData = authResponse.data as AuthResponseModel;
    await (this as AuthBloc).keyValueStorageService.setKeyValue(
          'token',
          authData.token,
        );

    emit(state.copyWith(
      authStatus: AuthStatus.authenticated,
      user: authData.user,
      errorMessage: '',
      googleSignInLoading: false,
    ));
  }

  /// Clears the authentication token and emits a not-authenticated state.
  ///
  /// This method removes the stored authentication token and updates the
  /// [AuthState] to `notAuthenticated`. It can also set an optional error
  /// message.
  ///
  /// Parameters:
  ///   - [emit]: The [Emitter] used to emit new [AuthState]s.
  ///   - [message]: An optional error message to be included in the
  ///     [AuthState].
  Future<void> _clearTokenAndEmitNotAuthenticated(Emitter<AuthState> emit,
      [String message = '']) async {
    await (this as AuthBloc).keyValueStorageService.removeKey('token');
    emit(
      state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        errorMessage: message,
        user: null,
        googleSignInLoading: false,
      ),
    );
  }
}