import 'package:cached_network_image/cached_network_image.dart';
import 'package:cafe3awan/models/menu_model.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatefulWidget {
  final MenuItemModel menu;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const MenuCard({
    Key? key,
    required this.menu,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<Color?> _glowAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 1.25,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _glowAnim = ColorTween(
      begin: Colors.transparent,
      end: Colors.lightBlueAccent.withOpacity(0.4),
    ).animate(_controller);
  }

  void _animateAdd() async {
    await _controller.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    await _controller.reverse();
    widget.onAdd();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFFEFF9FF), Color(0xFFDFF6FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Gambar
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: AspectRatio(
              aspectRatio: 16 / 11,
              child: CachedNetworkImage(
                imageUrl: widget.menu.imageUrl,
                fit: BoxFit.cover,
                placeholder: (c, u) => Container(color: Colors.blue.shade50),
                errorWidget: (c, u, e) => Container(
                  color: Colors.blue.shade50,
                  child: const Icon(Icons.error),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.menu.name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp ${widget.menu.price.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.menu.category,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.03),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: widget.onRemove,
                            icon: const Icon(Icons.remove),
                          ),
                          const SizedBox(width: 6),
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _scaleAnim.value,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            _glowAnim.value ??
                                            Colors.transparent,
                                        blurRadius: 12,
                                        spreadRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: _animateAdd,
                                    icon: const Icon(Icons.add),
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
