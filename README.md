# d9-upgrade_status-project

To better prepare for D9 I am rerunning my expertiment of checking everything for readiness.  

See the project setup script for instructions on how I set up my environment.  

Hit me up on drupal (mcdwayne) or midcamp slack (dwaynemcdaniel) for questions and for the needed CSV, which I am coordinating through google sheets.


to use lando, do this:

1.`lando start` to build the environment

2.`lando serve` to start the Drupal server

3. drop the csv into the project's web folder (or modify the script to point where you like)

4. `chmod +rx *.sh` to make sure the script has permissions

5. check local permissions to make sure others can write to your 'reports' file

6. time for one one more final `git commit -am 'ready to roll'` 

7. Now that In a new terminal tab, cd to the project then lando check to start.

Huge props to @AaronFeledy for the love and crating the Lando bits

