import 'package:cond_app/pages/agenda/visitas/visitas_form_page.dart';
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
      '/visitas/cadastrar/': (context) => VisitasFormPage(),
      '/reunioes/': (context) => const ReunioesPage(),
      '/perfil/': (context) => const PerfilPage(),
      '/recuperar/': (context) => const MudarSenhaPage(),
    };
  }
}