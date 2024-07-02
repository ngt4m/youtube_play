import 'package:flutter/material.dart';
import 'package:flutter_application_2/bottom_sheet/manager_bottom_sheet.dart';
import 'package:provider/provider.dart';



class _BottomSheetState extends StatelessWidget {
  //  PersistentBottomSheetController? _controller;
  // @override
  // Widget build(BuildContext context) {
  //   _controller = Scaffold.of(context).showBottomSheet(
  //     (context) {
  //       return Container(
  //         height: 100,
  //        // color: Colors.black,
  //         child: ListTile(
  //           title: Text(widget.youtubeTitle),
  //           subtitle: Text(widget.youtubeChannel),
  //         ),
  //       );
  //     },
  //   );
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.pop(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => HomePage(),
  //           ));
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomSheetManager>(
      builder: (context, bottomSheetManager, child) {
        return Visibility(
          visible: bottomSheetManager.isVisible,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListTile(
                          title: Text(bottomSheetManager.youtubeTitle),
                          //subtitle: ,
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            bottomSheetManager.hideBottomSheet();
                          },
                        ),

                      ],
                    ),
                  ),
        
                  Center(child: Text('Your content here')),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
