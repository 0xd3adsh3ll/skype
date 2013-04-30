#
# Cookbook Name:: skype
# Recipe:: default
#
# Copyright 2012, Arun Tomar
#

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


execute "apt-get" do
  command "apt-get update"
end

dependencies = %w{libasound2 libqt4-dbus libqt4-network libqt4-xml libqtcore4 libqtgui4 libqtwebkit4 libxss1 libxv1}

dependencies.each do |pkg|
  apt_package pkg do
    action :install
  end
end


#download skype
bash "download_skype" do
  user "root"
  cwd node[:skype][:temp_dir]
  code <<-EOH
  wget -c #{node[:skype][:url]} -O #{node[:skype][:filename]}
dpkg -i #{node[:skype][:filename]}
  EOH
end

