import 'package:flutter/material.dart';

class ExpandableCartFAB extends StatefulWidget {
  final int cartItemCount;
  final VoidCallback? onCartTap;

  const ExpandableCartFAB({
    super.key,
    required this.cartItemCount,
    this.onCartTap,
  });

  @override
  State<ExpandableCartFAB> createState() => _ExpandableCartFABState();
}

class _ExpandableCartFABState extends State<ExpandableCartFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _widthAnimation = Tween<double>(
      begin: 56.0, // FAB default size
      end: 120.0, // Expanded width
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    ));
  }

  @override
  void didUpdateWidget(ExpandableCartFAB oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cartItemCount > 0 && oldWidget.cartItemCount == 0) {
      _animationController.forward();
    } else if (widget.cartItemCount == 0 && oldWidget.cartItemCount > 0) {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: _widthAnimation.value,
          height: 56.0,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(28.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(28.0),
              onTap: widget.onCartTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 24,
                    ),
                    if (widget.cartItemCount > 0) ...[
                      const SizedBox(width: 8),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          '${widget.cartItemCount} item${widget.cartItemCount == 1 ? '' : 's'}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
