//scaffold with navigation bar and body with grid layout
//path 

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Magcaso")),
    body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),children: [
          InkWell(
            onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.red,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
              Icon(Icons.home,size: 50,color: Colors.white,),
              Text("Uno",style: TextStyle(color: Colors.white,fontSize: 30),)
            ],),
            ),
          ),
         InkWell(
             onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
           child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.yellow,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
              Icon(Icons.search,size: 50,color: Colors.white,),
              Text("Duo",style: TextStyle(color: Colors.white,fontSize: 30),)
            ],),
            ),
         ),
          InkWell(
              onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.green,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
              Icon(Icons.settings,size: 50,color: Colors.white,),
              Text("tres",style: TextStyle(color: Colors.white,fontSize: 30),)
            ],),
            ),
          ),
          InkWell(
              onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
              Icon(Icons.book,size: 50,color: Colors.white,),
              Text("cuatro",style: TextStyle(color: Colors.white,fontSize: 30),)
            ],),
            ),
          ),
                    InkWell(
              onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
              Icon(Icons.book,size: 50,color: Colors.white,),
              Text("sies",style: TextStyle(color: Colors.white,fontSize: 30),)
            ],),
            ),
          ),
                    InkWell(
              onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
              Icon(Icons.book,size: 50,color: Colors.white,),
              Text("six",style: TextStyle(color: Colors.white,fontSize: 30),)
            ],),
            ),
          ),
          
        ],
        ),
      ),
    );
  }
}