import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:management/services/localstorage_service.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    // GetIt.I<LocalStorageService>().gToken = await _firebaseAuth.currentUser!.getIdToken();
    return _firebaseAuth.currentUser;
  }

  Future<void> signInWithCredentials(String? email, String? password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }

  Future<void> signUp(
      {String? email, String? password, String? displayName}) async {
    final user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    if (displayName != null) {
      // UserInfo updateInfo = UserInfo({"displayName": displayName});
      // updateInfo.displayName = displayName;
      // await user.update(updateInfo);
    }
  }

  Future<void> signOut() async {
    Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool?> isSignedIn() async {
    final currentUser =  _firebaseAuth.currentUser;
    return (currentUser != null)? true:false;
  }

  Future<String?> getUser() async {
    return (_firebaseAuth.currentUser?.email);
  }

  Future<String?> getUserName() async {
    return (_firebaseAuth.currentUser?.displayName);
  }

  Future<String?> getUserId() async {
    var a = _firebaseAuth.currentUser;
    String? ret = a?.uid;
    return await Future.value(ret) ;
  }

  Future<String?> getUserAvatar() async {
    return ( _firebaseAuth.currentUser?.photoURL);
  }

  Future<String> getUserGoogleToken() async{
    return await _firebaseAuth.currentUser!.getIdToken();
  }
}
