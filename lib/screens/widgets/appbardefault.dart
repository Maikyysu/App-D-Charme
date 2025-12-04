import 'package:flutter/material.dart';
import '/config.dart';
import 'icons_pngjpeg.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool isLogin;
  final List<Widget>? actions;
  final Widget? leading;

  const DefaultAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.isLogin = false,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppConfig.primaryColor,
      centerTitle: true,

      leading: isLogin
          ? Padding(
              padding: const EdgeInsets.all(8),
              child: AnyIcon(
                assetPath: AppConfig.iconApp,
                size: 70,
                scale: 1.3,
              ),
            )
          : leading,

      actions: isLogin
          ? const [
              Padding(
                padding: EdgeInsets.all(8),
                child: AnyIcon(
                  assetPath: AppConfig.iconApp,
                  size: 70,
                  scale: 1.3,
                  mirrored: true,
                ),
              ),
            ]
          : actions,

      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 12);
}
