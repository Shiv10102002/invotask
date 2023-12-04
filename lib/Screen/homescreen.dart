import 'package:flutter/material.dart';
import 'package:invotask/widgets/homepage_feature_slider.dart';
import 'package:invotask/widgets/homepage_slider.dart';
import 'package:invotask/widgets/hompage_category_container.dart';
import 'package:invotask/widgets/popular_service.dart';
import 'package:invotask/widgets/searchcontainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
         
          leading: SizedBox(
            height: 78,
            width: 78,
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 48,
              width: 48,
              decoration:const BoxDecoration(
               
                 shape: BoxShape.circle
              )
             ,child: const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(48)),
              child: Image(image: AssetImage('assets/hubby.png'),fit: BoxFit.cover,)),),
          ),
          title:const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Good Morning",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black45),),
              Text("Shiv Kumar",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black54),),
      
            ],
          ),
          centerTitle: false,
          actions: [
          IconButton(onPressed: (){}, icon:const Icon(Icons.notifications_outlined),
          ),
          IconButton(onPressed: (){}, icon: const Icon(Icons.favorite))
        ]),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              child: searchContainer()),
            const OfferSlider(),
            const Featureslider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: HomePageCategory(),
            ),
            const SizedBox(
              height: 20,
            ),
            const PopularService()
            
          ])),
      ),
    );
  }
}
