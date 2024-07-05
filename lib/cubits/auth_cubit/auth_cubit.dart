import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());

    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(
          LoginFailure(errMessage: 'No user found for that email.'),
        );
      } else if (e.code == 'wrong-password') {
        emit(
          LoginFailure(errMessage: 'Wrong password for that user.'),
        );
      }
    } catch (e) {
      emit(
        LoginFailure(errMessage: 'there was an error'),
      );
    }
  }

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(SinupLoading());

    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SinupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
          SinupFailure(errMessage: 'weak-password'),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          SinupFailure(errMessage: 'email-already-in-use'),
        );
      }
    } catch (e) {
      emit(
        SinupFailure(errMessage: 'there was an error'),
      );
    }
  }
}
