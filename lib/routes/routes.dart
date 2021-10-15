import 'package:cond_app/utils/exports.dart';

class Routes {
  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => const DespesasPage(),
      '/splash/': (context) => const SplashPage(),
      '/login/': (context) => const LoginPage(),
      '/register/': (context) => const CadastroPage(),
      '/reservas/': (context) => const ReservasPage(),
      '/visitas/': (context) => const VisitasPage(),
      '/reunioes/': (context) => const ReunioesPage(),
      '/perfil/': (context) => const PerfilPage(),
      '/recuperar/': (context) => const MudarSenhaPage(),
    };
  }
}