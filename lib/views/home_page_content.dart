import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import '../services/categorie_service.dart';
import '../services/plat_service.dart';
import '../services/cart_service.dart';
import '../models/categorie_model.dart';
import '../models/plat_model.dart';
import '../models/cart_item_model.dart';
import 'components/profile_icon.dart';
import 'constants.dart';
import '../services/session_timeout_manager.dart';
import 'components/detail_page.dart';
import 'widgets/categorie_list.dart';
import 'cart_page.dart';

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final PlatService _platService = PlatService();
  final CategorieService _categorieService = CategorieService();
  final CartService _cartService = CartService();
  final SessionTimeoutManager _sessionTimeoutManager = SessionTimeoutManager();
  final TextEditingController _searchController = TextEditingController();
  
  String _userName = '';
  int _cartItemCount = 0;

  List<Category> _categories = [];
  List<Dish> _promotions = [];
  List<Dish> _popularDishes = [];
  List<Dish> _searchResults = [];
  
  @override
  void initState() {
    super.initState();
    _sessionTimeoutManager.initialize(context);
    _fetchData();
    _loadUserData();
    _loadCartItemCount();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _sessionTimeoutManager.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      final categories = await _categorieService.fetchCategories();
      final promotions = await _platService.fetchPromotions();
      final popularDishes = await _platService.fetchPopularDishes();

      setState(() {
        _categories = categories;
        _promotions = promotions;
        _popularDishes = popularDishes;
        _searchResults = popularDishes;
      });
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  Future<void> _loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? clientData = prefs.getString('client');
      if (clientData != null) {
        Map<String, dynamic> client = jsonDecode(clientData);
        setState(() {
          _userName = client['Prenom'];
        });
      }
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  Future<void> _loadCartItemCount() async {
    try {
      int itemCount = await _cartService.getCartItemCount();
      setState(() {
        _cartItemCount = itemCount;
      });
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  Future<void> _refresh() async {
    await _fetchData();
    await _loadUserData();
    await _loadCartItemCount();
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _searchResults = _popularDishes.where((dish) {
        return dish.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _addToCart(Dish dish) async {
    final CartItem cartItem = CartItem(
      id: dish.id,
      name: dish.name,
      price: dish.price,
    );
    await _cartService.addToCart(cartItem);
    await _loadCartItemCount();  // Refresh cart item count
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _sessionTimeoutManager.userInteractionDetected(context),
      onPanDown: (_) => _sessionTimeoutManager.userInteractionDetected(context),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Color.fromARGB(255, 0, 165, 6),
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ProfileIcon(nom: _userName),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text(_userName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications, color: Color(primaryColor)),
              onPressed: () {
                // Handle notifications
              },
            ),
            Stack(
              children: [
                IconButton(
                  icon: Icon(
                    _cartItemCount > 0 ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                    color: Color(primaryColor),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                  },
                ),
                if (_cartItemCount > 0)
                  Positioned(
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '$_cartItemCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_categories.isEmpty || _popularDishes.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Container(
                    padding: EdgeInsets.all(10),
                    child: Image.asset('assets/icons/search-64.png', width: 14, height: 14),
                  ),
                  hintText: 'Search dishes',
                  filled: true,
                  hintStyle: TextStyle(color: Color(0xFF6A6969)),
                  fillColor: Color(0xFFEDEDED),
                  contentPadding: EdgeInsets.all(16.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      // Navigate to all categories
                    },
                    child: Text('See All',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(primaryColor),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 8),
              CategoryGrid(categories: _categories),
              SizedBox(height: 15),
              Text('Promotions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _promotions.isNotEmpty ? Column(
                children: [
                  SizedBox(height: 6),
                  CarouselSlider(
                    options: CarouselOptions(height: 200.0),
                    items: _promotions.map((dish) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Image.network("${baseUrl}/photos-${dish.id}", width: double.infinity, height: 100, fit: BoxFit.cover),
                                    Positioned(
                                      top: 8,
                                      left: 8,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color: const Color(primaryColor),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        child: Text('Promo', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(dish.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                            Text('${dish.price} FCFA', style: TextStyle(fontSize: 14, color: Colors.green)),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.favorite_border,
                                            color: Color(favoriteColor),
                                          ),
                                          onPressed: () {
                                            // Handle add to favorites
                                          },
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add_shopping_cart,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () => _addToCart(dish),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                ]
              ) : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2,
                    ),
                    Center(child: Text('Aucune Promotion')),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text('Popular Dishes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 92, 195, 66),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 0.1, top: 0.1, left: 0, right: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(Plat: _searchResults[index]))),
                        leading: Image.network("${baseUrl}/photos-${_searchResults[index].id}"),
                        title: Text(_searchResults[index].name),
                        subtitle: Text('${_searchResults[index].price} FCFA'),
                        trailing: IconButton(
                          icon: Icon(Icons.add_shopping_cart, color: Colors.blue),
                          onPressed: () => _addToCart(_searchResults[index]),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    // Navigate to more dishes
                  },
                  child: Text('+ Voir Plus',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
