import 'package:firebase_auth/firebase_auth.dart';
import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fUser = FirebaseAuth.instance.currentUser;
  // create user obj based on firebase user
  AppUser _userFromFirebaseUser(User user) {
    authSubscribe(user);
    return user != null ? AppUser(uid: user.uid, email: user.email) : null;
  }

  Stream<User> get user {
    return _auth.authStateChanges();
  }

  authSubscribe(user) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
        // should replace the current page with the login page here

      } else {
        print('User is signed in!');
      }
    });
  }

  // Login with email and password
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      authSubscribe(result.user);
      final user = await Database.fetchUserData(result.user);
      return user;
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  // Signup with email and password
  Future signupWithEmailAndPassword(String email, String password, String fname,
      String lname, DateTime bday) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await Database.addUser(user.uid, email, fname, lname, bday);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  changeEmail(String newEmail, AppUser user) async {
    print('email method reached');
    try {
      await fUser.updateEmail(newEmail);
      await Database.updateEmail(newEmail, user);
      user.email = newEmail;
      return true;
    } catch (error) {
      print(error.toString);
      throw error;
    }
  }

  confirmPassword(oldPassword, AppUser user) async {
    final credential =
        EmailAuthProvider.credential(email: user.email, password: oldPassword);
    try {
      await fUser.reauthenticateWithCredential(credential);
      return true;
    } catch (error) {
      print(error.toString());
    }
    return false;
  }

  changePassword(newPassword) async {
    try {
      await fUser.updatePassword(newPassword);
      return true;
    } catch (error) {
      print(error.toString());
    }
    return false;
  }
}
