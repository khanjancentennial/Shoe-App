import 'package:flutter/cupertino.dart';

class AdminProductManageScreen extends StatefulWidget {
  const AdminProductManageScreen({super.key});

  @override
  State<AdminProductManageScreen> createState() => _AdminProductManageScreenState();
}

class _AdminProductManageScreenState extends State<AdminProductManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: Text("Admin Product Manage Screen"),
      ),
    );
  }
}
