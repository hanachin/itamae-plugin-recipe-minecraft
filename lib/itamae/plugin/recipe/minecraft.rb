require 'json'
require 'open-uri'

minecraft_versions_url = 'http://s3.amazonaws.com/Minecraft.Download/versions/versions.json'
minecraft_version = node[:minecraft][:version] || JSON.parse(open(minecraft_versions_url).read)['latest']['release']

minecraft_dir = '/opt/minecraft'
minecraft_server_url = "https://s3.amazonaws.com/Minecraft.Download/versions/#{minecraft_version}/minecraft_server.#{minecraft_version}.jar"
filename = File.basename(minecraft_server_url)
minecraft_path = "#{minecraft_dir}/#{filename}"

directory minecraft_dir do
  action :create
end

directory "#{minecraft_dir}/backups" do
  action :create
end

user 'create minecraft user' do
  username    'minecraft'
  home        minecraft_dir
  system_user true
end

execute "minecraft user can't login" do
  command 'chsh -s /usr/sbin/nologin minecraft'
end

execute 'download minecraft server' do
  command "wget #{minecraft_server_url} -O #{minecraft_path}"
  not_if  "test -f #{minecraft_path}"
end

execute 'make executable' do
  command "chmod 0744 #{minecraft_path}"
end

execute 'change minecraft server owner' do
  command "chown #{node[:minecraft][:user]}:#{node[:minecraft][:user]} #{minecraft_path}"
end

execute 'create symlink to minecraft jar' do
  command "ln -sf #{filename} minecraft_server.jar"
  cwd minecraft_dir
end
