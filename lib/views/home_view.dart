import 'package:cafe3awan/viewmodels/cart_viewmodel.dart';
import 'package:cafe3awan/viewmodels/menu_viewmodel.dart';
import 'package:cafe3awan/views/cart_view.dart';
import 'package:cafe3awan/views/history_view.dart';
import 'package:cafe3awan/widgets/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  void _fetchMenu() {
    Provider.of<MenuViewModel>(context, listen: false).loadMenu(
      search: _searchQuery,
      category: _selectedCategory == 'All' ? null : _selectedCategory,
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
        automaticallyImplyLeading: false,
        title: const Text('3awan Cafe Resto'),
        actions: [
          // Ganti tombol cart jadi history order
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const HistoryView()));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _fetchMenu(),
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
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                  _fetchMenu(); // fetch menu sesuai search
                },
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
                        onSelected: (_) {
                          setState(() => _selectedCategory = category);
                          _fetchMenu(); // fetch menu sesuai category
                        },
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
      // Floating cart button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const CartView()));
        },
        child: SizedBox(
          width: 56, // ukuran FAB default
          height: 56,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Center(
                child: Icon(Icons.shopping_cart, size: 28, color: Colors.white),
              ),
              Positioned(
                right: -10, // geser sedikit keluar
                top: -10, // geser sedikit keluar
                child: Consumer<CartViewModel>(
                  builder: (_, cartVM, __) {
                    if (cartVM.totalQty == 0) return const SizedBox();
                    return Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${cartVM.totalQty}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
