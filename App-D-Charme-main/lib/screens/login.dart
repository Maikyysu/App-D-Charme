import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/app_state_provider.dart';
import '/config.dart';
import './widgets/linktext.dart';
import './widgets/appbardefault.dart';
import '../models/theme_provider.dart'; 

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  
  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Preencha e-mail e senha')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        ref.read(appStateProvider.notifier).setUser(_emailController.text.trim());
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Erro ao fazer login.';
      if (e.code == 'user-not-found') message = 'Usuário não encontrado.';
      if (e.code == 'wrong-password') message = 'Senha incorreta.';
      if (e.code == 'invalid-email') message = 'E-mail inválido.';

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  
  void _openSignUpSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const _SignUpSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    ref.watch(themeProvider);

    
    final inputDecoration = InputDecoration(
      labelStyle: TextStyle(color: AppConfig.textColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        
        borderSide: BorderSide(color: AppConfig.textColor.withValues(alpha: 0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(color: AppConfig.primaryColor, width: 2),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
    );

    return Scaffold(
      backgroundColor: AppConfig.backgroundColor,

      appBar: DefaultAppBar(
        title: AppConfig.appName,
        subtitle: AppConfig.slogan,
        isLogin: true,
        leading: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.woman, size: 30),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.woman, size: 30),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Icon(Icons.account_circle, size: 100, color: AppConfig.textColor),
            const SizedBox(height: 30),

            
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: AppConfig.textColor),
              decoration: inputDecoration.copyWith(labelText: 'E-mail'),
            ),

            const SizedBox(height: 12),

            
            TextField(
              controller: _passwordController,
              style: TextStyle(color: AppConfig.textColor),
              decoration: inputDecoration.copyWith(labelText: AppConfig.passwordFieldLabel),
              obscureText: true,
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: LinkText(
                text: "Esqueceu sua senha?",
                color: AppConfig.secondaryColor,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Funcionalidade em breve!')));
                },
              ),
            ),

            const SizedBox(height: 20),

            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConfig.secondaryColor,
                  foregroundColor: AppConfig.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white))
                    : Text(
                        AppConfig.loginButtonText,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppConfig.backgroundColor),
                      ),
              ),
            ),

            const SizedBox(height: 16),

            
            Center(
              child: RichLinkText(
                normalText: "Não tem uma conta? ",
                highlightedText: "Inscreva-se",
                normalColor: AppConfig.secondaryColor,
                highlightedColor: AppConfig.primaryColor,
                onTap: _openSignUpSheet,
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}


class _SignUpSheet extends StatefulWidget {
  const _SignUpSheet();

  @override
  State<_SignUpSheet> createState() => _SignUpSheetState();
}

class _SignUpSheetState extends State<_SignUpSheet> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (_emailController.text.isEmpty || _passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail inválido ou senha muito curta (mín 6).')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            backgroundColor: AppConfig.backgroundColor,
            title: Text("Sucesso! 🎉", style: TextStyle(color: AppConfig.textColor)),
            content: Text("Sua conta foi criada. Agora faça login para entrar.",
                style: TextStyle(color: AppConfig.textColor)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                },
                child: Text("OK, VOU LOGAR",
                    style: TextStyle(color: AppConfig.primaryColor)),
              )
            ],
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String msg = 'Erro ao criar conta.';
      if (e.code == 'email-already-in-use') msg = 'Este e-mail já está cadastrado.';
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      labelStyle: TextStyle(color: AppConfig.textColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        
        borderSide: BorderSide(color: AppConfig.textColor.withValues(alpha: 0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppConfig.primaryColor, width: 2),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );

    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      decoration: BoxDecoration(
        color: AppConfig.backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Criar Nova Conta",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppConfig.textColor)),
          const SizedBox(height: 20),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: AppConfig.textColor),
            decoration: inputDecoration.copyWith(labelText: 'E-mail'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _passwordController,
            obscureText: true,
            style: TextStyle(color: AppConfig.textColor),
            decoration:
                inputDecoration.copyWith(labelText: 'Senha (mín 6 caracteres)'),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _signUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConfig.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("CADASTRAR",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}