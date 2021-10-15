import 'package:cond_app/utils/exports.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5)).then((value) => Navigator.pushReplacementNamed(context, '/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: _body(),
        );
  }

  _body() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Center(child: Image.asset('assets/images/logo_name.png'),),
          const CircularProgressIndicator(),
        ],
      )
    );

  }
}
