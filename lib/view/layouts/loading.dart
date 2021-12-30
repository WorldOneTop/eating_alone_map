
import 'package:flutter/material.dart';

class LoadingDialog {
  LoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child:  const AlertDialog(
                content: Center(child:  CircularProgressIndicator(strokeWidth: 5,color: Colors.amberAccent)),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              )
          );
        });
  }

}

