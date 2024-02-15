import 'package:flutter/cupertino.dart';

class CustomerOrderHistory extends StatefulWidget {
  const CustomerOrderHistory({super.key});

  @override
  State<CustomerOrderHistory> createState() => _CustomerOrderHistoryState();
}

class _CustomerOrderHistoryState extends State<CustomerOrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: Text("SOrder History Page"),
      ),
    );
  }
}
