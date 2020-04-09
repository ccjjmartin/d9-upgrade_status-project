#!/bin/bash

## Point of this script is to make 2 column csv files 
## with the name 'keyword.csv' 
## that contain the 
## 'names-of-all-the-files-in-folder','count-of-the-keyword-appearance-in-that-file'
##

## Loop through all the xml files in the folder
## and for each, run a report against a keyword check loop.
## Printing things to screen just for keeping an eye on progress reasons.

## First, let's define our keywords

keywords=("library is deprecated")
  


# This is legacy, but I needed an easy way to print a comma, and this was already in place.
# @todo figure out another way to do this? 

OLDIFS=$IFS
IFS=,

## Move to the folder where I am storing the report xml from upgrade_status
## This might e different for you
# @todo ask for directory at beginning?

# let's make sure we can execute and access these folders. Issues popped up at one point and this got rid of intermittent error
cd ../
chmod a+x . ##just make sure

cd d9-module-XML-reports/



#### SEE BOTTOM OF FILE FOR FULL LIST OF DEPRECATIONS  ###################


echo 'total files present'
ls | wc -l
echo ''
echo "running keyword checks on these files"

for f in *.xml
do 

## There are 2 circumstances that it is easier to base on file size rather than grep
## First is zero characters 
##  This is the Parser class of erros that halts composer functioning and breaks tooling
## Second is 37 characters
## those characters are always `<?xml version="1.0"?> <checkstyle/>`
## Not sure why these happen yet (2020-04-08:12:15:00) 

## Get the file size, jjust the first part of the output though, hence the awk
filesizer=`wc -c ${f} | awk '{print $1}'`


# if [ ${filesizer} == '0' ]
# then
#   echo ${f} >> ../testsuite/results/zero-size.csv
# elif [ ${filesizer} == '37' ] 
#   then
#     echo ${f} >> ../testsuite/results/37-size.csv
# else
  for i in "${keywords[@]}"
  do 
  ## generate filename
  outputfilename=`echo ${i} | sed 's/ /-/g'`
  ## Get keywod count and store in a variable
  grepresultcount=`grep -o "${i}" ${f}  | wc -l`
  
  ## show me in stdout what is the count . for logging 
  echo "${grepresultcount} ${i} in ${f}"    
    if [ ${grepresultcount} != 0 ]
    then
       ## print the next line of each csv
      echo "${f}${IFS}${grepresultcount}"  >> ../testsuite/results/${outputfilename}.csv  
## Finally, print to a summary log how many of each thing there are
      grep -v ',0' ../testsuite/results/${outputfilename}.csv | wc -l >> ../testsuite/SUMMARY-COUNT.txt

    fi

  ## finish keyword loop
  done

# ## close the danf if statement
# fi

## finish file loop
done




## reset to the original IFS
IFS=$OLDIFS



#### FULL LIST OF DEPRECATIONS  ###################

################OTHER KEYWORDS: 
# ("deprecated method" "deprecated interface" "deprecated constant" "deprecated function" "deprecated class" "depricated trait" "assertFieldByXPath" "autoloaded" "assertIdentical"  "assertNoText" "does not exist" "deprecate" "drupal_set_message" "entity_get_display" "entity_get_form_display" "entity_view" "Fatal error" "no error" "not found and could not be autoloaded" "severity" "twig" "severity=\"error\"" "composer")

#  Twig specific
# "AbstractExtension::getGlobals" "AbstractExtension::initRuntime" "ExtensionInterface::getGlobals" "ExtensionInterface::initRuntime" "LoaderInterface::getSource" "SafeMarkup::checkPlain" "twig_without"

##"ApcClassLoader" "CommandEvent" "EmptyConstraint" "Factory::createDefaultRepositories" "LinkConstraintInterface" "MultiConstraint" "PackageEvent" "ScriptEvents::POST_PACKAGE_INSTALL" "ScriptEvents::POST_PACKAGE_UNINSTALL" "ScriptEvents::POST_PACKAGE_UPDATE" "ScriptEvents::PRE_PACKAGE_INSTALL" "ScriptEvents::PRE_PACKAGE_UNINSTALL" "ScriptEvents::PRE_PACKAGE_UPDATE" "SpdxLicense" "SpecificConstraint" "Twig_Autoloader" "TYPO3CmsInstaller" "VersionConstraint" "WinCacheClassLoader" "XcacheClassLoader" "XdebugHandler")

## "Twig tag" "Template is attaching a deprecated library" "Theme is extending a deprecated library" "Theme is overriding a deprecated library" "library is depending on a deprecated library" "Parse error in composer" "core requirement is not present in composer" "core requirement is not Drupal 9 compatible" "referenced library is deprecated")

# #"Twig tag" "Template is attaching a deprecated library" "Theme is extending a deprecated library" "Theme is overriding a deprecated library" "library is depending on a deprecated library" "Parse error in composer" "core requirement is not present in composer" "core requirement is not Drupal 9 compatible" "referenced library is deprecated"

#### From: 

# # _system_rebuild_module_data 
# # _system_rebuild_module_data_ensure_required 
# # _toolbar_do_get_rendered_subtrees 
# # _tracker_myrecent_access 
# # _tracker_user_access 
# # _update_equivalent_security_releases 
# # UpdatePathTestBase 
# # UpdateTestBase 
# # UPDATE_CURRENT 
# # UPDATE_FETCH_PENDING 
# # UPDATE_NOT_CHECKED 
# # UPDATE_NOT_CURRENT 
# # UPDATE_NOT_FETCHED 
# # UPDATE_NOT_SECURE 
# # UPDATE_NOT_SUPPORTED 
# # UPDATE_REVOKED 
# # UPDATE_UNKNOWN 
# # UrlAlias 
# # UrlGeneratorTrait 
# # UrlGeneratorTrait::getUrlGenerator 
# # UrlGeneratorTrait::redirect 
# # UrlGeneratorTrait::setUrlGenerator 
# # UrlGeneratorTrait::url 
# # UserCreationTrait 
# # USERNAME_MAX_LENGTH 
# # UserResetEmailTestTrait 
# # UserResourceTestBase 
# # user_delete 
# # user_delete_multiple 
# # user_format_name 
# # user_load 
# # user_load_multiple 
# # USER_REGISTER_ADMINISTRATORS_ONLY 
# # USER_REGISTER_VISITORS 
# # USER_REGISTER_VISITORS_ADMINISTRATIVE_APPROVAL 
# # user_role_load 
# # user_view 
# # user_view_multiple 
# # valid_email_address 
# # ViewKernelTestBase 
# # ViewResourceTestBase 
# # views_pre_render_views_form_views_form 
# # ViewTestBase 
# # VocabularyInterface::getHierarchy 
# # VocabularyInterface::setHierarchy 
# # VocabularyResourceTestBase 
# # WebAssert 
# # WebDriverTestBase::assertElementNotVisible 
# # WebDriverTestBase::assertElementVisible 
# # WebTestBase 
# # WizardTestBase 
# # WorkspaceInterface::DEFAULT_WORKSPACE 
# # WorkspaceInterface::isDefaultWorkspace 
# # _db_get_target 
# # _quickedit_entity_is_latest_revision 
# # _simpletest_run_tests_script_open_browser 
# # TaxonomyTranslationTestTrait 
# # taxonomy_check_vocabulary_hierarchy 
# # TAXONOMY_HIERARCHY_DISABLED 
# # TAXONOMY_HIERARCHY_MULTIPLE 
# # TAXONOMY_HIERARCHY_SINGLE 
# # taxonomy_term_load 
# # taxonomy_term_load_multiple 
# # taxonomy_term_view 
# # taxonomy_term_view_multiple 
# # taxonomy_vocabulary_load 
# # taxonomy_vocabulary_load_multiple 
# # TemporaryTableMapping 
# # Term 
# # TermInterface::getVocabularyId 
# # TermResourceTestBase 
# # TermViewBuilder 
# # TestBase 
# # TestBase::insertAssert 
# # TestDiscovery 
# # TestServiceProvider 
# # TextField 
# # ThemeHandlerInterface::install 
# # ThemeHandlerInterface::setDefault 
# # ThemeHandlerInterface::uninstall 
# # toolbar_prerender_toolbar_administration_tray 
# # ToolkitTestBase 
# # TourResourceTestBase 
# # TourTestBase 
# # TrackerTestBase 
# # TrackerTestBase 
# # tracker_page 
# # TranslationWrapper 
# # TwigExtension::setDateFormatter 
# # TwigExtension::setGenerators 
# # TwigExtension::setThemeManager 
# # TwigExtension::setUrlGenerator 
# # TypeLinkManager 
# # TypeLinkManagerInterface 
# # UITestBase 
# # Unicode::caseFlip 
# # Unicode::setStatus 
# # Unicode::strlen 
# # Unicode::strpos 
# # Unicode::strtolower 
# # Unicode::strtoupper 
# # Unicode::substr 
# # unicode_requirements 
# # UnitTestCase::getBlockMockWithMachineName 
# # UnpublishComment 
# # UnpublishNode 
# # SharedTempStore 
# # SharedTempStoreFactory 
# # ShortcutResourceTestBase 
# # ShortcutSetResourceTestBase 
# # ShortcutTestBase 
# # shortcut_set_assign_user 
# # shortcut_set_title_exists 
# # shortcut_set_unassign_user 
# # simpletest_classloader_register 
# # simpletest_clean_database 
# # simpletest_clean_environment 
# # simpletest_clean_results_table 
# # simpletest_clean_temporary_directories 
# # simpletest_generate_file 
# # simpletest_insert_assert 
# # simpletest_last_test_get 
# # simpletest_log_read 
# # simpletest_phpunit_command 
# # simpletest_phpunit_configuration_filepath 
# # simpletest_phpunit_find_testcases 
# # simpletest_phpunit_run_command 
# # simpletest_phpunit_testcase_to_row 
# # simpletest_phpunit_xml_filepath 
# # simpletest_phpunit_xml_to_rows 
# # simpletest_process_phpunit_results 
# # simpletest_run_phpunit_tests 
# # simpletest_summarize_phpunit_result 
# # simpletest_test_get_all 
# # SqlContentEntityStorage::getFieldStorageDefinitions 
# # SqlContentEntityStorage::storageDefinitionIsDeleted 
# # SqlContentEntityStorageSchemaConverter 
# # StatisticsTestBase 
# # statistics_get 
# # statistics_title_list 
# # SystemConfigFormTestBase 
# # SystemRequirements::phpVersionWithPdoDisallowMultipleStatements 
# # system_get_info 
# # system_list 
# # system_list_reset 
# # system_rebuild_module_data 
# # system_register 
# # tablesort_get_order 
# # tablesort_get_query_parameters 
# # tablesort_get_sort 
# # tablesort_header 
# # tablesort_init 
# # TaxonomyTermReference 
# # TaxonomyTestBase 
# # TaxonomyTestTrait 
# # TaxonomyTestTrait 
# # PluginTestBase 
# # PluralTranslatableMarkup::DELIMITER 
# # PrivateTempStore 
# # PrivateTempStoreFactory 
# # PublishComment 
# # PublishNode 
# # QueryFactory 
# # RandomGeneratorTrait 
# # RdfMappingResourceTestBase 
# # RelationLinkManager 
# # RelationLinkManagerInterface 
# # RequestHandler::getLegacyParameters 
# # ResourceType::updateDeprecatedFieldMapping 
# # ResourceTypeRepository::getFieldMapping 
# # ResponsiveImageStyleResourceTestBase 
# # responsive_image_build_source_attributes 
# # RESPONSIVE_IMAGE_EMPTY_IMAGE 
# # RESPONSIVE_IMAGE_ORIGINAL_IMAGE 
# # RestExport::$authenticationProviders 
# # RestResourceConfigResourceTestBase 
# # RESTTestBase 
# # RoleResourceTestBase 
# # RouteEnhancerInterface 
# # RouteFilterInterface 
# # RouteProvider 
# # SafeMarkup::format 
# # SafeMarkup::isSafe 
# # SaveComment 
# # SaveNode 
# # Schema::fieldSetDefault 
# # Schema::fieldSetNoDefault 
# # SchemaCheckTestTrait 
# # SearchConfigurationRankings 
# # SearchPageResourceTestBase 
# # SearchTestBase 
# # SearchTestBase 
# # SearchTestBase::submitGetForm 
# # search_dirty 
# # search_index 
# # search_index_clear 
# # search_mark_for_reindex 
# # search_update_totals 
# # SectionStorageBase::setSectionList 
# # SectionStorageInterface::extractIdFromRoute 
# # SectionStorageInterface::getSectionListFromId 
# # SectionStorageManagerInterface::loadFromRoute 
# # SectionStorageManagerInterface::loadFromStorageId 
# # SelectInterface::rightJoin 
# # SelectionBase 
# # SessionTestTrait 
# # MissingGroupException 
# # MockEditEntityFieldAccessCheck 
# # ModerationInformationInterface::getLatestRevision 
# # ModerationInformationInterface::getLatestRevisionId 
# # ModerationInformationInterface::isLatestRevision 
# # ModerationOptOutPublishNode 
# # ModerationOptOutUnpublishNode 
# # ModuleHandler::parseDependency 
# # ModuleTestBase 
# # Node::getCckData 
# # NodeAccessControlHandlerInterface::writeGrants 
# # NodeController::add 
# # NodeCreationTrait 
# # NodeForm::updateStatus 
# # NodeInterface::getRevisionAuthor 
# # NodeInterface::setRevisionAuthorId 
# # NodeResourceTestBase 
# # NodeTestBase 
# # NodeTestBase 
# # NodeTypeInterface::isNewRevision 
# # NodeTypeResourceTestBase 
# # node_load 
# # node_load_multiple 
# # NODE_NOT_PROMOTED 
# # NODE_NOT_PUBLISHED 
# # NODE_NOT_STICKY 
# # NODE_PROMOTED 
# # NODE_PUBLISHED 
# # NODE_STICKY 
# # node_type_get_types 
# # node_type_load 
# # node_view 
# # node_view_multiple 
# # NormalizerTestBase 
# # NumberField 
# # OffCanvasTestBase::waitForNoElement 
# # PageCacheTagsTestBase 
# # pager_default_initialize 
# # pager_find_page 
# # pager_get_query_parameters 
# # pager_query_add_page 
# # Path 
# # PathProcessorAlias 
# # PathSubscriber 
# # PathTestBase 
# # PhpunitCompatibilityTrait::getMock 
# # PhpunitCompatibilityTrait::setExpectedException 
# # PlaceBlockPageVariant 
# # PluginInterface 
# # PluginKernelTestBase 
# # KernelTestBase 
# # KernelTestBase::isTestInIsolation 
# # KernelTestBase::__get 
# # LanguageConfigFactoryOverrideInterface::setLanguageFromDefault 
# # language_negotiation_url_domains 
# # language_negotiation_url_prefixes 
# # LayoutBuilderEntityViewDisplay::getRuntimeSections 
# # LayoutEntityHelperTrait::isEntityUsingFieldOverride 
# # LegacyJavascriptTestBase 
# # LegacyMessenger 
# # LibraryDiscoveryParser::fileValidUri 
# # LinkField 
# # LinkField 
# # LinkGeneratorTrait 
# # LinkGeneratorTrait::getLinkGenerator 
# # LinkGeneratorTrait::l 
# # LinkGeneratorTrait::setLinkGenerator 
# # LinkManager 
# # LinkManagerBase 
# # LinkManagerInterface 
# # LinkUri 
# # LOCALE_PLURAL_DELIMITER 
# # locale_translation_manual_status 
# # MediaDeleteMultipleConfirmForm 
# # MediaFunctionalTestCreateMediaTypeTrait 
# # MediaResourceTestBase 
# # MediaTypeResourceTestBase 
# # MenuLinkContentResourceTestBase 
# # MenuLinkParent::$migrationPlugin 
# # MenuResourceTestBase 
# # MenuTestBase 
# # MenuWebTestBase 
# # menu_cache_clear_all 
# # menu_local_tabs 
# # menu_local_tasks 
# # MENU_MAX_MENU_NAME_LENGTH_UI 
# # menu_primary_local_tasks 
# # menu_secondary_local_tasks 
# # MessageResourceTestBase 
# # MigrateCckField 
# # MigrateCckFieldInterface 
# # MigrateCckFieldPluginManager 
# # MigrateCckFieldPluginManagerInterface 
# # MigrateIdMapInterface::getMessageIterator 
# # MigrateIdMapInterface::lookupDestinationId 
# # MigrateSqlSourceTestCase 
# # Migration 
# # Migration::get 
# # MigrationCreationTrait 
# # MigrationLookup::createStubRow 
# # file_valid_uri 
# # FilterFormatPermission::$migrationPlugin 
# # FilterFormatResourceTestBase 
# # filter_form_access_denied 
# # FormattedDateDiff::getMaxAge 
# # format_date 
# # format_string 
# # FormSubmitter::drupalInstallationAttempted 
# # ForumManagerInterface::getParents 
# # FunctionalTestSetupTrait::$configDirectories 
# # GenericCacheBackendUnitTestBase 
# # HandlerTestBase 
# # history_attach_timestamp 
# # hook_path_delete 
# # hook_path_insert 
# # hook_path_update 
# # hook_rest_relation_uri_alter 
# # hook_rest_type_uri_alter 
# # hook_simpletest_alter 
# # hook_test_finished 
# # hook_test_group_finished 
# # hook_test_group_started 
# # I18nProfileField 
# # i18nVariable 
# # Image::chmod 
# # ImageField 
# # ImageField 
# # ImageField 
# # ImageField 
# # ImageFieldTestBase 
# # ImageItem::getEntityManager 
# # ImageStyle::fileUriScheme 
# # ImageStyle::fileUriTarget 
# # ImageStyleInterface::getReplacementID 
# # ImageStyleResourceTestBase 
# # IMAGE_STORAGE_DEFAULT 
# # IMAGE_STORAGE_EDITABLE 
# # IMAGE_STORAGE_MODULE 
# # IMAGE_STORAGE_NORMAL 
# # IMAGE_STORAGE_OVERRIDE 
# # InlineBlockTestBase::waitForNoElement 
# # InstallerTestBase 
# # InstallProfileMismatchException::__construct 
# # install_ensure_config_directory 
# # install_write_profile 
# # InternalUri 
# # ItemHalJsonTestBase 
# # ItemResourceTestBase 
# # Iterator 
# # JavascriptTestBase 
# # FieldPluginBase::processFieldWidget 
# # FieldStorageConfigResourceTestBase 
# # FieldStorageDefinitionInterface::isQueryable 
# # FieldTestBase 
# # FieldTestBase 
# # FieldTypeDefaults 
# # FieldUiTestTrait 
# # FileEntityNormalizer::normalize 
# # FileField 
# # FileField 
# # FileFieldTestBase 
# # FileManagedTestBase 
# # FileResourceTestBase 
# # FileStorage::htaccessLines 
# # FileStorageFactory::getActive 
# # FileSystemInterface::uriScheme 
# # FileSystemInterface::validScheme 
# # FileUploadHalJsonTestBase 
# # FILE_CHMOD_DIRECTORY 
# # FILE_CHMOD_FILE 
# # FILE_CREATE_DIRECTORY 
# # file_create_filename 
# # file_default_scheme 
# # file_delete 
# # file_delete_multiple 
# # file_destination 
# # file_directory_os_temp 
# # file_directory_temp 
# # file_ensure_htaccess 
# # FILE_EXISTS_ERROR 
# # FILE_EXISTS_RENAME 
# # FILE_EXISTS_REPLACE 
# # file_htaccess_lines 
# # file_load 
# # file_load_multiple 
# # FILE_MODIFY_PERMISSIONS 
# # file_prepare_directory 
# # file_save_htaccess 
# # file_scan_directory 
# # file_stream_wrapper_uri_normalize 
# # file_stream_wrapper_valid_scheme 
# # file_unmanaged_copy 
# # file_unmanaged_delete 
# # file_unmanaged_delete_recursive 
# # file_unmanaged_move 
# # file_unmanaged_prepare 
# # file_unmanaged_save_data 
# # file_upload_max_size 
# # file_uri_scheme 
# # file_uri_target 
# # EntityReference 
# # EntityReference 
# # EntityReferenceTestTrait 
# # EntityTestBundleResourceTestBase 
# # EntityTestLabelResourceTestBase 
# # EntityTestResourceTestBase 
# # EntityType::$label_callback 
# # EntityTypeInterface::getLabelCallback 
# # EntityTypeInterface::getLowercaseLabel 
# # EntityTypeInterface::hasLabelCallback 
# # EntityTypeInterface::isSubclassOf 
# # EntityTypeInterface::setLabelCallback 
# # EntityTypeRepositoryInterface::clearCachedDefinitions 
# # EntityUnitTestBase 
# # EntityViewDisplayResourceTestBase 
# # EntityViewModeResourceTestBase 
# # EntityWithUriCacheTagsTestBase 
# # entity_create 
# # entity_delete_multiple 
# # entity_get_bundles 
# # entity_get_display 
# # entity_get_form_display 
# # entity_load 
# # entity_load_multiple 
# # entity_load_multiple_by_properties 
# # entity_load_unchanged 
# # entity_page_label 
# # entity_render_cache_clear 
# # entity_revision_delete 
# # entity_revision_load 
# # entity_test_load 
# # entity_test_mulrev_load 
# # entity_test_mul_load 
# # entity_test_rev_load 
# # entity_view 
# # entity_view_multiple 
# # ExpectDeprecationTrait::expectDeprecation 
# # FakeRecord 
# # FeedHalJsonTestBase 
# # FeedResourceTestBase 
# # Field 
# # FieldAPIHandlerTrait::getEntityManager 
# # FieldConfigResourceTestBase 
# # FieldFile::$migrationPlugin 
# # FieldLink 
# # FieldMigration::PLUGIN_METHOD 
# # FieldPluginBase::processField 
# # FieldPluginBase::processFieldFormatter 
# # FieldPluginBase::processFieldInstance 
# # FieldPluginBase::processFieldValues 
# # EntityManager::getCanonicalMultiple 
# # EntityManager::getDefinition 
# # EntityManager::getDefinitions 
# # EntityManager::getEntityTypeFromClass 
# # EntityManager::getEntityTypeLabels 
# # EntityManager::getExtraFields 
# # EntityManager::getFieldDefinitions 
# # EntityManager::getFieldMap 
# # EntityManager::getFieldMapByFieldType 
# # EntityManager::getFieldStorageDefinitions 
# # EntityManager::getFormDisplay 
# # EntityManager::getFormModeOptions 
# # EntityManager::getFormModeOptionsByBundle 
# # EntityManager::getFormModes 
# # EntityManager::getFormObject 
# # EntityManager::getHandler 
# # EntityManager::getInstance 
# # EntityManager::getLastInstalledDefinition 
# # EntityManager::getLastInstalledFieldStorageDefinitions 
# # EntityManager::getListBuilder 
# # EntityManager::getRouteProviders 
# # EntityManager::getStorage 
# # EntityManager::getTranslationFromContext 
# # EntityManager::getViewBuilder 
# # EntityManager::getViewDisplay 
# # EntityManager::getViewModeOptions 
# # EntityManager::getViewModeOptionsByBundle 
# # EntityManager::getViewModes 
# # EntityManager::hasDefinition 
# # EntityManager::hasHandler 
# # EntityManager::loadEntityByConfigTarget 
# # EntityManager::loadEntityByUuid 
# # EntityManager::onBundleCreate 
# # EntityManager::onBundleDelete 
# # EntityManager::onEntityTypeDelete 
# # EntityManager::onEntityTypeUpdate 
# # EntityManager::onFieldableEntityTypeCreate 
# # EntityManager::onFieldableEntityTypeUpdate 
# # EntityManager::onFieldDefinitionCreate 
# # EntityManager::onFieldDefinitionDelete 
# # EntityManager::onFieldDefinitionUpdate 
# # EntityManager::onFieldStorageDefinitionCreate 
# # EntityManager::onFieldStorageDefinitionDelete 
# # EntityManager::onFieldStorageDefinitionUpdate 
# # EntityManager::setFieldMap 
# # EntityManagerInterface 
# # EntityManagerInterface::getLastInstalledDefinition 
# # EntityManagerInterface::getLastInstalledFieldStorageDefinitions 
# # EntityReference 
# # EntityReference 
# # drupal_set_message 
# # drupal_set_time_limit 
# # drupal_tempnam 
# # drupal_unlink 
# # DRUPAL_USER_TIMEZONE_DEFAULT 
# # DRUPAL_USER_TIMEZONE_EMPTY 
# # DRUPAL_USER_TIMEZONE_SELECT 
# # drupal_validate_utf8 
# # drupal_xml_parser_create 
# # EditEntityFieldAccessCheck 
# # EditEntityFieldAccessCheckInterface 
# # EditorResourceTestBase 
# # element_info 
# # element_info_property 
# # Email 
# # Entity 
# # EntityBase::entityManager 
# # EntityCacheTagsTestBase 
# # EntityConverter::getLatestTranslationAffectedRevision 
# # EntityConverter::loadRevision 
# # EntityDefinitionTestTrait 
# # EntityDefinitionUpdateManagerInterface::applyUpdates 
# # EntityDisplayBase::handleHiddenType 
# # EntityDisplayFormBase::reduceOrder 
# # EntityDisplayFormBase::tablePreRender 
# # EntityFieldStorageConfig 
# # EntityFormDisplayResourceTestBase 
# # EntityFormInterface::setEntityManager 
# # EntityFormModeResourceTestBase 
# # EntityInterface::link 
# # EntityInterface::url 
# # EntityInterface::urlInfo 
# # EntityListBuilder::getLabel 
# # EntityManager::clearCachedBundles 
# # EntityManager::clearCachedDefinitions 
# # EntityManager::clearCachedFieldDefinitions 
# # EntityManager::clearDisplayModeInfo 
# # EntityManager::createHandlerInstance 
# # EntityManager::createInstance 
# # EntityManager::getAccessControlHandler 
# # EntityManager::getActive 
# # EntityManager::getActiveDefinition 
# # EntityManager::getActiveFieldStorageDefinitions 
# # EntityManager::getActiveMultiple 
# # EntityManager::getAllBundleInfo 
# # EntityManager::getAllFormModes 
# # EntityManager::getAllViewModes 
# # EntityManager::getBaseFieldDefinitions 
# # EntityManager::getBundleInfo 
# # EntityManager::getCanonical 
# # db_query 
# # db_query_range 
# # db_query_temporary 
# # db_rename_table 
# # db_select 
# # db_set_active 
# # db_table_exists 
# # db_transaction 
# # db_truncate 
# # db_update 
# # db_xor 
# # DedupeBase 
# # DedupeEntity 
# # DeleteComment 
# # DeleteNode 
# # deprecation_test_function 
# # DisplayPluginBase::applyDisplayCachablityMetadata 
# # Drupal::entityManager 
# # Drupal::l 
# # Drupal::url 
# # DrupalKernelInterface::prepareLegacyRequest 
# # DRUPAL_ANONYMOUS_RID 
# # DRUPAL_AUTHENTICATED_RID 
# # drupal_basename 
# # drupal_check_incompatibility 
# # drupal_chmod 
# # drupal_classloader_register 
# # drupal_clear_css_cache 
# # drupal_clear_js_cache 
# # drupal_dirname 
# # drupal_get_destination 
# # drupal_get_messages 
# # drupal_get_profile 
# # drupal_get_user_timezone 
# # drupal_http_header_attributes 
# # drupal_installation_attempted 
# # drupal_install_config_directories 
# # drupal_mkdir 
# # drupal_move_uploaded_file 
# # DRUPAL_PHP_FUNCTION_PATTERN 
# # drupal_placeholder 
# # drupal_pre_render_link 
# # drupal_pre_render_links 
# # drupal_process_states 
# # drupal_realpath 
# # drupal_render 
# # drupal_render_children 
# # drupal_render_root 
# # drupal_rmdir 
# # drupal_schema_get_field_value 
# # ContentTranslationUpdatesManager 
# # ContentTypeCreationTrait 
# # ContextAwarePluginBase::$contexts 
# # ControllerBase::entityManager 
# # Crypt::hashEquals 
# # Crypt::randomBytes 
# # D6VariableTranslation 
# # DatabaseWebTestBase 
# # DateField 
# # DateFormatResourceTestBase 
# # DateTestBase 
# # DateTimeHandlerTestBase 
# # DATETIME_DATETIME_STORAGE_FORMAT 
# # datetime_date_default_time 
# # DATETIME_DATE_STORAGE_FORMAT 
# # datetime_range_view_presave 
# # DATETIME_STORAGE_TIMEZONE 
# # date_iso8601 
# # dblog_view_presave 
# # DbUpdatesTrait 
# # db_add_field 
# # db_add_index 
# # db_add_primary_key 
# # db_add_unique_key 
# # db_and 
# # db_change_field 
# # db_close 
# # db_condition 
# # db_create_table 
# # db_delete 
# # db_driver 
# # db_drop_field 
# # db_drop_index 
# # db_drop_primary_key 
# # db_drop_table 
# # db_drop_unique_key 
# # db_escape_field 
# # db_escape_table 
# # db_field_exists 
# # db_field_names 
# # db_field_set_default 
# # db_field_set_no_default 
# # db_find_tables 
# # db_ignore_replica 
# # db_index_exists 
# # db_insert 
# # db_like 
# # db_merge 
# # db_next_id 
# # db_or 
# # block_place.module 
# # Book 
# # BootstrapConfigStorageFactory::getFileStorage 
# # BrowserTestBase 
# # BrowserTestBase::drupalGetHeaders 
# # BulkForm 
# # Cache::validateTags 
# # CacheTestBase 
# # CckFieldPluginBase 
# # CckFile 
# # CckLink 
# # CckMigration 
# # check_url 
# # color_block_view_pre_render 
# # CommentHalJsonTestBase 
# # CommentInterface::getStatus 
# # CommentResourceTestBase 
# # CommentTestBase 
# # CommentTestBase 
# # CommentType 
# # CommentTypeResourceTestBase 
# # CommentVariable 
# # CommentVariablePerCommentType 
# # COMMENT_ANONYMOUS_MAYNOT_CONTACT 
# # COMMENT_ANONYMOUS_MAY_CONTACT 
# # COMMENT_ANONYMOUS_MUST_CONTACT 
# # comment_view 
# # comment_view_multiple 
# # ConfigAfterInstallerTestBase 
# # ConfigDependencyManager::sortGraph 
# # ConfigDependencyManager::sortGraphByWeight 
# # ConfigInstaller::drupalInstallationAttempted 
# # ConfigManagerInterface::getEntityManager 
# # ConfigSchemaChecker 
# # ConfigSync::finishBatch 
# # ConfigSync::processBatch 
# # ConfigTestResourceTestBase 
# # ConfigurableEntityReferenceItem 
# # ConfigurableLanguageResourceTestBase 
# # ConfigurableLinkManagerInterface 
# # CONFIG_ACTIVE_DIRECTORY 
# # config_get_config_directory 
# # CONFIG_STAGING_DIRECTORY 
# # CONFIG_SYNC_DIRECTORY 
# # Constraint::toArray 
# # ContactFormResourceTestBase 
# # ContentEntityStorageBase::doLoadRevisionFieldItems 
# # ContentLanguageSettingsResourceTestBase 
# # ContentTranslationTestBase 
# # ContentTranslationUITestBase 
# # $config_directories 
# # AccessResult::cacheUntilConfigurationChanges 
# # AccessResult::cacheUntilEntityChanges 
# # AccountInterface::getUsername 
# # AccountProxy::$initialAccountId 
# # ActionAddForm 
# # ActionEditForm 
# # ActionFormBase 
# # ActionResourceTestBase 
# # ActiveTheme::$baseThemes 
# # ActiveTheme::getBaseThemes 
# # ActiveTheme::getStyleSheetsRemove 
# # AggregatorTestBase 
# # AGGREGATOR_CLEAR_NEVER 
# # AjaxRenderer::drupalRenderRoot 
# # AliasManager 
# # AliasManagerInterface 
# # AliasRepository 
# # AliasRepositoryInterface 
# # AliasStorage 
# # AliasStorageInterface 
# # AliasWhitelist 
# # AliasWhitelistInterface 
# # AllowedTagsXssTrait 
# # archiver_get_archiver 
# # archiver_get_extensions 
# # AssertBreadcrumbTrait 
# # AssertButtonsTrait 
# # AssertConfigEntityImportTrait 
# # AssertContentTrait 
# # AssertHelperTrait 
# # AssertMenuActiveTrailTrait 
# # AssertPageCacheContextsAndTagsTrait 
# # BaseFieldDefinition::getFieldItemClass 
# # BaseFieldDefinition::setQueryable 
# # BaseFieldOverrideResourceTestBase 
# # BasicAuthTestTrait 
# # BlockContentInterface::getRevisionLog 
# # BlockContentInterface::setRevisionLog 
# # BlockContentResourceTestBase 
# # BlockContentTestBase 
# # BlockContentTestBase 
# # BlockContentTypeResourceTestBase 
# # BlockCreationTrait 
# # BlockInterface::BLOCK_LABEL_VISIBLE 
# # BlockInterface::BLOCK_REGION_NONE 
# # BlockPluginId::$migrationPlugin 
# # BlockResourceTestBase 
# # BlockTestBase 
# # BlockVisibility::$migrationPlugin 
# # 