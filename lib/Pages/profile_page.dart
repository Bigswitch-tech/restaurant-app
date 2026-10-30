import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/TextsSizes/bigtexts.dart';
import 'package:food_delivery_app/Components/TextsSizes/mediumtext.dart';
import 'package:food_delivery_app/Components/TextsSizes/smalltexts.dart';
import 'package:food_delivery_app/Components/app_colors.dart';
import 'package:food_delivery_app/Components/buttons.dart';
import 'package:food_delivery_app/Components/my_icons.dart';
import 'package:food_delivery_app/Providers/auth_provider.dart';
import 'package:food_delivery_app/Screens/sign_up_screen.dart';
import 'package:provider/provider.dart';


class ProfilePage extends StatefulWidget {
  const new({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void _showDialog() {
    showDialog(context: context, builder: 
    (context) {
      return CupertinoAlertDialog(
        title: MyBigText(bigText: 'Want to signout ?'),
        content: MyMediumText(midText: 'Signout and LogOut me out'),
        actions: [
          MaterialButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Cancle'),),

            MaterialButton(onPressed: (){
              Provider.of<AuthProvider>(context, listen: false,).signout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
            }, child: Text('Yes'),),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        automaticallyImplyLeading: false,
        toolbarHeight: 130, leadingWidth: 70,
        backgroundColor: AppColors.mochaGrey,
        
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
              Text('Faizzah', style: TextStyle(fontWeight: .bold, fontSize: 20, color: AppColors.white),),
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
            child: Icon(Icons.edit_note_outlined),),
          )
        ],
            
          ),

 ////////////////////////////

          body: SingleChildScrollView(
            child: Column(
              children: [
            
                    /////////
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                    leading: Icon(Icons.shop),
                    title: MyMediumText(midText: 'My Orders'),
                    subtitle: MySmallText(smlText: 'View your order history'),
                    trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                ),
          /////////
           Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                    leading: Icon(Icons.location_history),
                    title: MyMediumText(midText: 'Saved Location'),
                    subtitle: MySmallText(smlText: 'Manage Delivery Adresses'),
                    trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                ),
                 /////////
           Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                    leading: Icon(Icons.notifications_outlined),
                    title: MyMediumText(midText: 'Notificaations'),
                    subtitle: MySmallText(smlText: 'Order updates & Offers'),
                    trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                ),
                 /////////
           Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                    leading: Icon(Icons.support_agent_outlined),
                    title: MyMediumText(midText: 'Help & Support'),
                    subtitle: MySmallText(smlText: 'Get help when you need it'),
                    trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                ),
                 /////////
           Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                    leading: Icon(Icons.privacy_tip_outlined),
                    title: MyMediumText(midText: 'Privcy policy'),
                    subtitle: MySmallText(smlText: 'How we protect your data'),
                    trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                ),
                 /////////
           Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                    leading: Icon(Icons.receipt_outlined),
                    title: MyMediumText(midText: 'Terms & Conditions'),
                    subtitle: MySmallText(smlText: 'Read out terms of service'),
                    trailing: Icon(Icons.arrow_right),
                    ),
                  ),
                ),
                    
                    
                   
                   const SizedBox(height: 20,),

                Buttons(onTap: _showDialog, buttonText: 'SignOut')
                    
                    
                  
              ],
            ),
          ),
           );
  }
}