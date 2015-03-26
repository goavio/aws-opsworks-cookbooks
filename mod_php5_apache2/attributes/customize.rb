###
# This is the place to override the mod_php5_apache2 cookbook's default attributes.
#
# Do not edit THIS file directly. Instead, create
# "mod_php5_apache2/attributes/customize.rb" in your cookbook repository and
# put the overrides in YOUR customize.rb file.
###

# The following shows how to override the mod_php5_apache2 packages:
#
default[:mod_php5_apache2][:packages] = [ 
	'php55w', 
	'php55w-devel', 
	'php55w-cli', 
	'php55w-snmp', 
	'php55w-soap', 
	'php55w-xml', 
	'php55w-xmlrpc', 
	'php55w-process', 
	'php55w-mysqlnd', 
	'php55w-pecl-memcache', 
	'php55w-opcache', 
	'php55w-pdo', 
	'php55w-imap', 
	'php55w-mbstring'
]