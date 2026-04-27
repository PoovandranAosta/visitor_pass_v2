import 'package:flutter/material.dart';

class ModernToggleButton extends StatefulWidget {
  final String option1Label;
  final String option2Label;
  final bool initialSelection; // true = option1, false = option2
  final ValueChanged<bool>? onChanged;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final IconData? option1Icon;
  final IconData? option2Icon;
  final double minHorizontalWidth; // helps responsiveness

  const ModernToggleButton({
    super.key,
    this.option1Label = 'Visitor',
    this.option2Label = 'Attender',
    this.initialSelection = true,
    this.onChanged,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.option1Icon,
    this.option2Icon,
    this.minHorizontalWidth = 280.0,
  });

  @override
  State<ModernToggleButton> createState() => _ModernToggleButtonState();
}

class _ModernToggleButtonState extends State<ModernToggleButton>
    with SingleTickerProviderStateMixin {
  late bool _isOption1Selected;
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _isOption1Selected = widget.initialSelection;

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );

    _scaleAnimation = Tween<double>(begin: 0.96, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _toggleSelection(bool selectOption1) {
    if (_isOption1Selected == selectOption1) return;

    setState(() => _isOption1Selected = selectOption1);
    widget.onChanged?.call(selectOption1);

    _animController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Adaptive defaults (Material 3 friendly)
    final selectedBg =
        widget.selectedColor ??
            (isDark ? theme.colorScheme.primary : theme.colorScheme.primary);
    final unselectedBg =
        widget.unselectedColor ??
            (isDark
                ? theme.colorScheme.surfaceContainerHighest
                : Colors.grey.shade200);
    final selectedText =
        widget.selectedTextColor ?? theme.colorScheme.onPrimary;
    final unselectedText =
        widget.unselectedTextColor ??
            (isDark
                ? theme.colorScheme.onSurfaceVariant
                : theme.colorScheme.onSurface);

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final buttonWidth =
        (availableWidth.isFinite &&
            availableWidth > widget.minHorizontalWidth)
            ? availableWidth / 2
            : null;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: widget.minHorizontalWidth),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: unselectedBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade400),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSegment(
                    label: widget.option1Label,
                    icon: widget.option1Icon,
                    isSelected: _isOption1Selected,
                    onTap: () => _toggleSelection(true),
                    bgColor: selectedBg,
                    textColor: selectedText,
                    unselectedTextColor: unselectedText,
                    buttonWidth: buttonWidth,
                  ),
                  _buildSegment(
                    label: widget.option2Label,
                    icon: widget.option2Icon,
                    isSelected: !_isOption1Selected,
                    onTap: () => _toggleSelection(false),
                    bgColor: selectedBg,
                    textColor: selectedText,
                    unselectedTextColor: unselectedText,
                    buttonWidth: buttonWidth,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSegment({
    required String label,
    required IconData? icon,
    required bool isSelected,
    required VoidCallback onTap,
    required Color bgColor,
    required Color textColor,
    required Color unselectedTextColor,
    double? buttonWidth,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedBuilder(
          animation: _animController,
          builder: (context, child) {
            return Transform.scale(
              scale: isSelected ? _scaleAnimation.value : 1.0,
              child: Material(
                color: isSelected ? bgColor : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(16),
                  splashColor: bgColor.withOpacity(0.3),
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: buttonWidth,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(
                            icon,
                            size: 20,
                            color: isSelected ? textColor : unselectedTextColor,
                          ),
                          const SizedBox(width: 10),
                        ],
                        Flexible(
                          child: Text(
                            label,
                            style: TextStyle(
                              color: isSelected
                                  ? textColor
                                  : unselectedTextColor,
                              fontSize: 15,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                            textAlign: TextAlign.center,
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
      ),
    );
  }
}
