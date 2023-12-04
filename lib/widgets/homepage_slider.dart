import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:invotask/constant.dart';

class OfferSlider extends StatefulWidget {
  const OfferSlider({super.key});

  @override
  State<OfferSlider> createState() => _OfferSliderState();
}

class _OfferSliderState extends State<OfferSlider> {
  var _currpagenum = 0.0;
  PageController pageController = PageController(viewportFraction: 0.95);
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currpagenum = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('offercollection')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {
          if (snapshot.hasData) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: 200,
                  minWidth: MediaQuery.of(context).size.width * 0.85),
              // color: AppColor.maincolor,
              child: PageView.builder(
                itemCount: 3,
                controller: pageController,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              padding: const EdgeInsets.all(16),
                              width: MediaQuery.of(context).size.width*0.95,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: NetworkImage(
                                  snapshot.data!.docs[index]['offerimage'],
                                  ),
                                  fit:BoxFit.cover
                            ),
                          ),
                        )),
                        Positioned(
                          bottom: 20,
                          left: 100,
                          right: 100,
                          child: DotsIndicator(
                            dotsCount: 3,
                            position: _currpagenum.toInt(),
                            decorator: DotsDecorator(
                              
                              spacing:const EdgeInsets.all(2),
                              color: Colors.white,
                              activeColor:  Appcolor.maincolor,
                              size: const Size.square(7),
                              activeSize: const Size(18.0, 5.0),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox();
        });
  }
}

//   Widget _itemContainer(
//     int index,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8.0),
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//             minHeight: 105, minWidth: MediaQuery.of(context).size.width * 0.95),
//         child: Container(
//           padding: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(
//                 width: 1,
//                 color: const Color(0xFFE7E9EB),
//               ),
//               borderRadius: BorderRadius.circular(10)),
//           child: Expanded(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                           width: 2,
//                           color: const Color.fromRGBO(98, 156, 182, 1))),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 const Expanded(
//                   child: Text(
//                     'Which IITs do not conduct interviews for MTech admission in Civil Engineering Specializations?',
//                     style: TextStyle(
//                       color: Color(0xFF08232F),
//                       fontSize: 16,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w500,
//                     ),
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                     softWrap: true,
//                     textScaleFactor: 1,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


 

    