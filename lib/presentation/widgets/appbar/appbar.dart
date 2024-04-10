
import 'package:alarm_applications/core/constant/colors.dart';
import 'package:alarm_applications/core/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    super.key,
    this.title,
    this.logo = false,
    this.centerTitle = false,
    this.actions = const [],
    this.color,
    this.iconColor,
    this.actionTitle,
    this.shadow = false,
    this.hideLeading = false,
  });

  final String? title, actionTitle;
  final bool logo, shadow, centerTitle;
  final List<Widget> actions;
  final Color? color, iconColor;
  final bool hideLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: iconColor,
        size: 20,
      ),
      backgroundColor: color,
      elevation: shadow ? null : 0,
      leadingWidth: logo ? 22.w : null,
      shape: Border(
          bottom: BorderSide(
              color: shadow ? Colors.black87 : kTransparentColor, width: 0.25)),
      leading: hideLeading
          ? kNone
          : Navigator.canPop(context)
              ? IconButton(
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                )
              : null,
      titleSpacing: Navigator.canPop(context) == true ? 0 : null,
      title: title != null
          ? Text(title!, style: const TextStyle(fontWeight: FontWeight.bold))
          : null,
      centerTitle: centerTitle,
      actions: actionTitle != null
          ? [
              Center(
                child: Text(actionTitle!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              dWidth3,
            ]
          : actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
