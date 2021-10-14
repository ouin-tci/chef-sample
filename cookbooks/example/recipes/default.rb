# This is a Chef Infra Client recipe file. It can be used to specify resources
# which will apply configuration to a server.

log "Welcome to Chef Infra Client, #{node['example']['name']}!" do
  level :info
end

# For more information, see the documentation: https://docs.chef.io/recipes.html


file "/tmp/#{node['example']['filename']}" do
  content "#{node['example']['content']}"
end


directory '/tmp/apache2' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end


package "httpd" do
  action :install
end