import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta/Util/Assets/assets.dart';
import 'package:insta/Util/Color/custom_color.dart';
import 'package:insta/Util/Widgets/LayOut/global_variables.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
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
    //Animating page
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }
  void navigationTapped(int page){
     //Animating page
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.mobileBackGroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          Assets.InstaPic,
          color: CustomColor.primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () => navigationTapped(0),
            icon:  Icon(
              Icons.home,
              color: _page ==0 ? CustomColor.primaryColor :CustomColor.secondaryColor,
            ),
          ),
          IconButton(
              onPressed: () => navigationTapped(1),
            icon:  Icon(
              Icons.search,
              color: _page ==1 ? CustomColor.primaryColor :CustomColor.secondaryColor,
            ),
          ),
          IconButton(
              onPressed: () => navigationTapped(2),
            icon:  Icon(
              Icons.add_a_photo,
              color: _page ==2 ? CustomColor.primaryColor :CustomColor.secondaryColor,
            ),
          ),
          IconButton(
              onPressed: () => navigationTapped(3),
            icon:  Icon(
              Icons.favorite,
              color: _page ==3 ? CustomColor.primaryColor :CustomColor.secondaryColor,
            ),
          ),
          IconButton(
              onPressed: () => navigationTapped(4),
            icon:  Icon(
              Icons.person,
              color: _page ==4 ? CustomColor.primaryColor :CustomColor.secondaryColor,
            ),
          ),
        ],
      ),
      body: 
     PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: onPageChanged,
      children: homeScreenItems,
     )
    );
  }
}
