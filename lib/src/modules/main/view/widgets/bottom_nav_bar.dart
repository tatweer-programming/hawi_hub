import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7.5.h,
      child: Stack(children: [
        Center(
          child: Container(
            color: Colors.green,
            height: 2.5.h,
            width: double.infinity,
          ),
        ),
        const Positioned.fill(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavBarItem(
                icon: Icons.home,
                label: "Home",
                isSelected: true,
              ),
              NavBarItem(
                icon: Icons.sports_football_outlined,
                label: "Play",
                isSelected: false,
              ),
              NavBarItem(
                icon: Icons.stadium,
                label: "Book",
                isSelected: false,
              ),
              NavBarItem(
                icon: Icons.menu,
                label: "More",
                isSelected: false,
              )
            ],
          ),
        )
      ]),
    );
  }
}

class NavBarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const NavBarItem({super.key, required this.icon, required this.label, required this.isSelected});

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CircleAvatar(
        radius: double.maxFinite,
        backgroundColor: widget.isSelected ? Colors.green : Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 1.h),
              Expanded(
                  child: Icon(widget.icon,
                      color: widget.isSelected ? Colors.white : Colors.grey[600])),
              FittedBox(
                fit: BoxFit.contain,
                child: Text(widget.label,
                    style: TextStyle(color: widget.isSelected ? Colors.white : Colors.grey[600])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
