# d9-upgrade_status-project

To better prepare for D9 I am rerunning my expertiment of checking everything for readiness.  

See the project setup script for instructions on how I set up my environment.  

Hit me up on drupal (mcdwayne) or midcamp slack (dwaynemcdaniel) for questions and for the needed CSV, which I am coordinating through google sheets.
The sheet I am working from is here:
https://docs.google.com/spreadsheets/d/17Rcj5C99LfV_H_ZSNipqeaajEWgWk94oQo-WlxY84qU/edit?usp=sharing

Storing the XML files temporarily in an invite only Google Drive. Once we done, will post al at once in a folder here.  

#### Using Lando
Huge props to @AaronFeledy for the love and creating a Lando setup.

You can run this with a little bit of fuss, it is a WIP.    

1. `lando start` to build the environment

1. `lando serve` to start the Drupal server

1. drop the csv into the project's web folder (or modify the script to point where you like)

1. In a new terminal tab, cd to the project then `lando check` to start.

1. 1. If you plan to run multiple instances, run `lando gimme4` to build 3 additional environments and follow on screen instructions for starting those instances.
