#!/bin/bash

## Point of this script is to make 2 column csv files 
## with the name 'keyword.csv' 
## that contain the 
## 'names-of-all-the-files-in-folder','count-of-the-keyword-appearance-in-that-file'
##

# let's make sure we can execute and access these folders. Issues popped up at one point and this got rid of intermittent error
chmod a+x . ##just make sure

# This is legacy, but I needed an easy way to print a comma, and this was already in place.
# @todo figure out another way to do this? 

OLDIFS=$IFS
IFS=,

## Move to the folder where I am storing the report xml from upgrade_status
## This might e different for you
# @todo ask for directory at beginning?

cd ../d9-module-XML-reports

## Loop through all the xml files in the folder
## and for each, run a report against a keyword check loop.
## Printing things to screen just for keeping an eye on progress reasons.

## First, let's define our keywords

keywords=("UrlGeneratorTrait::getUrlGenerator" "UrlGeneratorTrait::redirect" "UrlGeneratorTrait::setUrlGenerator" "UrlGeneratorTrait::url" "VocabularyInterface::getHierarchy" "VocabularyInterface::setHierarchy" "WebDriverTestBase::assertElementNotVisible" "WebDriverTestBase::assertElementVisible" "WorkspaceInterface::DEFAULT_WORKSPACE" "WorkspaceInterface::isDefaultWorkspace" "TermInterface::getVocabularyId" "TestBase::insertAssert" "ThemeHandlerInterface::install" "ThemeHandlerInterface::setDefault" "ThemeHandlerInterface::uninstall" "TwigExtension::setDateFormatter" "TwigExtension::setGenerators" "TwigExtension::setThemeManager" "TwigExtension::setUrlGenerator" "Unicode::caseFlip" "Unicode::setStatus" "Unicode::strlen" "Unicode::strpos" "Unicode::strtolower" "Unicode::strtoupper" "Unicode::substr" "UnitTestCase::getBlockMockWithMachineName" "SqlContentEntityStorage::getFieldStorageDefinitions" "SqlContentEntityStorage::storageDefinitionIsDeleted" "SystemRequirements::phpVersionWithPdoDisallowMultipleStatements" "PluralTranslatableMarkup::DELIMITER" "RequestHandler::getLegacyParameters" "ResourceType::updateDeprecatedFieldMapping" "ResourceTypeRepository::getFieldMapping" "RestExport::\$authenticationProviders" "SafeMarkup::format" "SafeMarkup::isSafe" "Schema::fieldSetDefault" "Schema::fieldSetNoDefault" "SearchTestBase::submitGetForm" "SectionStorageBase::setSectionList" "SectionStorageInterface::extractIdFromRoute" "SectionStorageInterface::getSectionListFromId" "SectionStorageManagerInterface::loadFromRoute" "SectionStorageManagerInterface::loadFromStorageId" "SelectInterface::rightJoin" "ModerationInformationInterface::getLatestRevision" "ModerationInformationInterface::getLatestRevisionId" "ModerationInformationInterface::isLatestRevision" "ModuleHandler::parseDependency" "Node::getCckData" "NodeAccessControlHandlerInterface::writeGrants" "NodeController::add" "NodeForm::updateStatus" "NodeInterface::getRevisionAuthor" "NodeInterface::setRevisionAuthorId" "NodeTypeInterface::isNewRevision" "OffCanvasTestBase::waitForNoElement" "PhpunitCompatibilityTrait::getMock" "PhpunitCompatibilityTrait::setExpectedException" "KernelTestBase::isTestInIsolation" "KernelTestBase::__get" "LanguageConfigFactoryOverrideInterface::setLanguageFromDefault" "LayoutBuilderEntityViewDisplay::getRuntimeSections" "LayoutEntityHelperTrait::isEntityUsingFieldOverride" "LibraryDiscoveryParser::fileValidUri" "LinkGeneratorTrait::getLinkGenerator" "LinkGeneratorTrait::l" "LinkGeneratorTrait::setLinkGenerator" "MenuLinkParent::\$migrationPlugin" "MigrateIdMapInterface::getMessageIterator" "MigrateIdMapInterface::lookupDestinationId" "Migration::get" "MigrationLookup::createStubRow" "FilterFormatPermission::\$migrationPlugin" "FormattedDateDiff::getMaxAge" "FormSubmitter::drupalInstallationAttempted" "ForumManagerInterface::getParents" "FunctionalTestSetupTrait::\$configDirectories" "Image::chmod" "ImageItem::getEntityManager" "ImageStyle::fileUriScheme" "ImageStyle::fileUriTarget" "ImageStyleInterface::getReplacementID" "InlineBlockTestBase::waitForNoElement" "InstallProfileMismatchException::__construct" "FieldPluginBase::processFieldWidget" "FieldStorageDefinitionInterface::isQueryable" "FileEntityNormalizer::normalize" "FileStorage::htaccessLines" "FileStorageFactory::getActive" "FileSystemInterface::uriScheme" "FileSystemInterface::validScheme" "EntityType::\$label_callback" "EntityTypeInterface::getLabelCallback" "EntityTypeInterface::getLowercaseLabel" "EntityTypeInterface::hasLabelCallback" "EntityTypeInterface::isSubclassOf" "EntityTypeInterface::setLabelCallback" "EntityTypeRepositoryInterface::clearCachedDefinitions" "ExpectDeprecationTrait::expectDeprecation" "FieldAPIHandlerTrait::getEntityManager" "FieldFile::\$migrationPlugin" "FieldMigration::PLUGIN_METHOD" "FieldPluginBase::processField" "FieldPluginBase::processFieldFormatter" "FieldPluginBase::processFieldInstance" "FieldPluginBase::processFieldValues" "EntityManager::getCanonicalMultiple" "EntityManager::getDefinition" "EntityManager::getDefinitions" "EntityManager::getEntityTypeFromClass" "EntityManager::getEntityTypeLabels" "EntityManager::getExtraFields" "EntityManager::getFieldDefinitions" "EntityManager::getFieldMap" "EntityManager::getFieldMapByFieldType" "EntityManager::getFieldStorageDefinitions" "EntityManager::getFormDisplay" "EntityManager::getFormModeOptions" "EntityManager::getFormModeOptionsByBundle" "EntityManager::getFormModes" "EntityManager::getFormObject" "EntityManager::getHandler" "EntityManager::getInstance" "EntityManager::getLastInstalledDefinition" "EntityManager::getLastInstalledFieldStorageDefinitions" "EntityManager::getListBuilder" "EntityManager::getRouteProviders" "EntityManager::getStorage" "EntityManager::getTranslationFromContext" "EntityManager::getViewBuilder" "EntityManager::getViewDisplay" "EntityManager::getViewModeOptions" "EntityManager::getViewModeOptionsByBundle" "EntityManager::getViewModes" "EntityManager::hasDefinition" "EntityManager::hasHandler" "EntityManager::loadEntityByConfigTarget" "EntityManager::loadEntityByUuid" "EntityManager::onBundleCreate" "EntityManager::onBundleDelete" "EntityManager::onEntityTypeDelete" "EntityManager::onEntityTypeUpdate" "EntityManager::onFieldableEntityTypeCreate" "EntityManager::onFieldableEntityTypeUpdate" "EntityManager::onFieldDefinitionCreate" "EntityManager::onFieldDefinitionDelete" "EntityManager::onFieldDefinitionUpdate" "EntityManager::onFieldStorageDefinitionCreate" "EntityManager::onFieldStorageDefinitionDelete" "EntityManager::onFieldStorageDefinitionUpdate" "EntityManager::setFieldMap" "EntityManagerInterface::getLastInstalledDefinition" "EntityManagerInterface::getLastInstalledFieldStorageDefinitions" "EntityBase::entityManager" "EntityConverter::getLatestTranslationAffectedRevision" "EntityConverter::loadRevision" "EntityDefinitionUpdateManagerInterface::applyUpdates" "EntityDisplayBase::handleHiddenType" "EntityDisplayFormBase::reduceOrder" "EntityDisplayFormBase::tablePreRender" "EntityFormInterface::setEntityManager" "EntityInterface::link" "EntityInterface::url" "EntityInterface::urlInfo" "EntityListBuilder::getLabel" "EntityManager::clearCachedBundles" "EntityManager::clearCachedDefinitions" "EntityManager::clearCachedFieldDefinitions" "EntityManager::clearDisplayModeInfo" "EntityManager::createHandlerInstance" "EntityManager::createInstance" "EntityManager::getAccessControlHandler" "EntityManager::getActive" "EntityManager::getActiveDefinition" "EntityManager::getActiveFieldStorageDefinitions" "EntityManager::getActiveMultiple" "EntityManager::getAllBundleInfo" "EntityManager::getAllFormModes" "EntityManager::getAllViewModes" "EntityManager::getBaseFieldDefinitions" "EntityManager::getBundleInfo" "EntityManager::getCanonical" "DisplayPluginBase::applyDisplayCachablityMetadata" "Drupal::entityManager" "Drupal::l" "Drupal::url" "DrupalKernelInterface::prepareLegacyRequest" "ContextAwarePluginBase::\$contexts" "ControllerBase::entityManager" "Crypt::hashEquals" "Crypt::randomBytes" "BootstrapConfigStorageFactory::getFileStorage" "BrowserTestBase::drupalGetHeaders" "Cache::validateTags" "CommentInterface::getStatus" "ConfigDependencyManager::sortGraph" "ConfigDependencyManager::sortGraphByWeight" "ConfigInstaller::drupalInstallationAttempted" "ConfigManagerInterface::getEntityManager" "ConfigSync::finishBatch" "ConfigSync::processBatch" "Constraint::toArray" "ContentEntityStorageBase::doLoadRevisionFieldItems" "AccessResult::cacheUntilConfigurationChanges" "AccessResult::cacheUntilEntityChanges" "AccountInterface::getUsername" "AccountProxy::\$initialAccountId" "ActiveTheme::\$baseThemes" "ActiveTheme::getBaseThemes" "ActiveTheme::getStyleSheetsRemove" "AjaxRenderer::drupalRenderRoot" "BaseFieldDefinition::getFieldItemClass" "BaseFieldDefinition::setQueryable" "BlockContentInterface::getRevisionLog" "BlockContentInterface::setRevisionLog" "BlockInterface::BLOCK_LABEL_VISIBLE" "BlockInterface::BLOCK_REGION_NONE" "BlockPluginId::\$migrationPlugin" "BlockVisibility::\$migrationPlugin" "AssertHelperTrait" "AssertMenuActiveTrailTrait" "AssertPageCacheContextsAndTagsTrait" "BaseFieldOverrideResourceTestBase" "BasicAuthTestTrait" "BlockContentResourceTestBase" "BlockContentTestBase" "BlockContentTestBase" "BlockContentTypeResourceTestBase" "BlockCreationTrait""BlockResourceTestBase" "BlockTestBase" )

# ("deprecated method" "deprecated interface" "deprecated constant" "deprecated function" "deprecated class" "depricated trait" "assertFieldByXPath" "autoloaded" "assertIdentical"  "assertNoText" "does not exist" "deprecate" "drupal_set_message" "entity_get_display" "entity_get_form_display" "entity_view" "Fatal error" "no error" "not found and could not be autoloaded" "severity" "twig" "severity=\"error\"" "composer")

echo 'total files present'
ls | wc -l
echo ''
echo "running keyword checks on these files"

for f in *.xml
do 
chmod a+x . ##just make sure

## There are 2 circumstances that it is easier to base on file size rather than grep
## First is zero characters 
##  This is the Parser class of erros that halts composer functioning and breaks tooling
## Second is 37 characters
## those characters are always `<?xml version="1.0"?> <checkstyle/>`
## Not sure why these happen yet (2020-04-08:12:15:00) 

## Get the file size, jjust the first part of the output though, hence the awk
filesizer=`wc -c ${f} | awk '{print $1}'`


if [ ${filesizer} == '0' ]
then
  echo ${f} >> ../testsuite/results/zero-size.csv
elif [ ${filesizer} == '37' ] 
  then
    echo ${f} >> ../testsuite/results/37-size.csv
else
  echo ''

## close the danf if statement
fi

###make the dang csvs already!

  for i in "${keywords[@]}"
  do 
  ## generate filename
  outputfilename=`echo ${i} | sed 's/ /-/g'`
  ## Get keywod count and store in a variable
  grepresultcount=`grep -o "${i}" ${f}  | wc -l`
  ## print the next line of each csv
  echo "${f}${IFS}${grepresultcount}'='${i}"
  echo "${f}${IFS}${grepresultcount}"  >> ../testsuite/results/${outputfilename}.csv  

## Finally, print to a summary log how many of each thing there are
  grep -v ',0' ../testsuite/results/${outputfilename}.csv | wc -l >> ../testsuite/SUMMARY-COUNT.txt

  ## finish keyword loop
  done



## finish file loop
done




## reset to the original IFS
IFS=$OLDIFS
