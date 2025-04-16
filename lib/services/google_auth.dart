

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {



  // List of Scopes
  static const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];


  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    scopes: scopes,
  );


  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<String?> getCurrentUser() async {
    return _googleSignIn.currentUser?.email;
  }


}