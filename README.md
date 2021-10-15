http://knife-zero.github.io/20_getting_started/


## chef dk install

https://downloads.chef.io/tools/chefdk

### redhat version

```bash
wget https://packages.chef.io/files/stable/chefdk/4.13.3/el/7/chefdk-4.13.3-1.el7.x86_64.rpm
yum localinstall chefdk-4.13.3-1.el7.x86_64.rpm

#centos 8
wget https://packages.chef.io/files/stable/chefdk/4.13.3/el/8/chefdk-4.13.3-1.el7.x86_64.rpm

yum localinstall chefdk-4.13.3-1.el7.x86_64.rpm

#setup(zsh)
# echo 'eval "$(chef shell-init zsh)"' >> ~/.zshrc
```

### install ruby via rbenv
install rbenv manual of amazon linux 2
https://qiita.com/ktoyod/items/e5c7c23cbd92c703feb9


### install  knife-zero
http://knife-zero.github.io/10_install/

```bash
gem install knife-zero
rbenv rehash
```

## how to use


### repoを作成する

```bash
chef generate repo my-repo
cd my-repo

#https://docs.chef.io/workstation/config_rb/
touch ./config.rb
#contents  
### Setup Chef-Repo
#https://knife-zero.github.io/20_getting_started/
```
		
### cookbookを作成する

About recipe: https://docs.chef.io/recipes.html

resource: https://docs.chef.io/resources/

```bash
cd path/to/myrepo/cookbooks
#example 1
chef generate cookbook cookbooks/${recipe_name}
# modify ./${recipe_name}/recipes/default.rb
```
	
### roleを作成する

roleとはいくつのrecipesの集合です

```bash
cd path/to/repo
knife role create ${role-name}
# add run list into json file
"run_list": [
    "recipe[recipe_name]",
    "recipe[create_file]"
]
```


### bootstartap host(create node)

the hostname must has been configed in `~/.ssh/config, /etc/hosts`, the path of ssh key is set in `config.rb`
```bash
knife[:ssh_identity_file] = '/path/to/key'
```

```bash
cd path/to/repo
knife zero bootstrap ${hostname} --ssh-user vagrant -N ${node_name}
```

### add run list

https://docs.chef.io/workstation/knife_node/#run_list-add

```bash
cd path/to/repo
knife node run_list add ${node_name} "role[apserver]"
```

### converge 

```bash
cd path/to/repo
knife zero converge "name:${hostname}" --ssh-user vagrant 
# --override-runlist create_file
```


## about cookbook

### use berks(old)

```bash
touch Berksfile
#contents
source "https://supermarket.chef.io"
cookbook "apache2"
```
### install

```bash
berks install
```
### move cookbooks to vendor directory

```bash
berks vendor cookbooks
```