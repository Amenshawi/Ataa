import 'package:firebase_auth/firebase_auth.dart';
import 'package:Ataa/appUser.dart';
import 'package:Ataa/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fUser = FirebaseAuth.instance.currentUser;
  final database = Database();
  // create user obj based on firebase user
  AppUser _userFromFirebaseUser(User user) {
    auth_subscribe(user);
    return user != null ? AppUser(uid: user.uid, email: user.email) : null;
  }

  auth_subscribe(user) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
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
      auth_subscribe(result.user);
      final user = await database.fetchUserData(result.user);
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
      await database.addUser(user.uid, fname, lname, bday);
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
    try {
      await fUser.updateEmail(newEmail);
      user.email = newEmail;
      return user;
    } catch (error) {
      print(error.toString);
      throw error;
    }
  }
}
