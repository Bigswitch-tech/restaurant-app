import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/app_colors.dart';
import 'package:food_delivery_app/Components/mytabs.dart';
import 'package:food_delivery_app/Tabs/all_tab.dart';
import 'package:food_delivery_app/Tabs/drink_tab.dart';
import 'package:food_delivery_app/Tabs/food_tab.dart';
import 'package:food_delivery_app/Tabs/snacks_tab.dart';
import '../Components/my_icons.dart';

class Home2Page extends StatefulWidget {


  const Home2Page ({super.key});

  @override
  State<Home2Page> createState() => _Home2PageState();
}

class _Home2PageState extends State<Home2Page> {

    //myTabs
  List <Widget> myTabs = [


    //All
    MyTabs(iconPath: Icons.person, textT: 'All'),
    //Snacks tab
    MyTabs(iconPath: Icons.person, textT: 'Snacks'),
     //Food tab
    MyTabs(iconPath: Icons.person, textT: 'Food'),
      //Drinks tab
    MyTabs(iconPath: Icons.person, textT: 'Drinks'),
      
  ];

    final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,

      child: Scaffold(
////////////////////////
            appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 130, leadingWidth: 70,
        backgroundColor: AppColors.chocolate,
        leading: Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 30),
              child: CircleAvatar(backgroundColor: Colors.grey.shade100, radius: 40, child: Icon(Icons.person, size: 40, color: Colors.black,),),
            ),
          ],
        ),

         
        title: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Hello,', style: TextStyle( fontSize: 18, color: AppColors.white),),
                  SizedBox(width: 6,),
                  Text('Faizzah', style: TextStyle(fontWeight: .bold, fontSize: 20, color: AppColors.white),),
                ],
              ),
              SizedBox(height: 6,),
               Text('happyapp@gmail.com', style: TextStyle( fontSize: 16, color: AppColors.white),),
            ],
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 60, right: 5),
            child: MyIcons(boxShape: BoxShape.circle, 
            addColor: Colors.grey.shade100,
            padding:EdgeInsetsGeometry.all(8), 
            child: Icon(Icons.notifications_outlined),),
          )
        ],
            
          ),
////////////////////////
        body: SafeArea(
            child: Column(
              children: [
               const SizedBox(height: 10,),
      
                ////SEARCH AREA
      
               Padding(
                 padding: const EdgeInsets.only(left: 15,bottom: 10,right: 15),
                 child: TextFormField(
                          
                      controller: searchController,
                      onSaved: (value) {
                        searchController.text = value!;
                      },
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'input search';
                        }return null;
                 
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.latte,
                 
                        prefixIcon: IconButton( onPressed: () {  }, 
                        icon:Icon(Icons.search_outlined)),
                 
                 
                        hintText: 'Search for food...',
                 
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(style: BorderStyle.none),
                        ),
                 
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 0.5),
                        ),
                      )),
               ),
               
               //tab bar
              TabBar( 
                indicatorColor: AppColors.mochaGrey,
                tabs: myTabs),
                //tab bar view

               Expanded(
                 child: TabBarView(
                  children: [
                  AllTab(),
                  SnacksTab(),
                  FoodTab(),
                  DrinkTab(),
                 
                 ]),
               )
               
               ]),
              ),
             ),
    );
       
  }
}