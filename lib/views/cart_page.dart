import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../services/order_service.dart';
import '../models/cart_item_model.dart';
import 'components/success_order.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService _cartService = CartService();
  final OrderService _orderService = OrderService();
  List<CartItem> _cartItems = [];
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    List<CartItem> items = await _cartService.getCartItems();
    double total = await _cartService.getTotalPrice();
    setState(() {
      _cartItems = items;
      _totalPrice = total;
    });
  }

  Future<void> _removeFromCart(int id) async {
    await _cartService.removeFromCart(id);
    _loadCartItems();
  }

  Future<void> _updateQuantity(int id, int quantity) async {
    await _cartService.updateCartItemQuantity(id, quantity);
    _loadCartItems();
  }

  Future<void> _placeOrder() async {
    try {
      List<Map<String, dynamic>> plats = _cartItems.map((item) => {
        'Id_Plat': item.id,
        'quantite': item.quantity,
      }).toList();
      // print(plats);

      await _orderService.placeOrder(plats, _totalPrice, 'Carte de crédit');
      
      // Clear the cart after successful order placement
      await _cartService.clearCart(); // Assurez-vous d'appeler clearCart

      setState(() {
        _cartItems = [];
        _totalPrice = 0.0;
      });
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Commande passée avec succès !'),
      ));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessOrder()),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de la passation de la commande'),
      ));
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _cartItems.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      CartItem item = _cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            leading: Text('${item.quantity}x'),
                            title: Text(item.name),
                            subtitle: Text('${item.price} FCFA'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (item.quantity > 1) {
                                      _updateQuantity(item.id, item.quantity - 1);
                                    } else {
                                      _removeFromCart(item.id);
                                    }
                                  },
                                ),
                                Text('${item.quantity}', style: TextStyle(fontSize: 18)),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    _updateQuantity(item.id, item.quantity + 1);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _removeFromCart(item.id),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Total: $_totalPrice FCFA', style: TextStyle(fontSize: 24)),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _placeOrder,
                    child: Text('Checkout'),
                  ),
                ),
              ],
            ),
    );
  }
}
