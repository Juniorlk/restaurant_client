import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/cart_item_model.dart';

class CartService {
  static const String _cartKey = 'cart';

  Future<void> addToCart(CartItem item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<CartItem> cart = await getCartItems();
    int index = cart.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      cart[index].quantity += item.quantity;
    } else {
      cart.add(item);
    }
    prefs.setString(_cartKey, jsonEncode(cart));
  }

  Future<void> removeFromCart(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<CartItem> cart = await getCartItems();
    cart.removeWhere((item) => item.id == id);
    prefs.setString(_cartKey, jsonEncode(cart));
  }

  Future<void> updateCartItemQuantity(int id, int quantity) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<CartItem> cart = await getCartItems();
    int index = cart.indexWhere((element) => element.id == id);
    if (index != -1) {
      cart[index].quantity = quantity;
      prefs.setString(_cartKey, jsonEncode(cart));
    }
  }

  Future<List<CartItem>> getCartItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartData = prefs.getString(_cartKey);
    if (cartData != null) {
      List<dynamic> jsonList = jsonDecode(cartData);
      // print(jsonList);
      return jsonList.map((json) => CartItem.fromJson(json)).toList();
    }
    return [];
  }

  // Future<double> getTotalPrice() async {
  //   List<CartItem> cart = await getCartItems();
  //   return cart.fold(0.0, (total, item) => total + (item.price * item.quantity));
  //   // return 100.0;
  // }

  Future<double> getTotalPrice() async {
    List<CartItem> cart = await getCartItems();
    double total = 0.0;
    for (var item in cart) {
      total += await item.price * item.quantity;
    }
    return total;
  }

    Future<void> clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart'); // Supposons que 'cartItems' est la clé utilisée pour stocker les éléments du panier
  }

  Future<int> getCartItemCount() async {
    List<CartItem> cart = await getCartItems();
    return cart.length;
  }
}
