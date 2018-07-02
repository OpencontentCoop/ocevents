OpenContent Events
========================

OcEvents is an eZPublish Legacy for manage recurring events

## Requirements

   * ezPublish 4.3+
   * ezFind

Installations instructions
------

### Unpack/unzip

Unpack the downloaded package into the `extension` directory of your eZ Publish installation.

### Activate extension

Activate the extension by using the admin interface ( Setup -> Extensions ) or by
prepending `eztags` to `ActiveExtensions[]` in `settings/override/site.ini.append.php`:

    [ExtensionSettings]
    ActiveExtensions[]=ocevents

### Regenerate autoload array

Run the following from your eZ Publish root folder

    php bin/php/ezpgenerateautoloads.php --extension

Or go to Setup -> Extensions and click the "Regenerate autoload arrays" button

### Clear caches

Clear all caches (from admin 'Setup' tab or from command line).

### Configure eZ Find schema for OcEvents extension

To use ocevents you'll need to activate eZ Find and patch the `schema.xml` file inside eZ Find extension with lines below.
Edit the file `extension/ezfind/java/solr/conf/schema.xml` or wherever your solr is hosted:

- add the following inside `<fieldType>`:

  `<fieldType name="date_point" class="solr.SpatialRecursivePrefixTreeFieldType" multiValued="true" geo="false" worldBounds="0 0 2524607999 2524607999" distErrPct="0" maxDistErr="1" units="degrees"/>`
 
- add the following inside `<fields>`:

  `<dynamicField name="*_dp" type="date_point" indexed="true" stored="true"/>`
  
  `<dynamicField name="*____dp" type="date_point" indexed="true" stored="true" multiValued="true"/>`


