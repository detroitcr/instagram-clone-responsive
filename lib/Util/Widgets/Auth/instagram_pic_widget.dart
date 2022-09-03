

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../Assets/assets.dart';
import '../../Color/custom_color.dart';

class InstagramPictureWidget extends StatelessWidget {
  const InstagramPictureWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.InstaPic,
      color: CustomColor.primaryColor,
      height: 64,
    );
  }
}
