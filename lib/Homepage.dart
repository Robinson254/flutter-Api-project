import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<dynamic> users=[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random User API"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
          child: Text("press"),
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context,index){
            final user = users[index];
            final name= user['name']['last'];
            final email= user['email'];
            final imageurl=user['picture']['thumbnail'];
            final location=user['location']['street']['name'];
            final phone=user['phone'];
            return Column(
              children: [
                ListTile(
                  leading:ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(imageurl)),
                   //CircleAvatar(child: Text('$index')),
                  title: Text(name),
                  subtitle: Text(email),
                  trailing: Column(
                    children: [
                      Text(phone),
                       //Text(location,style:TextStyle(color: const Color.fromARGB(255, 232, 169, 243)),)
                      //Icon(Icons.call_end_outlined,color: Colors.green,),
                    ],
                    
                  ),
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(location,style: TextStyle(
                //       color: const Color.fromARGB(255, 180, 211, 237),
                //     ),),
                //     //Icon(Icons.call_end_outlined,color: Colors.green,),
                //   ],
                // )
              ],
            );
            
          }),
    );
  }
  

  void fetchUsers() async {
    print("fetchUsers called");
    const url= 'https://randomuser.me/api/?results=500';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body= response.body;
    final json= jsonDecode(body);

    setState(() {
      users= json['results'];
    });

     print('fetchUsers called');
  
  }
}