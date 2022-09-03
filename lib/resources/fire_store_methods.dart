import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta/models/posts.dart';
import 'package:insta/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

// upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "some error occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStore('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );
      firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occured";
    try {
      // if the likes list contains the user uid, we need to remove it// if the //likes list contains the user uid, we need to remove it
      if (likes.contains(uid)) {
        await firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        //else we need to add uid to the like array
        await firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

//Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occured";
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        // if the likes list contains the user uid, we need to remove it
        await firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'text': text,
          'name': name,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
      } else {
        print('text is emplty');
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// delete Post(),
  Future<String> deletePost(String postId) async {
    String res = "Some error occcured";
    try {
      await firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// follow User(),
  Future<void> followuser(
    String uid,
    String followId,
  ) async{
    try {
DocumentSnapshot snap = await firestore.collection('users').doc(uid).get();
List following = (snap.data()! as dynamic)['following'];
if(following.contains(followId)){
  // update the value of followers in followId
  await firestore.collection('users').doc(followId).update({
    'followers':FieldValue.arrayRemove([uid])
  });
  await firestore.collection('users').doc(uid).update({
    'following':FieldValue.arrayRemove([followId])
  });
}else{
  await firestore.collection('users').doc(followId).update({
    'followers':FieldValue.arrayUnion([uid])
  });
   await firestore.collection('users').doc(uid).update({
    'following':FieldValue.arrayUnion([followId])
  });
}


    } catch (e) {
      print(
        e.toString(),
      );
    }
  }
}
