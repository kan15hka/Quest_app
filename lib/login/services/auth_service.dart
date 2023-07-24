import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../pages/add_email.dart';

class AuthService {
  //Google Sign in
  signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //obtain auth details from request

    AddEmail(gUser!.email.toString(), gUser.displayName.toString());
    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    //finally, let's sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
