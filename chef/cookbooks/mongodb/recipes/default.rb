#
# Cookbook:: mongodb
# Recipe:: default
#
# Installs MongoDB, writes its config, and brings up a single-node replica set.

package 'mongodb-org' do
  action :install
end

directory node['mongodb']['data_dir'] do
  owner 'mongodb'
  group 'mongodb'
  recursive true
end

execute 'enable-mongod' do
  command 'systemctl enable mongod'
end

bash 'init-replica-set' do
  code <<-EOH
    mongo --eval "rs.initiate()"
  EOH
end

template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'mongod' do
  action [:start]
end
