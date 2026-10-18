import 'dart:io';

import 'package:aura_pdf/ThumbnailImage.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

import 'OpenPdfFile.dart';
import 'PdfViewScreen.dart';
import 'model/HivItem.dart';
import 'model/PdfItem.dart';

class Homepage  extends StatefulWidget{

  const Homepage({super.key});

  @override
  State<StatefulWidget> createState() =>  MyHomePageState();

}


class MyHomePageState extends State<Homepage> {

  List<PdfItem> pdf =[];

  int item_count= 0;


  var boxItem = Hive.box<Hivitem>('Item');



  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Padding(padding: EdgeInsets.all(16),
          child: SafeArea(
            child:
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("My Library",

                    style: TextStyle(color: Colors.black,
                        fontSize: 26,

                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12,),
                  TextField(
                       style: TextStyle(color: Colors.black),
                       decoration: InputDecoration(hintText: "Search",
                         hintStyle: TextStyle(color: Colors.grey),
                         prefixIcon: Icon(Icons.search),
                         filled :true,
                         prefixIconColor: Colors.grey,
                         fillColor : Color(0XFFDCE8EC),
                         border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),

                        ),
                       ),

                  ),
                  SizedBox(height: 12,),

                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: boxItem.length,
                    itemBuilder: (context, index) {
                      var pdfItem = boxItem.getAt(index);

                      return Card(
                        elevation: 10,
                        shadowColor: Colors.black45,
                        margin: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          onTap: (){
                               Navigator.push(context,MaterialPageRoute(builder: (_)=>PdfViewerScreen(pdf: pdfItem)),
                                 );
                               },
                          child: Column(
                            children: [
                              Expanded(
                                child: FutureBuilder<File?>(
                                  future: Thumbnailimage.getThumbnailImage(pdfItem!.filePath),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done &&
                                        snapshot.hasData &&
                                        snapshot.data != null) {
                                      return Image.file(
                                        snapshot.data!,
                                        fit: BoxFit.cover,
                                      );
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  pdfItem!.fileName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),

                      );
                    },
                  ),


                ],
             )

            ,)
          ,),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async{
            pdf = await Openpdffile.openPdf();
            //item_count=10;
             setState(() {
               for(var p in pdf){
                 boxItem.add(Hivitem(p.file_name,p.file_path));
               }

              // item_count = pdf.length;
             });
          },
          backgroundColor: const Color(0XFF1E88E5),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            "Add PDF",
            style: TextStyle(color: Colors.white),
          ),
        ),

    );
  }

}