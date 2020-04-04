# d9-upgrade_status-project

To better prepare for D9 I am rerunning my expertiment of checking everything for readiness.

See the project setup script for instructions on how I set up my environment.

Hit me up on drupal (mcdwayne) or midcamp slack (dwaynemcdaniel) for questions and for the needed CSV, which I am coordinating through google sheets.


to use lando do this:
```
    lando start to build the environment
    lando serve to start the Drupal server
    add settings.php hash salt changes to git and commit
    drop the csv into the project root
    In a new terminal tab, cd to the project then lando check to start.
```
