import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myshop_admin/provider/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:myshop_admin/Model/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;

  OrderDetailScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Carousel at the top
              buildCarousel(order),

              const SizedBox(height: 16.0),

              // Order Details (Info Cards)
              buildInfoCard(
                  Icons.shopping_cart, 'Order Title', order.productTitle),
              buildInfoCard(Icons.calendar_today, 'Order Date',
                  DateFormat('yyyy-MM-dd').format(order.orderDate)),
              buildInfoCard(
                  Icons.attach_money, 'Total Price', '\$${order.price}'),
              buildInfoCard(Icons.info_outline, 'Order Status', order.status),

              // User Details (Info Cards)
              buildInfoCard(Icons.person, 'User Name', order.customername),
              buildInfoCard(
                  Icons.location_on, 'User Address', order.customeraddress),
              buildInfoCard(Icons.phone, 'User Contact', order.customerphone),

              const SizedBox(height: 16.0),

              // Status update buttons
              const Text(
                'Update Order Status:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 10.0,
                children: [
                  buildStatusButton(context, 'Pending', orderProvider),
                  buildStatusButton(context, 'Approved', orderProvider),
                  buildStatusButton(context, 'Processing', orderProvider),
                  buildStatusButton(context, 'Shipped', orderProvider),
                  buildStatusButton(context, 'Delivered', orderProvider),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build info cards
  Widget buildInfoCard(IconData icon, String label, String value) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.purple, size: 28),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  // Helper method to build status buttons
  Widget buildStatusButton(
      BuildContext context, String status, OrderProvider orderProvider) {
    return ElevatedButton(
      onPressed: () async {
        await orderProvider.updateOrderStatus(order.orderId, status);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order status updated to $status')),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: getStatusColor(status), // Button color based on status
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(status,
          style: const TextStyle(fontSize: 16, color: Colors.white)),
    );
  }

  // Helper method to build the image carousel
  Widget buildCarousel(OrderModel order) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.easeInOut,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: order.images.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  // Helper method to get status color
  Color getStatusColor(String? status) {
    switch (status) {
      case 'Delivered':
        return Colors.purple;
      case 'Processing':
        return Colors.purple;
      case 'Shipped':
        return Colors.purple;
      case 'Pending':
        return Colors.purple;
      case 'Approved':
        return Colors.purple;
      default:
        return Colors.purple;
    }
  }
}
