import 'package:e_book/config/export.dart';
import 'package:flutter/material.dart';

var myDrawer = Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      UserAccountsDrawerHeader(
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
        ),
        accountName: const Text("User Name"),
        accountEmail: const Text("user@example.com"),
        currentAccountPicture: CircleAvatar(
          backgroundImage: AssetImage(AppAssets.userProfileImage),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.home), // Adding an icon for visual appeal
        title: const Text("Home"),
        onTap: () {},
      ),
      ListTile(
        leading:
            const Icon(Icons.book), // Book icon for the Browse Books section
        title: const Text("Browse Books"),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.favorite), // Heart icon for Favorites
        title: const Text("Favorites"),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.info), // Information icon for About
        title: const Text("About"),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.settings), // Settings icon for Settings
        title: const Text("Settings"),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.phone), // Phone icon for Call
        title: const Text("Call"),
        onTap: () {},
      ),
    ],
  ),
);
