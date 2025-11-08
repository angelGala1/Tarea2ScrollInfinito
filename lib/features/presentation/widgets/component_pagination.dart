import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    // 🔥 CALCULAR UNA SOLA VEZ
    final pageButtons = _calculatePageButtons();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            // Botón anterior
            _buildNavigationButton(
              icon: Icons.chevron_left,
              enabled: currentPage > 1,
              onTap: () => onPageChanged(currentPage - 1),
            ),

            // 🔥 USAR LA LISTA PRECALCULADA
            ...pageButtons,

            // Botón siguiente
            _buildNavigationButton(
              icon: Icons.chevron_right,
              enabled: currentPage < totalPages,
              onTap: () => onPageChanged(currentPage + 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return InkWell( // 🔥 Cambiado de GestureDetector a InkWell (más rápido)
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: enabled ? const Color(0xFF4A2FCF) : Colors.grey.shade300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: enabled ? const Color(0xFF4A2FCF) : Colors.grey,
          size: 20,
        ),
      ),
    );
  }

  // 🔥 PRECALCULAR todo de una vez
  List<Widget> _calculatePageButtons() {
    final List<Widget> buttons = [];

    if (totalPages <= 7) {
      // Mostrar todas las páginas
      for (int i = 1; i <= totalPages; i++) {
        buttons.add(_buildPageButton(i));
      }
      return buttons;
    }

    // Página 1 siempre visible
    buttons.add(_buildPageButton(1));

    if (currentPage <= 4) {
      // Inicio: 1 2 3 4 ... última
      for (int i = 2; i <= 3; i++) {
        buttons.add(_buildPageButton(i));
      }
      buttons.add(_buildDots());
      buttons.add(_buildPageButton(totalPages));
    } else if (currentPage >= totalPages - 3) {
      // Final: 1 ... (últimas 4 páginas)
      buttons.add(_buildDots());
      for (int i = totalPages - 3; i <= totalPages; i++) {
        buttons.add(_buildPageButton(i));
      }
    } else {
      // Medio: 1 ... actual-1 actual actual+1 ... última
      buttons.add(_buildDots());
      buttons.add(_buildPageButton(currentPage - 1));
      buttons.add(_buildPageButton(currentPage));
      buttons.add(_buildPageButton(currentPage + 1));
      buttons.add(_buildDots());
      buttons.add(_buildPageButton(totalPages));
    }

    return buttons;
  }

  Widget _buildPageButton(int page) {
    final isActive = page == currentPage;

    return InkWell( // 🔥 Más rápido que GestureDetector
      onTap: () => onPageChanged(page),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF4A2FCF) : Colors.white,
          border: Border.all(
            color: isActive ? const Color(0xFF4A2FCF) : Colors.grey.shade300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '$page',
            style: TextStyle(
              color: isActive ? Colors.white : const Color(0xFF1A1D3D),
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDots() {
    return const SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: Text(
          '···',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}


