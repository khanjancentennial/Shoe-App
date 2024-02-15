import 'package:flutter/cupertino.dart';

class CustomerSearchPage extends StatefulWidget {
  const CustomerSearchPage({super.key});

  @override
  State<CustomerSearchPage> createState() => _CustomerSearchPageState();
}

class _CustomerSearchPageState extends State<CustomerSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: Text("Search Page"),
      ),
    );
  }
}
