import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrolinfinitos/core/theme/app_colors.dart';


import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int selectedIndex = 0; // 👈 Empieza con "Regístrate" seleccionado

  final List<String> menuItems = [
    'Regístrate',
    'Inicia sesión',
    'Empresas',
    'Tipo de cambio',
    'Artículos',
    'Ayuda',
    'Nosotros',
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF6B4EFF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔘 Lista de opciones
              for (int i = 0; i < menuItems.length; i++) ...[
                _menuItem(
                  menuItems[i],
                  isSelected: selectedIndex == i,
                  onTap: () {
                    setState(() {
                      selectedIndex = i;
                    });
                  },
                ),
                const SizedBox(height: 14),
              ],

              const Spacer(),

              // Versión al final
              Text(
                'v1.1.1',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Ítem del menú
  Widget _menuItem(String title,
      {required bool isSelected, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(color: Colors.white, width: 2)
              : null,
          borderRadius: BorderRadius.circular(40),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight:
            isSelected ? FontWeight.bold : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
