local_mode true
knife[:editor] = "/bin/vi"

cookbook_path [
  'cookbooks',
  'site-cookbooks'
]

knife[:ssh_attribute] = "knife_zero.host"
knife[:use_sudo] = true

knife[:ssh_identity_file] = '/root/.ssh/chef_key'
# knife[:ssh_identity_file] = '/vagrant/centos_key'

knife[:automatic_attribute_whitelist] = %w[
  fqdn
  os
  os_version
  hostname
  ipaddress
  roles
  recipes
  ipaddress
  platform
  platform_version
  cloud
  cloud_v2
  chef_packages
]