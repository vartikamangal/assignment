import 'dart:developer';

/// -----------------------------------
///          External Packages
/// -----------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tatsam_app_experimental/core/secrets.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

/// -----------------------------------
///           Profile Widget
/// -----------------------------------
class Profile extends StatelessWidget {
  final logoutAction;
  final String name;
  final String picture;

  Profile(this.logoutAction, this.name, this.picture);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 4.0),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(picture),
            ),
          ),
        ),
        SizedBox(height: 24.0),
        Text('Name: $name'),
        SizedBox(height: 48.0),
        RaisedButton(
          onPressed: () {
            logoutAction();
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}

/// -----------------------------------
///            Login Widget
/// -----------------------------------
/// -----------------------------------
///            Login Widget
/// -----------------------------------

class Login extends StatelessWidget {
  final loginAction;
  final String loginError;

  const Login(this.loginAction, this.loginError);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            loginAction();
          },
          child: Text('Login'),
        ),
        Text(loginError),
      ],
    );
  }
}

/// -----------------------------------
///                 App
/// -----------------------------------

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

/// -----------------------------------
///              App State
/// -----------------------------------

class _AuthScreenState extends State<AuthScreen> {
  bool isBusy = false;
  bool isLoggedIn = false;
  String? errorMessage;
  String? name;
  String? picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth0 Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  final AuthorizationTokenResponse result =
                      await (appAuth.authorizeAndExchangeCode(
                    AuthorizationTokenRequest(
                      Secrets.AUTH0_CLIENT_ID,
                      Secrets.AUTH0_REDIRECT_URI,
                      issuer: Secrets.AUTH0_ISSUER,
                      additionalParameters: {
                        'audience': Secrets.AUTH0_AUDIENCE,
                      },
                      scopes: [
                        'openid',
                        'email',
                        'offline_access',
                        'api',
                      ],
                      //! Just remve this for auto maintained session
                      promptValues: ['login'],
                      // promptValues: ['login']
                    ),
                  ) as Future<AuthorizationTokenResponse>);
                  await testLogin(
                    accessToken: result.accessToken,
                  );
                  log(result.accessToken!);
                } catch (e) {
                  log(
                    e.toString(),
                  );
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              onPressed: () async {
                try {
                  final response = await http.get(
                    Uri.parse(
                      'http://13.229.249.25:9090/auth/test/header',
                    ),
                    headers: {
                      "Authorization":
                          "Bearer OktQrqxp5GJlTWFP3IjH4_caSUmbQreC",
                    },
                  );
                  log(
                    response.statusCode.toString(),
                  );
                } catch (e) {
                  log(e.toString());
                }
              },
              child: const Text('Check'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> testLogin({
    required String? accessToken,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://13.229.249.25:9090/auth/test/header',
        ),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );
      log(
        response.statusCode.toString(),
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
