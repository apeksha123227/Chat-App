import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Utils/Utils.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: Utils.serverClientId,
  );

  Future<User?> login() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
