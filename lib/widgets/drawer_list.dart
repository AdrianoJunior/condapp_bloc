import 'package:cond_app/utils/alert.dart';
import 'package:cond_app/utils/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DrawerList extends StatelessWidget {
  UserAccountsDrawerHeader _header() {
    User? user = FirebaseAuth.instance.currentUser;
    return UserAccountsDrawerHeader(
      accountName: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          user!.displayName ?? "Nome",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      accountEmail: Text(user.email ?? "E-mail"),
      currentAccountPicture: const CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(
          "https://firebasestorage.googleapis.com/v0/b/condapp-4d828.appspot.com/o/default_images%2Fdefault_image.png?alt=media&token=f252dfca-3e58-4c86-b33f-7c5d6115bd8d",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            _header(),
            ExpansionTile(
              title: const Text("Condomínio"),
              leading: const Icon(
                MaterialCommunityIcons.home_group,
                color: Colors.black,
              ),
              children: [
                ListTile(
                  leading: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.monetization_on,
                      color: Colors.black,
                    ),
                  ),
                  title: const Text("Despesas"),
                  onTap: () {
                    pop(context);
                    Navigator.pushReplacementNamed(context, '/splash/');
                  },
                ),
                ListTile(
                  leading: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Entypo.chat,
                      color: Colors.black,
                    ),
                  ),
                  title: const Text("Reuniões"),
                  onTap: () {
                    pop(context);
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("Agenda"),
              leading: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Ionicons.md_calendar, color: Colors.black),
              ),
              children: [
                ListTile(
                  leading: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      MaterialIcons.quick_contacts_dialer,
                      color: Colors.black,
                    ),
                  ),
                  title: const Text("Visitas"),
                  onTap: () {
                    pop(context);
                  },
                ),
                ListTile(
                  leading: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Ionicons.md_today,
                      color: Colors.black,
                    ),
                  ),
                  title: const Text("Reservas"),
                  onTap: () {
                    pop(context);
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Ionicons.md_person_circle_sharp,
                  color: Colors.black,
                ),
              ),
              title: const Text("Perfil"),
              children: [
                ListTile(
                  title: const Text("Meus dados"),
                  leading: const Icon(
                    Ionicons.document_text,
                    color: Colors.black,
                  ),
                  onTap: () {
                    pop(context);
                  },
                ),
                ListTile(
                  title: const Text("Trocar senha"),
                  leading: const Icon(
                    Ionicons.md_key,
                    color: Colors.black,
                  ),
                  onTap: () {
                    pop(context);
                  },
                ),
                ListTile(
                  leading: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      MaterialCommunityIcons.exit_to_app,
                      color: Colors.black,
                    ),
                  ),
                  title: const Text("Logout"),
                  onTap: () {
                    pop(context);
                    _onClickLogout();
                  },
                ),
              ],
            ),
            ListTile(
              title: const Text("Configurações"),
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Ionicons.md_settings,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                pop(context);
              },
            ),
            ListTile(
              title: const Text("Informações"),
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Ionicons.information_circle,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                pop(context);
                PackageInfo.fromPlatform().then(
                  (PackageInfo packageInfo) {
                    String appName = packageInfo.appName;
                    String version = packageInfo.version;
                    alert(context, "Aplicativo $appName\nVersão $version");
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onClickLogout() async {}
}
