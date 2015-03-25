include_recipe 'apache2'

# node[:mod_php5_apache2][:packages].each do |pkg|
#   package pkg do
#     action :install
#     ignore_failure(pkg.to_s.match(/^php-pear-/) ? true : false) # some pear packages come from EPEL which is not always available
#   end
# end


### begin inserted

# add the webtatic repository
yum_repository "webtatic" do
    description "Webtatic Stable repo"
    baseurl "http://repo.webtatic.com/yum/el6/x86_64/"
    gpgkey "http://repo.webtatic.com/yum/RPM-GPG-KEY-webtatic-andy"
    action :create
end

# remove any existing apache/php/mysql
execute "yum remove -y httpd httpd-tools apr apr-util php* mysql*"

# get the metadata
execute "yum -q makecache"

# manually install php 5.5....
execute "yum install -y httpd24 php55w php55w-devel php55w-cli php55w-snmp php55w-soap php55w-xml php55w-xmlrpc php55w-process php55w-mysqlnd php55w-pecl-memcache php55w-opcache php55w-pdo php55w-imap php55w-mbstring"

### end inserted


node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping deploy::php application #{application} as it is not an PHP app")
    next
  end
  next if node[:deploy][application][:database].nil?

  case node[:deploy][application][:database][:type]
  when "postgresql"
    include_recipe 'mod_php5_apache2::postgresql_adapter'
  else # mysql or just backwards compatible
    include_recipe 'mod_php5_apache2::mysql_adapter'
  end
end

include_recipe 'apache2::mod_php5'
