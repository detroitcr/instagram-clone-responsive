// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:insta/Util/Widgets/LayOut/global_variables.dart';
import 'package:provider/provider.dart';

import '../../../Provider/user_provider.dart';

class ResponsiveLayOut extends StatefulWidget {
  final Widget mobileScreenLayOut;
  final Widget webScreenLayOut;
  const ResponsiveLayOut({
    Key? key,
    required this.mobileScreenLayOut,
    required this.webScreenLayOut,
  }) : super(key: key);

  @override
  State<ResponsiveLayOut> createState() => _ResponsiveLayOutState();
}

class _ResponsiveLayOutState extends State<ResponsiveLayOut> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
  await  _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constarints) {
        if (constarints.maxWidth > webScreenSize) {
          return widget.webScreenLayOut;
        }
        {
          return widget.mobileScreenLayOut;
        }
      },
    );
  }
}
