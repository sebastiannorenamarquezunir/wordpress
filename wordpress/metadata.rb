name 'wordpress'
maintainer 'Oscar Eduardo Saavedra Tarazonat - Yeisson Jimenez Bustos Harry - Mauricio Cuesta Gamboa - Sebastián Noreña Márquez '
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures wordpress'
version '0.1.0'
chef_version '>= 16.0'
depends 'mysql', '~> 8.5.1'

attribute "wordpress/version",
  :display_name => "Wordpress download version",
  :description => "Version of Wordpress to download from the Wordpress site.",
  :default => "3.0.4"
  
attribute "wordpress/checksum",
  :display_name => "Wordpress tarball checksum",
  :description => "Checksum of the tarball for the version specified.",
  :default => "7342627f4a3dca44886c5aca6834cc88671dbd3aa2760182d2fcb9a330807"
  
attribute "wordpress/dir",
  :display_name => "Wordpress installation directory",
  :description => "Location to place wordpress files.",
  :default => "/var/www"
  
attribute "wordpress/db/database",
  :display_name => "Wordpress MySQL database",
  :description => "Wordpress will use this MySQL database to store its data.",
  :default => "wordpressdb"

attribute "wordpress/db/user",
  :display_name => "Wordpress MySQL user",
  :description => "Wordpress will connect to MySQL using this user.",
  :default => "wordpressuser"

attribute "wordpress/db/password",
  :display_name => "Wordpress MySQL password",
  :description => "Password for the Wordpress MySQL user.",
  :default => "randomly generated"

attribute "wordpress/keys/auth",
  :display_name => "Wordpress auth key",
  :description => "Wordpress auth key.",
  :default => "randomly generated"

attribute "wordpress/keys/secure_auth",
  :display_name => "Wordpress secure auth key",
  :description => "Wordpress secure auth key.",
  :default => "randomly generated"

attribute "wordpress/keys/logged_in",
  :display_name => "Wordpress logged-in key",
  :description => "Wordpress logged-in key.",
  :default => "randomly generated"

attribute "wordpress/keys/nonce",
  :display_name => "Wordpress nonce key",
  :description => "Wordpress nonce key.",
  :default => "randomly generated"
  
attribute "wordpress/server_aliases",
  :display_name => "Wordpress Server Aliases",
  :description => "Wordpress Server Aliases",
  :default => "FQDN"

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/wordpress/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/wordpress'
