import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vikas/server/api.dart';

// class CamPage extends StatefulWidget{
//   @override
//   _CamPageState createState() => _CamPageState();
// }

// class _CamPageState extends State<CamPage> {

//   List<CameraDescription>? cameras; //list out the camera available
//   CameraController? controller; //controller for camera
//   XFile? image; //for caputred image

//   @override
//   void initState() {
//     loadCamera();
//     super.initState();
//   }

//   loadCamera() async {
//       cameras = await availableCameras();
//       if(cameras != null){
//         controller = CameraController(cameras![0], ResolutionPreset.max);
//                     //cameras[0] = first camera, change to 1 to another camera

//         controller!.initialize().then((_) {
//             if (!mounted) {
//               return;
//             }
//             setState(() {});
//         });
//       }else{
//         print("NO any camera found");
//       }
//   }

//   @override
//   Widget build(BuildContext context) {

//     return  Scaffold(
//           appBar: AppBar(
//               title: Text("Live Camera Preview"),
//               backgroundColor: Colors.redAccent,
//           ),
//           body: Container(
//             child: Column(
//               children:[
//                   Container(
//                       height:300,
//                       width:400,
//                       child: controller == null?
//                           Center(child:Text("Loading Camera...")):
//                                 !controller!.value.isInitialized?
//                                   Center(
//                                     child: CircularProgressIndicator(),
//                                   ):
//                                   CameraPreview(controller!)
//                   ),

//                   Container( //show captured image
//                      padding: EdgeInsets.all(30),
//                      child: image == null?
//                            Text("No image captured"):
//                            Image.file(File(image!.path), height: 300,),
//                            //display captured image
//                   )
//               ]
//             )
//           ),

//           floatingActionButton: FloatingActionButton(
//             onPressed: () async{
//                 try {
//                   if(controller != null){ //check if contrller is not null
//                       if(controller!.value.isInitialized){ //check if controller is initialized
//                           image = await controller!.takePicture(); //capture image
//                           setState(() {
//                              //update UI
//                           });
//                       }
//                   }
//                 } catch (e) {
//                      print(e); //show error
//                 }
//             },
//             child: Icon(Icons.camera),
//           ),

//        );
//   }
// }
class CamPage extends StatefulWidget {
  const CamPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<CamPage> createState() => _CamPageState();
}

class _CamPageState extends State<CamPage> {
  File? image;
  
  late String imageTemp2;

  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);

  //     if(image == null) return;

  //     final imageTemp = File(image.path);

  //     setState(() => this.image = imageTemp);
  //   } on PlatformException catch(e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 15);

      if (image == null) return;

      final imageTemp = File(image.path);
      final bytes = File(image.path).readAsBytesSync();
       imageTemp2 = Base64Encoder().convert(bytes);
      // await sendBimg(imageTemp2,shgID.text);
      print(imageTemp2);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  TextEditingController shgID = TextEditingController();
  Map? data = {};
  bool isLoading = true;
  searchshg(String shgid) async {
    checkInternetConnection().then((value) async {
      if (value == true) {
        await sendBimg(imageTemp2,shgID.text.toString());
        // data = await getSHGData(shgid);

        // print(data);
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

    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Upload Image"),
        ),
        body: Center(
          child: Column(
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
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: 'SHG ID',
                        labelStyle:
                            TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ),
                  
                
              
              // MaterialButton(
              //     color: Colors.blue,
              //     child: const Text(
              //         "Pick Image from Gallery",
              //       style: TextStyle(
              //         color: Colors.white70, fontWeight: FontWeight.bold
              //       )
              //     ),
              //     onPressed: () {
              //       pickImage();
              //     }
              // ),
              MaterialButton(
                  color: Colors.black,
                  child: const Text("Capture Image from Camera",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pickImageC();
                  }),
              SizedBox(
                height: 20,
              ),
              image != null ? Image.file(image!) : Text("No image Captured"),


              IconButton(
                    onPressed: () => searchshg(shgID.text),
                    icon: Icon(Icons.upload_file),
                    color: Colors.black,
                  ),
            ],
          ),
        ));
  }
}
