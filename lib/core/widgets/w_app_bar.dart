import 'package:final_exam/core/widgets/w_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../assets/colors.dart';
import '../../assets/icons.dart';


class WAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isTitleCentered;
  final double height;
  final bool? hasBackButton;
  final Function()? onBackTap;
  const WAppBar({
    required this.title,
    this.height = 57,
    this.isTitleCentered = true,
    this.onBackTap,
    Key? key,
    this.hasBackButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 16,
      ),
      height: MediaQuery.of(context).padding.top + height,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: isTitleCentered
            ? hasBackButton == null
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          WScaleAnimation(
            onTap: () {
              if (onBackTap == null) {
                Navigator.of(context).pop();
              } else {
                onBackTap!();
              }
            },
            child: hasBackButton != null
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: SvgPicture.asset(AppIcons.arrow),
                  )
                : const SizedBox.shrink(),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: isTitleCentered ? TextAlign.center : null,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          if (isTitleCentered && hasBackButton != null)
            const SizedBox(width: 24)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
