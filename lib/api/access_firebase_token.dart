import 'package:googleapis_auth/auth_io.dart';

class AccessFirebaseToken {
  static String fMessagingScope =
      "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(

//PASTE YOUR GENERATED JSON FILE CODE OVER HERE
      {

        {
  "type": "service_account",
  "project_id": "chatpulse-c4de3",
  "private_key_id": "1886eed6d27e534d44eceaceeae8da24187347b3",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDlJWKAB7C3eOss\nT6m8L0+jlpySxhJToLSDQJGQx8S3QS2lV6Xjlm69q8EkzyPqlssYi5TIlyWNyUVo\nQ4cExAWaEFEDk6mJv5GELJiKqLh+YzuRFAkfSOFs+oKBnbEg907GF9QE/bpTpB/i\n11fwJdCHsCw8eBn1x0ZwBNJ3rHKDkEm7L7MufU4PBzkMyT64Zw/q/dfzCvTFBhvh\n90EjVI17GIwWvv/FMgBPElWp6Q7MDTtMbcIAJIjFhYhpspljhJj0zS7jdMLqrO6C\nPftlCB25jIdLJkkLDgK9wOyZ/sIYAjvvjk+J7tNajkVNSy/zRxyqvP7omj90adNN\nnNOoyyIDAgMBAAECggEAKHmKBINXO5EoORN5L7xLnOGllmdWJV9lgymMjL48iQIC\nRgpNSv3vYaFM5GuSNIWeKh+9kBDimUDL+bazyqu1MZlgNfmHIMWttmMKLrPOosR0\naRPY6KW+67j0BGEOQHxudZ8P3DHVD6EV4MOYzNphExaTObsdGsSwNGklo+3Z7FLi\nmMfnLq7QtUb/fLIXHgs5qi62+IM6gpu4mkrgqCPBUXIyX4i/tNPuVLiuWqiX0P7z\nNEceB+mseLiNlpeWgZT8EJb5zP4EE2lQaJPcKIBMOoxm6JVEBoq3mAuA7fdSYPQw\n5MQqcWVMSAxCD1I2xxyuVXGW3+RqOjDpGU5x9OTvwQKBgQD5voyjNdoMobPG4/EE\nYZqUbj83t5dmzDx4nXIoagDOGRLssHgdQBdFTODJ8DFr1kfqSRrZgPqTD4J3obqx\nBvwlp6cNVlsiKbqijhLhwoacV0H0Lg0Gn2ofdKGbVOaVTS83Ktnybu6KOLp7mHH1\nIzl0cCjibuu3rcOFuilsYjx4HQKBgQDq4sBuegJGHQMFGLXSTvZrF1zDz05VwoNU\nlUtbLaQ2gqyMbliX6gtE0CXNHHXyAdQVrJUziAQt6vnnOW9kLZKWNTKjrMW+zFOx\no8DYQXTW8v7/oYSL7x4t4kO9sB/GWc4zdBhW95+QIoXlwdiQaV1TnXovjLdUUuBC\nYZHwItgonwKBgBkAk5HPVVoIYjgaH8nhf5k2hEuurJCVB8THdmNHYXdAmV1quUus\nW+gLL0HoMvppxF9XHEIEIJHSbqxNW6RXX6zhYN778zmzVcTqVkeVsuY58hdg+Nrd\n4MDvazJiyIbP6Fcsig80PdtGnJy9AUOaWCkpBV7N3flQgw+DOJxqJUWdAoGBAIfk\nQCiqdf5ScpjUPv05qd8zWPwAR/Xd31VkOoC52zOeTm3AuYjKY1Kgif4s5R/qZuVT\nP87cdm6Kb6KS3Bs9Mn2ssWt4Xb+RPyqa7ssus4ZYd6c1rxW2deNd8IsiBoAfHOkv\n1ZUbFjmxf335tG14SAJELZis9LPYbt54zJH91slJAoGADGAdIlUJlreVUcaykJzN\nK/OLywPsANy2VgJOc8lDC2GU806hz/+DoHqpaca+00axkNMrlt9Km9pibF2ziLJ5\nJUJpNZOdgFFJYn9nv9hOwwbeRYjvb+Q5MPB9OqzwgsygqPFP/E+1KN2vK1IKzVNX\nytKCH5bLh0NaRN+i+ZH5jEM=\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-jrhqg@chatpulse-c4de3.iam.gserviceaccount.com",
  "client_id": "111361568102793821503",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-jrhqg%40chatpulse-c4de3.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}


      }),
      [fMessagingScope],
    );

    final accessToken = client.credentials.accessToken.data;
    return accessToken;
  }
}
