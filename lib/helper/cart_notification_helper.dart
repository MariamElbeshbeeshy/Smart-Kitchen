import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_kitchen/helper/constants.dart';
import 'package:smart_kitchen/views/profile/wishlist_view.dart';

OverlayEntry? _currentOverlayEntry;

void showCartNotification(BuildContext context, String productName, {required VoidCallback onViewPressed}) {
  // Remove existing overlay first to reset the display
  _currentOverlayEntry?.remove();
  _currentOverlayEntry = null;

  final overlayState = Overlay.of(context);
  
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (context) => CartNotificationOverlay(
      message: "$productName added to your cart",
      icon: Icons.check_circle,
      onViewPressed: onViewPressed,
      onDismiss: () {
        if (_currentOverlayEntry == entry) {
          entry.remove();
          _currentOverlayEntry = null;
        }
      },
    ),
  );

  _currentOverlayEntry = entry;
  overlayState.insert(entry);
}

void showFavoriteNotification(BuildContext context, String productName, bool isAdded) {
  // Remove existing overlay first to reset the display
  _currentOverlayEntry?.remove();
  _currentOverlayEntry = null;

  final overlayState = Overlay.of(context);
  
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (context) => CartNotificationOverlay(
      message: isAdded ? "$productName added to WishList" : "$productName removed from WishList",
      icon: isAdded ? Icons.favorite : Icons.favorite_border,
      onViewPressed: isAdded ? () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const WishListView()),
        );
      } : null,
      onDismiss: () {
        if (_currentOverlayEntry == entry) {
          entry.remove();
          _currentOverlayEntry = null;
        }
      },
    ),
  );

  _currentOverlayEntry = entry;
  overlayState.insert(entry);
}

class CartNotificationOverlay extends StatefulWidget {
  final String message;
  final IconData icon;
  final VoidCallback? onViewPressed;
  final VoidCallback onDismiss;

  const CartNotificationOverlay({
    super.key,
    required this.message,
    required this.icon,
    this.onViewPressed,
    required this.onDismiss,
  });

  @override
  State<CartNotificationOverlay> createState() => _CartNotificationOverlayState();
}

class _CartNotificationOverlayState extends State<CartNotificationOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.8),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _controller.forward();

    // Auto dismiss strictly after 3 seconds (as requested)
    _dismissTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  void _dismiss() async {
    _dismissTimer?.cancel();
    if (mounted) {
      await _controller.reverse();
      widget.onDismiss();
    }
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 95.0, left: 16.0, right: 16.0), // Positioned above the BottomNavigationBar
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(widget.icon, color: Colors.white, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (widget.onViewPressed != null) ...[
                      const SizedBox(width: 8),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          widget.onViewPressed!();
                          _dismiss();
                        },
                        child: const Text(
                          "View",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
