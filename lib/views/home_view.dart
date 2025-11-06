import 'package:cafe3awan/views/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/menu_viewmodel.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../widgets/menu_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Foods', 'Drinks'];

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<MenuViewModel>(context, listen: false).loadMenu(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menuVM = context.watch<MenuViewModel>();
    final cartVM = context.watch<CartViewModel>();

    final filteredItems = menuVM.items.where((item) {
      final matchesCategory = _selectedCategory == 'All'
          ? true
          : item.category == _selectedCategory;
      final matchesSearch = item.name.toLowerCase().contains(
        _searchQuery.trim().toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: const Text('3awan Cafe Resto'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Tombol cart
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, size: 28),
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => const CartView()));
                  },
                ),
                // Badge (angka)
                Positioned(
                  right: 6, // posisinya di pojok kanan atas
                  top: 6,
                  child: Consumer<CartViewModel>(
                    builder: (context, cartVM, _) {
                      if (cartVM.totalQty == 0) return const SizedBox();
                      return Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle, // biar bulat sempurna
                        ),
                        child: Text(
                          '${cartVM.totalQty}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => await menuVM.loadMenu(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari menu...',
                  prefixIcon: const Icon(Icons.search, color: Colors.blueGrey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, i) {
                    final category = _categories[i];
                    final selected = _selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(
                          category,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : Colors.blue.shade800,
                          ),
                        ),
                        selected: selected,
                        selectedColor: Colors.blue.shade400,
                        backgroundColor: Colors.white,
                        onSelected: (_) =>
                            setState(() => _selectedCategory = category),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: menuVM.loading
                    ? const Center(child: CircularProgressIndicator())
                    : filteredItems.isEmpty
                    ? const Center(
                        child: Text(
                          'Menu tidak ditemukan 😔',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                        itemCount: filteredItems.length,
                        itemBuilder: (context, i) {
                          final item = filteredItems[i];
                          return MenuCard(
                            menu: item,
                            onAdd: () =>
                                context.read<CartViewModel>().add(item),
                            onRemove: () => context
                                .read<CartViewModel>()
                                .removeSingle(item.id),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
