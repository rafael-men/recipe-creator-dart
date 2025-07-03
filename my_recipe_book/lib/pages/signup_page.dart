import 'package:flutter/material.dart';
import 'package:my_recipe_book/services/auth_service.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nicknameController = TextEditingController();

  bool _loading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login_bg.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Sobreposição escura
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Card central
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                color: Colors.white.withOpacity(0.95),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Crie sua conta',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoSlab',
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_error != null)
                        Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      TextField(
                        controller: _nicknameController,
                        decoration: const InputDecoration(labelText: 'Apelido (Nickname)'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'E-mail'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _passController,
                        decoration: const InputDecoration(labelText: 'Senha'),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      _loading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8B0000),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _loading = true;
                                    _error = null;
                                  });
                                  try {
                                    await auth.signUp(
                                      _emailController.text.trim(),
                                      _passController.text.trim(),
                                      nickname: _nicknameController.text.trim(),
                                    );
                                    Navigator.pop(context);
                                  } catch (e) {
                                    setState(() {
                                      _error = e.toString();
                                    });
                                  } finally {
                                    setState(() {
                                      _loading = false;
                                    });
                                  }
                                },
                                child: const Text('Cadastrar'),
                              ),
                            ),
                        TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child:  Text('Fazer Login',style: const TextStyle(color: Colors.black),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
