# bnpl
If you want to download and use the app, you will have to setup AWS and Cognito.  
You can get started here https://docs.amplify.aws/lib/auth/getting-started/q/platform/flutter/#check-the-current-auth-session.  
For sign in/up to work with google and facebook you will have to do some additional configuration.  
Instructions here https://docs.amplify.aws/lib/auth/social_signin_web_ui/q/platform/flutter/#ios-platform-setup.  

In the temp.dart file comment out the testCallLambda function and the text widget where its being called.  
That function is calling a lambda function which returns all the tables in the database.
