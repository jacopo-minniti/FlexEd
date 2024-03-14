import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

//this enum corresponds to all the possible situation a user could finds himself in, while accessing his account or creating a new profile.
enum Status {
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated,
}

//this class is manages all the logic for the authentication process.
class AuthenticationService with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user; //the User class is defined by the Firebase Auth package
  Status _status =
      Status.uninitialized; //the initial status is always uninitialized
  String? _userPassword;
  String? _userEmail;

  //defines two getters
  Status get status => _status;
  User? get user => _user;
  String? get email => _userEmail;

  AuthenticationService.instance() : _auth = FirebaseAuth.instance {
    //here is defined the stream which listen to changes for the status of the authentication.
    //This stream is connected with the Firebase Authentication Service.
    _auth.authStateChanges().listen((firebaseUser) {
      print('Firebase');
      print(firebaseUser);
      if (firebaseUser == null) {
        //if the user is null, the user is not atuhenticated
        _status = Status.unauthenticated;
      } else {
        //the user exists and the authentication token is active.
        _user = firebaseUser;
        print('users');
        print(_user);
        _status = Status.authenticated;
      }
      //notifyListeners() notify the changes to all listeners. In this case, the only listeners is the AuthenticationStream(), which automatically changes screen
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    // signIn into the Firebase Account
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    _userEmail = email;
    _userPassword = password;
    notifyListeners();
  }

  Future<void> signOut() async {
    // logOut from the current account. Automatically, the screen changes to login.
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    //register a new account in the Firebase Authentication Service and immidiatley sends an email to verify the account
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _userPassword = password;
    _userEmail = email;
    print('emaik');
    print(_userEmail);
    print(email);
    notifyListeners();
  }

  Future<void> checkEmailVerified() async {
    //to check if the email is verified is important to reload the token. Otherwise, the value of the variable emailVerified won't change even if the user clicked on the email
    if (_user!.emailVerified) {
      //if the email is verified, the authentication status passes to authenticated
      _status = Status.authenticated;
      final credentials = EmailAuthProvider.credential(
          email: _userEmail!, password: _userPassword!);
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credentials);
      notifyListeners();
    }
    await FirebaseAuth.instance.currentUser!.reload();
    _user = FirebaseAuth.instance.currentUser!;
  }

  Future<void> passwordForgotten(String email) async {
    //if the user has forgotten his password an email is sento to its email
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> reauthenticate() async {
    //reauthentication is crucial after account creation and before deleting an account.
    final credentials = EmailAuthProvider.credential(
        email: _userEmail!, password: _userPassword!);
    await FirebaseAuth.instance.currentUser!
        .reauthenticateWithCredential(credentials);
    _user = FirebaseAuth.instance.currentUser!;
    notifyListeners();
  }

  Future<void> reauthenticateWithCredentials(
      String email, String password) async {
    final credentials =
        EmailAuthProvider.credential(email: email, password: password);
    await FirebaseAuth.instance.currentUser!
        .reauthenticateWithCredential(credentials);
    _user = FirebaseAuth.instance.currentUser!;
    _userPassword = password;
    _userEmail = email;
    deleteAccount();
  }

  Future<void> deleteAccount() async {
    //delete the account from the Firebase Authentication Service
    await FirebaseAuth.instance.currentUser!.delete();
    _user = null;
    _status = Status.unauthenticated;
    _userEmail = null;
    _userPassword = null;
    notifyListeners();
    print('account Deleted');
  }
}
