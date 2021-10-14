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

# service "httpd" do
#   action [:enable, :start]
# end

# openjdk_install '11' do 
#   action :install
# end


%w(git gcc openssl-devel readline-devel zlib-devel).each do | p |
  package p do
    action :install
  end
end



endexecute "clone rbenv" do 
  command " git clone https://github.com/rbenv/rbenv.git ~/.rbenv"
  action :run

end


execute "install chefdk" do
  command "wget https://packages.chef.io/files/stable/chefdk/4.13.3/el/7/chefdk-4.13.3-1.el7.x86_64.rpm ", "yum localinstall chefdk-4.13.3-1.el7.x86_64.rpm"
  action :run
end


execute "install knife-zero" do
  command "chef gem install knife-zero"
  action :run
end



package "util-linux-user" do
  action :install
end

package "zsh" do
  action :install
end

execute "chsh-zsh" do
  command 'chsh -s "$(which zsh)"'
  action :run
end



execute "install o-my-zsh" do
  command 'sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
end