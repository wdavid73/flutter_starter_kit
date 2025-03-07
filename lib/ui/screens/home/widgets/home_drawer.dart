import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_scaffold_flutter_v2/config/config.dart';
import 'package:front_scaffold_flutter_v2/ui/blocs/blocs.dart';
import 'package:front_scaffold_flutter_v2/ui/shared/shared.dart';
import 'package:go_router/go_router.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _DrawerHeader(userName: "Joe doe", userEmail: "joe@doe.com"),
          _DrawerBody(),
          AppSpacing.md,
          _LastDrawerIcon(
            icon: Icons.logout,
            text: 'Log out',
            tileColor: ColorTheme.primaryColor,
            onTap: () => context.read<AuthBloc>().logout(),
          ),
        ],
      ),
    );
  }
}

class _DrawerBody extends StatelessWidget {
  const _DrawerBody();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        radius: Radius.circular(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _DrawerItem(
                icon: Icons.widgets,
                text: "widgets",
                onTap: () {
                  context.push(RouteConstants.widgetsScreen);
                  Navigator.pop(context);
                },
              ),
              _DrawerItem(
                icon: Icons.api,
                text: "example api service implementation",
                onTap: () {
                  context.push(RouteConstants.exampleService);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final String userName;
  final String userEmail;
  const _DrawerHeader({required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: context.width,
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: ColorTheme.primaryColor,
          ),
          child: Row(
            children: [
              CircleAvatar(child: Icon(Icons.person)),
              AppSpacing.md,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    userName,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: ColorTheme.white,
                    ),
                  ),
                  Text(
                    userEmail,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: ColorTheme.white,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.more_vert_rounded,
                color: ColorTheme.white,
              ),
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  final Color? tileColor;
  const _DrawerItem({
    required this.icon,
    required this.text,
    this.onTap,
    this.tileColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: tileColor,
      leading: Icon(icon),
      title: Text(text, style: context.textTheme.labelLarge),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: onTap,
    );
  }
}

class _LastDrawerIcon extends _DrawerItem {
  const _LastDrawerIcon({
    required super.icon,
    required super.text,
    super.onTap,
    super.tileColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: ColorTheme.white),
      tileColor: tileColor,
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: ColorTheme.white),
      title: Text(
        text,
        style: context.textTheme.labelLarge?.copyWith(
          color: ColorTheme.white,
        ),
      ),
      onTap: onTap,
    );
  }
}