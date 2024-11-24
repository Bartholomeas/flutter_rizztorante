import 'package:flutter/material.dart';
import 'package:flutter_restaurant/ui/login/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

int _counter = 0;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: initView(context),
    );
  }
}

Widget initView(BuildContext context) {
  LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Consumer<LoginViewModel>(builder: (contextNew, model, _) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: "Email", border: OutlineInputBorder()),
                )),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Hasło", border: OutlineInputBorder()),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: loginViewModel.apiState == ApiState.loading
                  ? null
                  : () {
                      loginViewModel.login(
                          emailController.text, passwordController.text);
                    },
              child: loginViewModel.apiState == ApiState.loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: Colors.white))
                  : const Text(
                      "Zaloguj się",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
            if (loginViewModel.apiState == ApiState.error)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Błąd logowania. Sprawdź dane i spróbuj ponownie.",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
          ],
        ));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loginViewModel.increaseNumber(_counter);
        },
        tooltip: "Dodaj",
        child: const Icon(Icons.add),
      ));
}
