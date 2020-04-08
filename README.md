# d9-upgrade_status-project

To better prepare for D9 I am rerunning my expertiment of checking everything for readiness.  

## This repo is to replicate me experiment

[The final rresults are more easily seen/parced over on the google sheet for this report.](https://docs.google.com/spreadsheets/d/1SLWkzOBSZxII2PAupWpKO6e6NZZXAFJ0RSntFugBcDc/edit#gid=677506986)


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


#### Not using Lando

1. Clone down the repo
2. $ `chmod +x D9-setup-script.sh`
3. $`./D9-setup-script.sh`
4. $ `cd YOUR_SITE_NAME`
5. $ `php ./web/core/scripts/drupal quick-start minimal`
6. $ `chmod u+w web/sites/default`
7. copy in a CSV of name `modulemachinename1.csv` into this directory
8. $ `drush pm:enable upgrade_status -y`
9. $ `git init`
10. $ `git add .`
11. $ `git commit -m 'initial state`
12. $`./d9upgrade_statuscheckall.sh`

If that messes up, sorry


#### Reporting

You will see there is a folder called `testsuite` and a folder called `d9-module-XML-reports`

testsuite contains the report generating script and the results folder to store the results. 
The script `errorcount` should run from here, as it will look for files in `../d9-module-XML-reports`

You can add any keywords you like to the array in that script, just make sure it is in "".  Even handles spaces pretty well, but watch for special `grep` escape characters an prepend with `\` as needed. 

These results that I included [are more easily seen over on the google sheet for this report.](https://docs.google.com/spreadsheets/d/1SLWkzOBSZxII2PAupWpKO6e6NZZXAFJ0RSntFugBcDc/edit#gid=677506986)




