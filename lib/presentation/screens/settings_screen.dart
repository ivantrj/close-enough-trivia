import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/core/providers/theme_provider.dart';
import 'package:flutter_template/widgets/settings_tile.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // bool _isPremium = false;
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    // _checkProStatus();
    _getAppVersion();
  }

  String getDeviceInfo() {
    return 'Platform: ${Platform.operatingSystem}\n'
        'Version: ${Platform.operatingSystemVersion}';
  }

  // Future<void> _checkProStatus() async {
  //   final customerInfo = await Purchases.getCustomerInfo();
  //   setState(() {
  //     _isPremium = customerInfo.entitlements.active.containsKey('premium');
  //   });
  // }

  Future<void> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // _buildProfileTile(),
          const SizedBox(height: 24),
          _buildSettingsGroup(
            [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Appearance',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, _) => CupertinoSlidingSegmentedControl<ThemeMode>(
                        groupValue: themeProvider.themeMode,
                        padding: const EdgeInsets.all(4),
                        backgroundColor: colorScheme.surfaceVariant,
                        thumbColor: colorScheme.primary,
                        children: {
                          ThemeMode.light: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              'Light',
                              style: TextStyle(
                                color: themeProvider.themeMode == ThemeMode.light
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          ThemeMode.dark: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              'Dark',
                              style: TextStyle(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          ThemeMode.system: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              'System',
                              style: TextStyle(
                                color: themeProvider.themeMode == ThemeMode.system
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        },
                        onValueChanged: (value) {
                          if (value != null) {
                            themeProvider.setThemeMode(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSettingsGroup([
            const ModernSettingsTile(
              title: 'Something',
              icon: FontAwesomeIcons.fire,
              showDivider: false,
            ),
          ]),
          const SizedBox(height: 24),
          _buildSettingsGroup([
            ModernSettingsTile(
              title: 'Follow on X',
              icon: FontAwesomeIcons.xTwitter,
              onTap: () async {
                const url = 'https://twitter.com/ivan_trj';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
            ),
            ModernSettingsTile(
              title: 'Rate the App',
              icon: FontAwesomeIcons.star,
              onTap: () async {
                const url = '';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
            ),
            ModernSettingsTile(
              title: 'Send Feedback',
              icon: FontAwesomeIcons.comment,
              showDivider: false,
              onTap: () async {
                const String email = 'hello.ivantrj@gmail.com';
                const String subject = 'Feedback';
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: email,
                  query: 'subject=$subject',
                );
                if (await canLaunchUrl(emailUri)) {
                  await launchUrl(emailUri);
                }
              },
            ),
          ]),
          const SizedBox(height: 24),
          _buildSettingsGroup([
            ModernSettingsTile(
              title: 'Website',
              icon: FontAwesomeIcons.globe,
              onTap: () async {
                const url = 'https://readmate.netlify.app';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
            ),
            ModernSettingsTile(
              title: 'Privacy Policy',
              icon: FontAwesomeIcons.shield,
              onTap: () async {
                const url = 'https://readmate.netlify.app/privacy';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
            ),
            ModernSettingsTile(
              title: 'Terms of Service',
              icon: FontAwesomeIcons.fileContract,
              showDivider: false,
              onTap: () async {
                const url = 'https://readmate.netlify.app/tos';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
            ),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'Version $_appVersion',
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.6),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}
