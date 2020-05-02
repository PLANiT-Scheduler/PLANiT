# PLANiT

**4/27/2020:** 
- Fixed navigation between homepage, task pages, and class pages. Did not touch schedule page.
- Fixed red screen errors by adding if-check if(snapshot.data == null) return empty container.

**3/21/2020:** Implemented forgot password functionality. Added authenticate\password_reset file description below.

**3/19/2020:** Setup email/password authentication methods in Firebase for ***Android*** app. Modified dependecies in build.gradle and pubspec.yaml to connect Firebase authentication with flutter app.
- Make sure to download and use all files in the **android** folder and **pubspec.yaml** to have proper settings that connects Firebase authentication to the flutter app.
  - **android\app\google-services.json:** This is the config file I downloaded from Firebase to enable and connect the Email and Password authentication method.

  
### HOW TO SETUP NEW FLUTTER PROJECT TO COPY THIS BRANCH'S WORKING PLANIT APP WITH WORKING FIREBASE SERVICES
1. Download ZIP from github and extract
2. Create new flutter project
3. Select Flutter Application > Next
4. Project name: [Any name] > Next
5. Package name: com.cpsc.planit_sprint2
   - Firebase uses the package name '_com.cpsc.planit_sprint2_' so make sure this is the same. Did not test if having a different package name on flutter causes any problems.
6. Finish and open project in new window
7. Copy files from extracted ZIP folder to project root directory
   - This should overwrite the default android\\ folder, pubspec.yaml, and lib\main.dart files
8. Open the pubspec.yaml file and click on "Packages get" to install all the packages in dependencies (this should solve any errors with files that have a red underline)
9. Open Android emulator and run
   - May receive some kind of CloudFirestorePlugin.java error in console during first time running the app, but it will still continue opening the app (delay lasts for at least a minute).
10. App should have a working Create Account, Login, Sign Out, and Forgot Password authentication. (As well as all the other working functions from sprint 1)
    - You can check if an account has been created by going to our [Firebase authentication userbase](https://console.firebase.google.com/u/2/project/planit-573b1/authentication/users)
    - More info about authentication in the file descriptions below. (see authenticate\\ files and services\\auth.dart)


***Note: some of the imports in these dart files references a 'package:planit_sprint2/...', if you are getting errors, make sure planit_sprint2 is changed to whatever you named your flutter app.***
