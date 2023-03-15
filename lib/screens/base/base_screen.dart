import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/page_manager.dart';
import 'package:loja_virtual_pro/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import '../../commom/commom_drawer/custom_drawer.dart';
import '../../commom/commom_drawer/custom_drawer_header.dart';

final pageController = PageController();

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 4, 125, 141),
              title: const Text('Home'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 4, 125, 141),
              title: const Text('Home1'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 4, 125, 141),
              title: const Text('Home2'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 4, 125, 141),
              title: const Text('Home3'),
            ),
          ),
        ],
      ),
    );
  }
}
