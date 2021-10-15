import 'exports.dart';

alert(BuildContext context, String msg, {Function? callback}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("CondApp"),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                if(callback != null) {
                  callback();
                }
                pop(context);
              },
            )
          ],
        ),
      );
    },
  );
}