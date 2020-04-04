# d9-upgrade_status-project

To better prepare for D9 I am rerunning my expertiment of checking everything for readiness.  

See the project setup script for instructions on how I set up my environment.  

Hit me up on drupal (mcdwayne) or midcamp slack (dwaynemcdaniel) for questions and for the needed CSV, which I am coordinating through google sheets.
The sheet I am wrking from is here:
https://docs.google.com/spreadsheets/d/17Rcj5C99LfV_H_ZSNipqeaajEWgWk94oQo-WlxY84qU/edit?usp=sharing

Storing the XML files temporarily in an invite only Google Drive. Once we done, will post al at once in a folder here.  


Huge props to @AaronFeledy for the love and creating a Lando setup.

You can run this with a little bit of fuss, it is a WIP.    

to use lando, do this:

1.`chmod +rx *.sh` to make sure the script has permissions

2.`lando start` to build the environment

3.`lando serve` to start the Drupal server

4. drop the csv into the project's web folder (or modify the script to point where you like)

5. check local permissions to make sure others can write to your 'reports' file

6. time for one one more final `git commit -am 'ready to roll'` 

7. In a new terminal tab, cd to the project then `lando check` to start.


