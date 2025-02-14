import 'dart:async';

import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:front_scaffold_flutter_v2/api/api.dart';
import 'package:front_scaffold_flutter_v2/domain/datasources/google_sign_in_datasource.dart';

/// [GoogleSignInDataSourceImpl] is an implementation of [GoogleSignInDataSource]
/// that handles Google Sign-In and Sign-Out operations using Firebase Authentication
/// and the Google Sign-In plugin.
///
/// This class provides methods to sign in with Google, sign out from Google,
/// retrieve the current user's token, and get the current user.

class GoogleSignInDataSourceImpl extends GoogleSignInDataSource {
  /// The [FirebaseAuth] instance used for authentication operations.
  final FirebaseAuth _auth;

  /// A [Completer] used to signal when the authentication state is initialized.
  final Completer<void> _completer = Completer();

  /// The current authenticated [User], if any.
  User? _user;

  /// Creates a [GoogleSignInDataSourceImpl] instance.
  ///
  /// Parameters:
  ///   - [_auth]: The [FirebaseAuth] instance used for authentication operations.
  GoogleSignInDataSourceImpl(this._auth) {
    // _init();
  }

  /*void _init() {
    _auth.authStateChanges().listen((User? user) {
      if (!_completer.isCompleted) {
        _completer.complete();
      }
      _user = user;
    });
  }*/

  /// Signs in the user with Google.
  ///
  /// This method initiates the Google Sign-In flow, retrieves the user's
  /// credentials, and authenticates with Firebase using those credentials.
  ///
  /// Returns:
  ///   - [ResponseState]: A [ResponseSuccess] if the sign-in is successful,
  ///     containing the user credential and ID token. A [ResponseFailed]
  ///     if the sign-in fails or is canceled.
  ///
  /// Throws:
  ///   - [DioException]: If an error occurs during the sign-in process.
  @override
  Future<ResponseState> signInGoogle() async {
    try {
      ResponseFailed responseFailed = _exception(
        null,
        message: "user_cancel_sign_in_with_google",
      );
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn().signIn().catchError(
        (error) {
          final errorMapped = error as PlatformException;
          responseFailed = _exception(error, message: errorMapped.message);
          return null;
        },
      );

      if (googleUser == null) return responseFailed;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return ResponseSuccess(
        {'userCredential': userCredential, 'idToken': googleAuth.idToken},
        200,
      );
    } catch (e) {
      return ResponseFailed(
        DioException(
          error: e,
          requestOptions: RequestOptions(path: 'google_sign_in'),
        ),
      );
    }
  }

  /// Signs out the user from Google.
  ///
  /// This method signs out the user from the Google Sign-In service.
  ///
  /// Returns:
  ///   - [ResponseState]: A [ResponseSuccess] if the sign-out is successful,
  ///     otherwise a [ResponseFailed].
  @override
  Future<ResponseState> signOutGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();
    // await googleSignIn.disconnect();

    return ResponseSuccess(null, 200);
  }

  /// Handles exceptions during the Google Sign-In process.
  ///
  /// This method creates a [ResponseFailed] with a [GoogleSignInError]
  /// containing the error details.
  ///
  /// Parameters:
  ///   - [error]: The error that occurred.
  ///   - [message]: An optional custom error message.
  ///
  /// Returns:
  ///   - [ResponseFailed]: A [ResponseFailed] with the error details.
  ResponseFailed _exception(dynamic error, {String? message}) {
    return ResponseFailed(
      GoogleSignInError(
        RequestOptions(path: "google_sign_in"),
        message: message ?? "Error al iniciar sesión con Google",
      ),
    );
  }

  /// Retrieves the current user's ID token.
  ///
  /// Returns:
  ///   - [String]: The user's ID token as a string.
  @override
  Future<String> getToken() async {
    final user = _auth.currentUser;
    final token = await user?.getIdToken(false);
    return token.toString();
  }

  /// Retrieves the current authenticated user.
  ///
  /// This method waits for the authentication state to be initialized
  /// before returning the current user.
  ///
  /// Returns:
  ///   - [User?]: The current authenticated user, or null if no user is
  ///     authenticated.
  @override
  Future<User?> get user async {
    await _completer.future;
    return _user;
  }
}