#!/bin/bash

## VERY IMPORTANT STUFF
##
## Make sure this is true on ubuntu: 'sudo apt-get install php php-curl php-gd php-mbstring php-sqlite3'
## might need another lbrary but I forgot to document as I went...
##
## 1. composer installed Drupal 8 with `composer create-project drupal/recommended-project my_site_name_dir`
## see: https://www.drupal.org/docs/develop/using-composer/using-composer-to-install-drupal-and-manage-dependencies
##
## 2. installed and started a server with lando
##
## 3. Make sure I have this .csv in place https://github.com/mcdwayne/d9-drupal-check-allthemodules/blob/master/modulelistmachinenames.csv AND the checkall script in place.
##
## 8. `drush pm:enable upgrade_status -y`(Super important to make drush upgrade_status:checkstyle work)
##
## 9. git init, add, commit and we should be ready to go.. should be...
## I called my repo


## what should we call this one?

if [ -z "$1" ]; then
	echo -n "Name your post as a single dash-connected-string, leave off the suffix please:  " && read SITENAME
else
	SITENAME=$1
fi


## Composer install the site
composer create-project drupal/recommended-project ${SITENAME}


## cd

cd ${SITENAME}

php ./web/core/scripts/drupal quick-start minimal &
sleep 10


echo 'make sure modulelistmachinenames1.csv and script is in place'

cp ~/Documents/modulelistmachinenames1.csv .
cp ~/Documents/d9upgrade_statuscheckall.sh .

chmod u+w web/sites/default

composer require drush/drush
composer require drupal/upgrade_status

curl https://git.drupalcode.org/project/upgrade_status/-/raw/8.x-2.x/src/Commands/UpgradeStatusCommands.php > web/modules/contrib/upgrade_status/src/Commands/UpgradeStatusCommands.php



drush pm:enable upgrade_status -y

git init
git add .
git rm --cached web/modules/contrib/git_deploy
git commit -m 'initial commit'

echo 'shold be set up right??  Check that csv'
