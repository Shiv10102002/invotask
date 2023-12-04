import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:invotask/constant.dart';

class HomePageCategory extends StatefulWidget {
  const HomePageCategory({super.key});

  @override
  State<HomePageCategory> createState() => _HomePageCategoryState();
}

class _HomePageCategoryState extends State<HomePageCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             const  Text(
                "Category",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text("View All",
                      style: TextStyle(
                          color: Appcolor.maincolor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)))
            ],
          ),
        ),
       const Categorywidget(),
      ],
    );
  }
}

class Categorywidget extends StatelessWidget {
  const Categorywidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('categories')
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                   mainAxisSpacing: 10,
                   crossAxisSpacing: 10,
                   mainAxisExtent: 120
                    ),
                itemBuilder: (context, index) {
                  return Column(children: [Container(
                  
                    decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                                    
                      borderRadius: BorderRadius.circular(10)
                    ),
                    height: 90,
                    width: 90,
                    padding:const EdgeInsets.all(20),
                    child: Image(image: NetworkImage(snapshot.data!.docs[index]['imageUrl'],),height: 75,width: 75,fit: BoxFit.cover,)),
                                        const  SizedBox(
                    height: 5,
                  ),
                   Text(
                    snapshot.data!.docs[index]['catname'],
                    style:const TextStyle(color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  )]);
                });
          }
          return const SizedBox();
        });
  }
}
