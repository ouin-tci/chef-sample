# This is a Chef Infra Client recipe file. It can be used to specify resources
# which will apply configuration to a server.

log "Welcome to Chef Infra Client, #{node['example']['name']}!" do
  level :info
end

# For more information, see the documentation: https://docs.chef.io/recipes.html


file "/tmp/#{node['example']['filename']}" do
  content "#{node['example']['content']}"
end

# package "httpd" do
#   action :install
# end

# service "httpd" do
#   action [:enable, :start]
# end

# openjdk_install '11' do 
#   action :install
# end


%w(git gcc openssl-devel readline-devel zlib-devel).each do | p |
  package p.to_s do
    action :install
  end
end

%w(util-linux-user zsh).each do |p|
  package p.to_s do
    action :install
  end
end

execute "chsh-zsh" do
  command 'chsh -s "$(which zsh)"'
  action :run
end

execute "install o-my-zsh" do
  command 'sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
  only_if  { !Dir.exist?("/root/.oh-my-zsh") }
end

rbenv_system_install 'system' do
  update_rbenv false
end

rbenv_ruby '3.0.2' do
  verbose true
end

rbenv_global '3.0.2'

execute "download chefDK" do
  command "wget -O /tmp/chefdk-4.13.3-1.el7.x86_64.rpm https://packages.chef.io/files/stable/chefdk/4.13.3/el/7/chefdk-4.13.3-1.el7.x86_64.rpm"
  not_if  { File.exist?("/tmp/chefdk-4.13.3-1.el7.x86_64.rpm") }
  action :run
end

execute "install chefDK" do
  command "yum localinstall -y /tmp/chefdk-4.13.3-1.el7.x86_64.rpm"
  not_if  { File.exist?("/tmp/chefdk-4.13.3-1.el7.x86_64.rpm") }
  action :run
end

rbenv_gem 'knife-zero' do
  rbenv_version '3.0.2'
end
 

# package "httpd" do
#   action :install
# end

# service "httpd" do
#   action [:enable, :start]
# end