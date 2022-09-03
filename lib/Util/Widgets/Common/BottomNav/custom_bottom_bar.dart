import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {

  int _page =0;
late PageController pageController;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  pageController = PageController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page){
    pageController.jumpToPage(page);
  }


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label:'',
          icon: Icon(
            Icons.home,
            
          ),
        ),
        BottomNavigationBarItem(
          label:'',
          icon: Icon(
            Icons.search,
          ),
        ),
        BottomNavigationBarItem(
          label:'',
          icon: Icon(
            Icons.add_circle,
          ),
        ),
        BottomNavigationBarItem(
          label:'',
          icon: Icon(
            Icons.favorite,
          ),
        ),
        BottomNavigationBarItem(
          label:'',
          icon: Icon(
            Icons.person
          ),
        ),
      ],
    );
  }
}
