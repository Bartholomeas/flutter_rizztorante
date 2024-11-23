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

  return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Consumer<LoginViewModel>(builder: (contextNew, model, _) {
        print(loginViewModel.apiState);

        switch (loginViewModel.apiState) {
          case ApiState.loading:
            return const Center(child: CircularProgressIndicator());
          case ApiState.completed:
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Tyle razy wcisnąłeś przycisk: "),
                Text("${model.cl}",
                    style: Theme.of(context).textTheme.headlineLarge),
                MaterialButton(
                  child: const Text("Naciśnij tutaj"),
                  onPressed: () {
                    loginViewModel.increaseNumber(_counter);
                    _counter = loginViewModel.cl;
                  },
                )
              ],
            ));
          case ApiState.error:
            return const Center(child: Text("Error"));
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loginViewModel.increaseNumber(_counter);
        },
        tooltip: "Dodaj",
        child: const Icon(Icons.add),
      ));
}
