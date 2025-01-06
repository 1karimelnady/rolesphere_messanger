import 'dart:developer';

import 'package:googleapis_auth/auth_io.dart';

class NotificationAccessToken {
  static String? _token;

  static Future<String?> get getToken async =>
      _token ?? await _getAccessToken();

  static Future<String?> _getAccessToken() async {
    try {
      const fMessagingScope =
          'https://www.googleapis.com/auth/firebase.messaging';

      final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "chat-app-3de74",
          "private_key_id": "a5a1c556fc2cf69a2c25a0c72111bea8866b7808",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCrdvP/jzR1tGHi\nXCoLtbr5G932M+x76TeKUFfm/hCJ76kfqFF+OM7VTyfYjfI/0AxoN556OdgbG7j5\noHkqc7SMwPpDadghmh8+yfmnmEYnaDh8lepsSEKRXSF9/Ei6vcoF2ABxc67GQ9XE\nHTjKqL31ojcQJbO+mgM63KGAl5THBB8tXKDX85CdzjrxWjZ/0KmHk3IK1nfNo34T\nabjfnG5vyedRQbQyF1JUzmZ+fKGECVBFg2+IkB2QewNoIXyqLhIR1GjVGDn9Ogrw\no36rdIGIPxYT1lhDKx9uPIDWjoSY4UFmOlRHQWu+4Nee40nfcvLzRVb9YIif6TYS\nUiRv3BUHAgMBAAECggEACRRWcqI+++XzskyBFCJTu/HZfLpee71Av1E70QkuZQTM\n0YFUjLjYsvuVt5DkqAkN7yLVgHwO+83UVgZFBEDLlGck7sGXEUhw/nPW2s9kakfJ\niJyuT3zlZtR7UTQ1Fwu1ET7RNIYUq35XaSLG/sGVYCwZJatpa4lflxQByqZm2WxB\n6DXM7Ln+B30OOYjRHbqm0sOICI1DnEPhWAzq/VtQCqGiJY4Ed++eNXqGlUmP8OJ0\nS6ElqAEPYCteL0mu7Lt8MkKPCy7bl7bf4z31yOLviCELAGiITjBHNxq9u17R7UZ7\nFDUJdwqzuUpizInvUTgzPSI0ssJPQq5QNG6c1QommQKBgQDILCY8wqvjtHW15/rH\n0VEz73sPd10d3W5NrHq8iRurOiI3xHWXQeD/Qw6tkmAXuTMJgbAzsLGQBMtQyY/f\nNeJHwXvvBgCmSJjTjAB0eG2HQT+Sof3z/crtvSuogRFcPNQkASbE1nUvj5wcdH/V\ndSoz0GbpSx59aVkxd9BggVZcAwKBgQDbSSIk2XwX6eFnwZ4vhTq9j6jWiI8Z2Ayl\nOzgJq2/dZsJn+yRvtaiUpF7PodD1UDSJ79tNdnFMg7Boxz/W9ndxEr4hZ5P9vfBy\nt/tDuaZu+Uch9rYinQS3Z7G+05d4kCaQM3iZAATCPxiP3oZ7Cvyb02mRTeh84/lE\n2Yr90PFNrQKBgB6eqka3HKYbT7pAvxrbyQkhw/hMsQDFg378OFYovwPFQ8C2G6rE\nmA9UCaXBc1ONr+HvZa2yhKbcJOG5w3lIe9GwJi4dA/Jrvnz1uIgYd+CtuXTLtNYi\n52zQeCIxhB9Q6r6LMov/pjNdS2sK4xca8ha09VkQdZyHhe5MPqLUhgpTAoGBAK9g\nWBxci/CcLpfKs/aReR8uC/w4Dyq+La7gI7soDzlk+8opg0SMZp0qsGEiq3nmgX5o\nBF55gbeOAsJpyFblmzUlpkYVDrj69ZjqJ9xMWB2c5BT3uUcJiUIdfnx9wUC9GPpv\nD95ds3CfAcfeUnOJn+oINP/u7SclNLCpw42nU7WpAoGAVOSptU4Y/xenGZ9gl8rf\nwcHWOv+tUeUYsHNMaO11K0gMxADCqvhE7P4W3skae7+q4eULRDcZ250XvNzln1O8\nQHZvV3Fz33laHCpgyWp+rBDjK3ZXH0RCTAywBX3Y2Z+8bXVSlczvPKBB0K1dWPOM\nLZ9L3ysYtbfb4BQxZv35aHw=\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-s1ngx@chat-app-3de74.iam.gserviceaccount.com",
          "client_id": "110199482506102911836",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-s1ngx%40chat-app-3de74.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        [fMessagingScope],
      );

      _token = client.credentials.accessToken.data;

      return _token;
    } catch (e) {
      log('$e');
      return null;
    }
  }
}
