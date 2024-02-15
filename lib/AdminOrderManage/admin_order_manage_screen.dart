import 'package:flutter/cupertino.dart';

class AdminOrderManageScreen extends StatefulWidget {
  const AdminOrderManageScreen({super.key});

  @override
  State<AdminOrderManageScreen> createState() => _AdminOrderManageScreenState();
}

class _AdminOrderManageScreenState extends State<AdminOrderManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: Text("Cart Screen"),
      ),
    );
  }
}
