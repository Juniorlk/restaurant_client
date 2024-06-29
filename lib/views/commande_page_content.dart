import 'package:flutter/material.dart';
import 'package:foodapp/services/commande_service.dart';
import 'package:foodapp/views/widgets/order_item.dart';

class CommandePage extends StatefulWidget {
  const CommandePage({super.key});

  @override
  State<CommandePage> createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.all(6),
            color: Color(0xFF277548),
            padding: EdgeInsets.all(3),
            child: Image.asset('assets/logo.png', width: 14, height: 14)
          ),
          actions: [
            IconButton(
              icon: Image.asset('assets/icons/search-64.png', width: 30, height: 30),
              onPressed: () {},
            ),
          ],
          title: Text('Commandes'),
          bottom: TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Actif'),
              Tab(text: 'Terminé'),
              Tab(text: 'Annulé'),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
        body: TabBarView(
          children: [
            OrdersList(status: 0),
            OrdersList(status: 1),
            OrdersList(status: 2),
          ],
        ),
      ),
    );
  }
}

class OrdersList extends StatefulWidget {
  final int status;

  OrdersList({required this.status});

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  late Future<List> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _fetchOrders();

  }

  Future<List> _fetchOrders() async {
    return await CommandeService.fetchOrders(widget.status);
  }

  Future<void> _refreshOrders() async {
    setState(() {
      _ordersFuture = _fetchOrders();

    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshOrders,
      child: FutureBuilder<List>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var order = snapshot.data![index];
                return OrderItem(
                  idCommande: order['Id_Commande'],
                  // itemCount: order['itemCount'],
                  // distance: order['distance'],
                  price: order['Prix'],
                  status: order['Statut'],
                );
              },
            );
          }
        },
      ),
    );
  }
}
