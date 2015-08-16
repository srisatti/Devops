#
# Cookbook Name:: meygam_tomcat
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'tomcat7'

remote_file '/var/lib/tomcat7/webapps/grails-petclinic-0.1.war' do
  source 'file:///vagrant/grails-petclinic-0.1.war'
  action :create
  notifies :restart, "service[tomcat7]"
end

template "tomcat7 settings" do
	source "tomcat7.erb"
	path "/etc/default/tomcat7"
	notifies :restart, "service[tomcat7]"
end

service 'tomcat7' do
	action [:restart, :start, :stop]
end