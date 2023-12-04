import 'package:flutter/material.dart';
import 'package:invotask/widgets/hompage_category_container.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              child: Text(
                "Category",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 20,
            ),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 16),
               child: Categorywidget(),
             )
          ]),
        ),
      ),
    );
  }
}
