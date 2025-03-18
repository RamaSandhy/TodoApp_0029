import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final key = GlobalKey<FormState>();
  List<String> daftarNama = [];

  void addData(){
    setState((){
      daftarNama.add(nameController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    spacing: 15,
                    children: [
                      CircleAvatar(radius: 30 ,backgroundImage: AssetImage('assets/gus_jafar_marah.jpg')),
                      Text("Gus Akira"),
                      // Image(image: AssetImage('assets/images/burjo.jpg'), height: 150, width: 150,),
                      // Image.asset('assets/images/magelangan.jpg')
                    ],
                ),
                Form(
                  key: key,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: nameController,
                           validator: (value){
                              if (value == null || value.isEmpty){
                                return 'tidak ada';
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                            label: Text('Nama '), 
                            hintText: 'Masukkan Gus anda'),
                           
                        ),
                      ),
                      OutlinedButton(onPressed: (){
                        if(key.currentState!.validate()){
                          addData();
                        }
                      }, 
                      child: Text('Submit'))
                    ],
                  )
                ),
                Expanded(
                  child: ListView.builder(itemCount: 
                    daftarNama.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.indigo[100],
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, 
                          children: [
                            Text(daftarNama[index])
                          ],
                        ),
                      );
                    },))
              ],
            ),
        ),
      ),
    );
  }
}