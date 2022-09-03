import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta/models/user.dart' as model;
import 'package:insta/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<model.User>getUserDetails() async{
  User currentUser = auth.currentUser!;
  DocumentSnapshot snap = await firestore.collection('users').doc(currentUser.uid).get();
 return model.User.fromSnap(snap);
}
  // sign up user



  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          username.isNotEmpty ||
          file != null) {
// register the user
        UserCredential cred = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStore('ProfilePics', file, false);
        // add user to the database

      model.User user = model.User(
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          username: username,
          bio: bio,
          followers: [],
          following: [],
        );
        await firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
        //alternate
        // await firestore.collection('users').add({
        //    'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        res = "success";
      }
    }

    // on FirebaseAuthException catch(err){
    //   if(err.code == 'invalid-email'){
    //     res = 'The email is badly formated';
    //   }else if(err.code =='weak-password'){
    //     res = 'Password should be at least 6 characters';
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  // logging the user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      } else {
        res = "Please Enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// sign out
  Future<void>signOut()async{
    await auth.signOut();
  }
}
