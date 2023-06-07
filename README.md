# bnpl
If you want to download and use the app, you will have to setup AWS and Cognito.  
You can get started here https://docs.amplify.aws/lib/auth/getting-started/q/platform/flutter/#check-the-current-auth-session.  
For sign in/up to work with google and facebook you will have to do some additional configuration.  
Instructions here https://docs.amplify.aws/lib/auth/social_signin_web_ui/q/platform/flutter/#ios-platform-setup.  

In the temp.dart file comment out the testCallLambda function and the text widget where its being called.  
That function is calling a lambda function which returns all the tables in the database.

## Preview
![V5-Home Flow](https://github.com/vsharma-va/BNPL-Flutter/assets/78730763/9eed8074-64b6-4124-be86-b68618f6707d)  
![V5-Auth Flow](https://github.com/vsharma-va/BNPL-Flutter/assets/78730763/34e75347-c334-4a9f-bc66-7c5614c95e2c)  
![V4](https://user-images.githubusercontent.com/78730763/160389662-e8e35988-f558-4350-baf5-144ac5a9909d.mp4)  
![V3](https://user-images.githubusercontent.com/78730763/157047801-ee6d4da5-98a2-4a54-a28c-daa82778ba94.mp4)   
![V2](https://user-images.githubusercontent.com/78730763/156738573-1d558d18-2a70-47b4-8e2c-b3cd5c468491.mp4)  
![V1](https://user-images.githubusercontent.com/78730763/156738736-2bcdf010-deab-4610-a7c9-2f6677f46123.mp4)
