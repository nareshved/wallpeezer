import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:wallpeezer/domain/models/register/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseHelper {
  static final firebaseAuth = FirebaseAuth.instance;
  static final firebaseFireStore = FirebaseFirestore.instance;

  static const String collectionUser = "users";
  // static const String collectionChat = "chats";
  // static const String collectionMSG = "messages";

//   static final userId = firebaseAuth.currentUser!.uid;
//   static final userId = FirebaseAuth.instance.currentUser!.uid;
  static final logOut = FirebaseAuth.instance.signOut();

  // prefs keys
  static const String prefsKey = "isLogin";

  Future<void> createUser(
      {required UserModel userModel, required String password}) async {
    /// create user in firestore
    try {
      UserCredential credential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: userModel.email, password: password);

      if (credential.user != null) {
        firebaseFireStore
            .collection(collectionUser)
            .doc(credential.user!.uid)
            .set(userModel.toDoc())
            .then(
          (value) {
            log("Create User Details Saved to toc");
          },
        ).onError(
          (error, stackTrace) {
            log("catch error in firebase onError firebaseProvider : $error");
            throw Exception("Error: $error");
          },
        );
      }
    } on FirebaseException catch (e) {
      log("Error: $e");

      if (e.code == 'weak-password') {
        throw Exception("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        throw Exception("The account already exists for that email");
      }
    } catch (e) {
      log("user not created and not saved to firebase collection and catch block executed");
    }
  }

  Future<void> authenticateUser({
    required String userEmail,
    required String userPass,
    // required BuildContext context
  }) async {
    try {
      final UserCredential credential = await firebaseAuth
          .signInWithEmailAndPassword(email: userEmail, password: userPass);

      if (credential.user != null) {
        var prefs = await SharedPreferences.getInstance();
        prefs.setString(prefsKey, credential.user!.uid);
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const HomePage(),
        //     ));
      }
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        throw Exception("Wrong password provided for that user.");
      }

      throw Exception("Wrong Email or password please check");
    } catch (e) {
      log("user login failed error ${e.toString()}");
    }
  }

  Future<void> logOutMe() async {
    // logout from prefs
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(prefsKey, "");

    // logout from firebase
    await firebaseAuth.signOut();
  }
}
