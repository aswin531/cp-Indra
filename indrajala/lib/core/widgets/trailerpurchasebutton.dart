import 'package:flutter/material.dart';
import 'dart:async';

class TrailerPurchaseButton extends StatefulWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final IconData? icon;
  final String text;
  final TextStyle textStyle;
  final Color iconColor;
  final VoidCallback onPressed;
  final bool isPremium;

  const TrailerPurchaseButton({
    super.key,
    required this.primaryColor,
    required this.secondaryColor,
    this.icon,
    required this.text,
    required this.textStyle,
    required this.iconColor,
    required this.onPressed,
    this.isPremium = false,
  });

  @override
  State<TrailerPurchaseButton> createState() => _TrailerPurchaseButtonState();
}

class _TrailerPurchaseButtonState extends State<TrailerPurchaseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;
  Timer? _shimmerTimer;
  double _shimmerPosition = -1.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start shimmer animation if premium
    if (widget.isPremium) {
      _startShimmerAnimation();
    }
  }

  void _startShimmerAnimation() {
    _shimmerTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _shimmerPosition += 0.02;
        if (_shimmerPosition > 2.0) {
          _shimmerPosition = -1.0;
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _shimmerTimer?.cancel();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onTapCancel: _handleTapCancel,
              child: Container(
                height: 50, // Ensures a consistent button height
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.primaryColor,
                      widget.secondaryColor,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12), // Softer corners
                  boxShadow: [
                    BoxShadow(
                      color: widget.primaryColor.withOpacity(0.4),
                      blurRadius: _isPressed ? 4 : 8,
                      offset: _isPressed ? const Offset(0, 2) : const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: widget.onPressed,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget.icon != null) ...[
                                  Icon(
                                    widget.icon,
                                    size: 24,
                                    color: widget.iconColor,
                                  ),
                                  const SizedBox(width: 10),
                                ],
                                Text(
                                  widget.text,
                                  style: widget.textStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (widget.isPremium)
                        Positioned.fill(
                          child: ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                begin: Alignment(
                                  _shimmerPosition - 1,
                                  _shimmerPosition - 1,
                                ),
                                end: Alignment(
                                  _shimmerPosition,
                                  _shimmerPosition,
                                ),
                                colors: const [
                                  Colors.transparent,
                                  Colors.white30,
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.5, 1.0],
                              ).createShader(bounds);
                            },
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
