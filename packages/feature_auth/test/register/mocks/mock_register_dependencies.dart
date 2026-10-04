import 'package:mocktail/mocktail.dart';
import 'package:platform_session/platform_session.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

class FakeAuthState extends Fake implements AuthState {}
