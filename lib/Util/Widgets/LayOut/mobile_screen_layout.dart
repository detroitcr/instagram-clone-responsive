import 'package:flutter/material.dart';
import 'package:insta/Util/Widgets/LayOut/global_variables.dart';

import '../../Color/custom_color.dart';

class MobileScreenLayOut extends StatefulWidget {
  const MobileScreenLayOut({Key? key}) : super(key: key);
  @override
  State<MobileScreenLayOut> createState() => _MobileScreenLayOutState();
}

class _MobileScreenLayOutState extends State<MobileScreenLayOut> {
  int _page = 0;
   PageController pageController = PageController();

  @override
  void initState() {
   
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {

    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  // String username = "";
  // @override
  // void initState() {
  //   super.initState();
  //   getUsername();
  // }

  // void getUsername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //       setState(() {
  //         username = (snap.data() as Map<String,dynamic>)['username'];
  //       });

  // }
  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
//model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged:onPageChanged ,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: navigationTapped,
        backgroundColor: CustomColor.mobileBackGroundColor,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home,
              color: _page == 0
                  ? CustomColor.primaryColor
                  : CustomColor.secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.search,
              color: _page == 1
                  ? CustomColor.primaryColor
                  : CustomColor.secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.add_circle,
              color: _page == 2
                  ? CustomColor.primaryColor
                  : CustomColor.secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.favorite,
              color: _page == 3
                  ? CustomColor.primaryColor
                  : CustomColor.secondaryColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.person,
              color: _page == 4
                  ? CustomColor.primaryColor
                  : CustomColor.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
