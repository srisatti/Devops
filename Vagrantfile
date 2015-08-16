# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
    config.vm.define "apache2" do |apache2|
      apache2.vm.box = "hashicorp/precise64"
      apache2.vm.network "private_network", ip: "192.168.33.10"
      apache2.vm.synced_folder "app", "/var/www/"
      apache2.vm.provision "shell", inline: <<-SHELL
        sudo apt-get update
        # sudo apt-get install -y apache2
        sudo apt-get install -y curl
      SHELL
      
      apache2.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "chef/cookbooks"
        chef.roles_path = "chef/roles"
        chef.add_role "web"
      end
    end

    config.vm.define "nginx" do |nginx|
      nginx.vm.box = "hashicorp/precise64"
      nginx.vm.network "private_network", ip: "192.168.33.11"

      nginx.vm.provider "virtualbox" do |vb|
        # Display the VirtualBox GUI when booting the machine
        vb.gui = true
      
        # Customize the amount of memory on the VM:
        vb.memory = "1024"
        vb.cpus = "4"
      end

      nginx.vm.provision "shell", inline: <<-SHELL
        sudo apt-get update 
        sudo apt-get install -y nginx
        sudo apt-get install -y curl
        sudo service nginx start
      SHELL
    end

    config.vm.define "tomcat" do |tomcat|
      tomcat.vm.box = "hashicorp/precise64"
      tomcat.vm.network "private_network", ip: "192.168.33.12"

      tomcat.vm.provider "virtualbox" do |vb|
        # Customize the amount of memory on the VM:
        vb.memory = "1024"
        vb.cpus = "2"
      end

      tomcat.vm.provision "shell", inline: <<-SHELL
        sudo apt-get update
        sudo apt-get install -y curl
        sudo apt-get install -y vim
      SHELL

      tomcat.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "chef/cookbooks"
        chef.roles_path = "chef/roles"
        chef.add_role "app"
        chef.environments_path = "chef/environments"
        chef.environment = "dev"
      end
    end

    config.vm.define "artifactory" do |artifactory|
      artifactory.vm.box = "hashicorp/precise64"
      artifactory.vm.network "private_network", ip: "192.168.33.13"

      artifactory.vm.provider "virtualbox" do |vb|
        # Customize the amount of memory on the VM:
        vb.memory = "512"
      end

      artifactory.berkshelf.enabled = true
      artifactory.berkshelf.berksfile_path = 'chef/berkshelf/artifactory'

      artifactory.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "chef/cookbooks"
        chef.roles_path = "chef/roles"
        chef.add_role "artifactory"
        chef.environments_path = "chef/environments"
        chef.environment = "dev"
      end
    end
end
