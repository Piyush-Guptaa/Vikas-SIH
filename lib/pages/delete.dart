import 'package:flutter/material.dart';
import 'package:vikas/server/api.dart';

class DeleteSHGPage extends StatefulWidget {
  const DeleteSHGPage({Key? key}) : super(key: key);

  @override
  State<DeleteSHGPage> createState() => _DeleteSHGPageState();
}

class _DeleteSHGPageState extends State<DeleteSHGPage> {
 TextEditingController shgID = TextEditingController();
  Map? data = {};
  bool isLoading = true;
  searchshg(String shgid) async {
    checkInternetConnection().then((value) async {
      if (value == true) {
        data = await getSHGData(shgid);
        print(data);
        if (data == null) {
          SnackBar snackBar =
              SnackBar(content: Text('No SHG found with this ID'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          isLoading = true;
          setState(() {});
        } else {
          isLoading = false;
          setState(() {});
        }
      } else {
        SnackBar snackBar = SnackBar(content: Text('No Internet Connection'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Delete SHG',
            style: TextStyle(fontSize: 24),
          ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.arrow_back),
          //     onPressed: () async {
          //       Navigator.pop(context);
          //     },
          //   ),
          // ],
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 300,
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: shgID,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "SHG ID cannot be empty";
                        }
                        if (int.tryParse(value) == null) {
                          return "SHG ID must be a number";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: 'SHG ID',
                        labelStyle:
                            TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => searchshg(shgID.text),
                    icon: Icon(Icons.search),
                    color: Colors.white,
                  ),
                ],
              ),
              Container(
                child: isLoading
                    ? Center(
                        child: Text("Enter SHG ID to Delete",
                            style:
                                TextStyle(color: Colors.white, fontSize: 24)),
                      )
                    : Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Found SHG',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'NAME: ' + data!['name'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'SHG ID: ' + data!['shgid'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 25),
                          SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: () async {
                    checkInternetConnection().then((value) async {
                      if (value == true) {
                        bool status= await deleteSHGData(shgID.text);
                        if(status==true){
                          SnackBar snackBar = SnackBar(content: Text('SHG Deleted Successfully'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        else{
                          SnackBar snackBar = SnackBar(content: Text('Error Deleting SHG'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        Navigator.pop(context);
                      } else {
                        SnackBar snackBar =
                            SnackBar(content: Text('No Internet Connection'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  icon: Icon(Icons.delete),
                  label: Text("Delete SHG")),
            ),
                        ],
                      ),
              )
              // Text(
              //   'Name: ' + data['name'].toString(),
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ));
  }
}