#!/bin/bash

## Point of this script is to utilize drush upgrade_status:checkstyle

## VERY IMPORTANT STUFF
## 1. composer installed Drupal 8 with `composer create-project drupal/recommended-project my_site_name_dir`
## see: https://www.drupal.org/docs/develop/using-composer/using-composer-to-install-drupal-and-manage-dependencies
##
## 2. installed and started a server with `php ./core/scripts/drupal quick-start demo_umami`
## see: https://www.drupal.org/docs/8/install/drupal-8-quick-start-command
##
## 3. Make sure I have this .csv in place https://github.com/mcdwayne/d9-drupal-check-allthemodules/blob/master/modulelistmachinenames.csv
##
## 4. SUPER VITAL!!!  Fresh installs harden permissions and will not let you rewrite the needed .yml file to let composer work(which is good for prodction, bad for local dev)
## run `chmod u+w web/sites/default` to fix this.
##
## 5. `composer require drush/drush` (I have drush watcher launcher installed too, makes it easy,
## see: https://docs.drush.org/en/master/install/)
##
## 6. `composer require drupal/upgrade_status`
## This is the tool that needs an active running Drupal site from what I could see.
##
## 7. Modify the '/modules/contrib/upgrade_status/src/Commands/UpgradeStatusCommands.php' to enable the `upgrade_status:checkstyle` command
## I am using the update from Gábor Hojtsy (@goba) as found here: https://git.drupalcode.org/project/upgrade_status/blob/8.x-2.x/src/Commands/UpgradeStatusCommands.php
## `curl https://git.drupalcode.org/project/upgrade_status/-/raw/8.x-2.x/src/Commands/UpgradeStatusCommands.php > web/modules/contrib/upgrade_status/src/Commands/UpgradeStatusCommands.php ``
##
## 8. `drush pm:enable upgrade_status -y`(Super important to make drush upgrade_status:checkstyle work)
##
## 9. git init, add, commit and we should be ready to go.. should be...

git checkout master # just make sure.

mkdir reports

## Open the csv of the list of allllllll the modules
INPUT=list.csv

##Safe way to deal with Internal File Separator or IFS resets
OLDIFS=$IFS
IFS=,

## Error if fine not found
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

## Loop through the CSV
while read col1 col2
do
## threw errors if I didn't store this one as a variable, not sure why.
## Store the machine name as a variable
MODULENAME=$col1

## Print to screen just for keeping an eye on progress reasons.
echo $MODULENAME

git checkout -b $MODULENAME

# Install the module with composer
chmod u+w web/sites/default/
composer require ${col2}

/app/vendor/bin/drush si minimal --site-name=test --db-url=mysql://drupal8:drupal8@database:3306/drupal8 -y

# YOU MUST ENABLE THE MODULE TO MAKE upgrade_status:checkstyle work
/app/vendor/bin/drush pm:enable upgrade_status $MODULENAME -y


## Push to a .xml file
/app/vendor/bin/drush upgrade_status:checkstyle ${MODULENAME} > reports/${MODULENAME}.xml

# grep the hash and push it to the bottom of the file...Wait, should I be doing this? Would it matter?
# composer show -i drupal/${MODULENAME} | grep source >> ../reports/${MODULENAME}.xml

# clean up config
/app/vendor/bin/drush pm:uninstall $MODULENAME -y

composer remove ${col2}

rm -rf web/modules/contrib/$MODULENAME

# Cheap way out of dependency hell or awaiting composer remove, just reset back to the last commit.
git reset --hard
git checkout master
git branch -D $MODULENAME

## Done with the loop
done < $INPUT

## reset to the original IFS
IFS=$OLDIFS
