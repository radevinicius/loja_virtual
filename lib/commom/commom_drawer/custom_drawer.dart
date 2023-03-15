import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/commom/commom_drawer/custom_drawer_header.dart';
import 'package:loja_virtual_pro/commom/commom_drawer/drawer_tile.dart';
import 'package:loja_virtual_pro/screens/base/base_screen.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter),
            ),
          ),
          ListView(
            controller: pageController,
            children: <Widget>[
              CustomDrawerHeader(),
              Divider(),
              DrawerTile(
                iconData: Icons.home,
                title: 'Início',
                page: 0,
              ),
              DrawerTile(
                iconData: Icons.list,
                title: 'Produtos',
                page: 1,
              ),
              DrawerTile(
                iconData: Icons.playlist_add_check,
                title: 'Meus Pedidos',
                page: 2,
              ),
              DrawerTile(
                iconData: Icons.location_on,
                title: 'Lojas',
                page: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
