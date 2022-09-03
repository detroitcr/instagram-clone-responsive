import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta/Util/Assets/assets.dart';
import 'package:insta/Util/Color/custom_color.dart';
import 'package:insta/Util/Widgets/LayOut/global_variables.dart';
import 'package:insta/Util/Widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final responseWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: responseWidth > webScreenSize
          ? CustomColor.webBackGroundColor
          : CustomColor.mobileBackGroundColor,
      appBar: responseWidth > webScreenSize
          ? null
          : AppBar(
              backgroundColor: responseWidth > webScreenSize
                  ? CustomColor.webBackGroundColor
                  : CustomColor.mobileBackGroundColor,
              centerTitle: false,
              title: SvgPicture.asset(
                Assets.InstaPic,
                color: CustomColor.primaryColor,
                height: 32,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.messenger_outline,
                    color: CustomColor.primaryColor,
                  ),
                ),
              ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal:
                    responseWidth > webScreenSize ? responseWidth * 0.3 : 0,
                vertical: responseWidth > webScreenSize ? 15 : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
