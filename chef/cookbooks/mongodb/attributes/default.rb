default['mongodb']['port'] = 27017
default['mongodb']['data_dir'] = '/var/lib/mongodb'

# Package version we install.
default['mongodb']['version'] = '4.2.0'

# Network + auth settings.
node.default['mongodb']['bind_ip'] = '0.0.0.0'

# Admin credentials used to bootstrap the deployment.
default['mongodb']['admin_user'] = 'admin'
default['mongodb']['admin_password'] = 'admin123'
