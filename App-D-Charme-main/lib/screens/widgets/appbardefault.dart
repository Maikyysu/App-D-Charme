import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config.dart';
import '../../models/app_state_provider.dart';
import '../../models/theme_provider.dart'; 
import 'icons_pngjpeg.dart';

class DefaultAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool isLogin;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;

  const DefaultAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.isLogin = false,
    this.actions,
    this.leading,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  (true = escuro, false = claro)
    final isDark = ref.watch(themeProvider);

    //  definir o ícone da esquerda (Leading)
    Widget? iconLeft;

    if (isLogin) {
      iconLeft = Padding(
        padding: const EdgeInsets.all(8),
        child: AnyIcon(
          assetPath: AppConfig.iconApp,
          size: 70,
          scale: 1.5,
        ),
      );
    } else if (title == AppConfig.homeTitle) {
      
      iconLeft = IconButton(
        icon: Icon(
          isDark ? Icons.wb_sunny : Icons.nightlight_round,
          color: AppConfig.textColor, 
        ),
        onPressed: () {
          ref.read(themeProvider.notifier).toggleTheme();
        },
      );
    } else {
      iconLeft = leading; // Padrão (seta de voltar)
    }

    return AppBar(
      backgroundColor: backgroundColor ?? AppConfig.primaryColor,
      centerTitle: true,
      elevation: 0,
      
      leading: iconLeft,

     
      actions: isLogin
          ? const [
              Padding(
                padding: EdgeInsets.all(8),
                child: AnyIcon(
                  assetPath: AppConfig.iconApp,
                  size: 70,
                  scale: 1.5,
                  mirrored: true,
                ),
              ),
            ]
          : (actions ?? [
              IconButton(
                icon: Icon(Icons.logout, color: AppConfig.textColor),
                onPressed: () => ref.read(appStateProvider.notifier).logout(),
              ),
            ]),

      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppConfig.textColor,
              fontWeight: FontWeight.bold,
              fontSize: AppConfig.fontSizeTitle, 
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: TextStyle(
                
                color: AppConfig.textColor.withValues(alpha: 0.7),
                fontSize: AppConfig.fontSizeSubtitle,
              ),
            ),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}