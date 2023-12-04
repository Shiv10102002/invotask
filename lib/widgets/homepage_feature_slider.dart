

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:invotask/constant.dart';

class Featureslider extends StatefulWidget {
  const Featureslider({super.key});

  @override
  State<Featureslider> createState() => _FeaturesliderState();
}

class _FeaturesliderState extends State<Featureslider> {
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('featurecollection')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Featured Searvices",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          DotsIndicator(
                            decorator: DotsDecorator(
                              activeColor: Appcolor.maincolor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              spacing: const EdgeInsets.all(2),
                               activeSize: const Size(18.0, 5.0),
                                size: const Size.square(5),
                                
                            ),
                            dotsCount: snapshot.data!.docs.length,
                            position: 1,
                          )
                        ],
                      ),
                    ),
                   const SizedBox(
                      height: 16,
                    ),
                    Container(
                      constraints:const BoxConstraints(minHeight: 110,maxHeight: 150),
                      padding: const EdgeInsets.only(left: 16),
                      child: GridView.builder(
                        
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                            const  SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 10,
                                  mainAxisExtent: 110),
                          itemBuilder: (context, index) {
                           
                            return Container(
                              margin:const  EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade200,
                                        offset:const  Offset(1, 1),
                                        spreadRadius: 1)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 90,
                                    width: 110,
                                    child: ClipRRect(
                                      borderRadius:const  BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)),
                                      child: Image(
                                        image: NetworkImage(snapshot
                                            .data!.docs[index]['imageUrl']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 8),
                                      child: Text(
                                        snapshot.data!.docs[index]['name'],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          ((1-(int.parse(snapshot.data!.docs[index]['discount'])/100))*int.parse(snapshot.data!.docs[index]['price'])).toString(),
                                          style:const  TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12),
                                        ),
                                       const  SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]['price'],
                                          style:const  TextStyle(
                                            decoration: TextDecoration.lineThrough,

                                              color: Colors.black45,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }
              return const  SizedBox();
            }),
      ],
    );
  }
}
