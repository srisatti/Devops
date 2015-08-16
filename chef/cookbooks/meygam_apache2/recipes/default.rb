#
# Cookbook Name:: meygam_apache2
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'apache2'

file '/var/www/index.html' do
  content '<html>This is a placeholder for the home page.</html>'
  mode '0644'
  owner 'root'
  group 'root'
end

service 'apache2'