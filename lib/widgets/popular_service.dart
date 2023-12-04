import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invotask/constant.dart';

class PopularService extends StatefulWidget {
  const PopularService({super.key});

  @override
  State<PopularService> createState() => _PopularServiceState();
}

class _PopularServiceState extends State<PopularService> {
  var sevicecatlist = [
    'All',
    'Haircuts',
    'Make up',
    'Manicure',
    'Hair Straightning',
  ];
  var sevice = 'All'.obs;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  'Most Popular Service',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            LimitedBox(
              maxHeight: 60,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sevicecatlist.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        height: 40,
                        child: InkWell(
                          splashColor: const Color.fromARGB(159, 196, 227, 240),
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              sevice.value = sevicecatlist[index];
                            },
                            child: Obx(() => Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                                  label: Text(sevicecatlist[index],
                                  style: TextStyle(color: sevice.value == sevicecatlist[index]
                                          ? Colors.white
                                          : Appcolor.maincolor ),
                                  ),
                                  backgroundColor:
                                      sevice.value == sevicecatlist[index]
                                          ? Appcolor.maincolor
                                          : const Color.fromARGB(159, 196, 227, 240),
                                ))),
                      ),
                    );
                  }),
            ),
            Obx(() {
              Stream<QuerySnapshot> productStream = sevice.value != 'All'
                  ? FirebaseFirestore.instance
                      .collection('popularservice')
                      .where('servicecat', isEqualTo: sevice.value)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('popularservice')
                      .snapshots();
              return StreamBuilder<QuerySnapshot>(
                  stream: productStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      // print(snapshot.data!.docs.toString());
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                height: 140,
                               child: Row(children: [
                                   Expanded(
                                    flex: 3,
                                     child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image(image: NetworkImage(snapshot.data!.docs[index]['imageUrl']),fit: BoxFit.cover,),),
                                     ),
                                   ),
                               const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 12,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            child: 
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                            Text(
                                              
                                              snapshot.data!.docs[index]['serviceprovider'],overflow: TextOverflow.ellipsis, softWrap: true,style: const TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                            Text(snapshot.data!.docs[index]['address'],overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black54,fontSize: 12,fontWeight: FontWeight.w400),),
                                            Row(
                                              children: [
                                                Icon(Icons.pin_drop,color: Appcolor.maincolor,),
                                            Text(snapshot.data!.docs[index]['distance']+"Km",overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w500),)
                                                
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                 Icon(Icons.star_half,color: Colors.orange.shade200,),
                                            Text(snapshot.data!.docs[index]['rating']+" | "+snapshot.data!.docs[index]['reviews']+"Reviews",overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.w500),)
                                              ],
                                            )
                                                                            
                                          ]),),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: IconButton(onPressed: (){},
                                          icon: const Icon(Icons.star),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                               ]),
                              ),
                            );
                          });
                    }  else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return const Text("Loading...");
                    }
                  });
            })
          ],
        ),
      ),
    );
  }
}
