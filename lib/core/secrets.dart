class Secrets {
  // static const String AUTH0_DOMAIN = 'dev-nf1jv07z.us.auth0.com';
  static const String AUTH0_DOMAIN = 'login.dev.tatsam.in';
  static const String AUTH0_CLIENT_ID = 'R136aLseD6oK74NvDuwYs0KgnDtycw2Q';
  static const String AUTH0_AUDIENCE = 'https://tatsam.in/user';

  static const String AUTH0_REDIRECT_URI =
      'com.example.tatsamappexperimental://login-callback';
  static const String AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';
  static const String SMARTLOOK_KEY =
      "532d4e63fd94cd4ec161deb48ab114f40223df9b";
  Secrets._();
}
