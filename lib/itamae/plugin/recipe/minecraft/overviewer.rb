require 'json'
require 'open-uri'

minecraft_versions_url = 'http://s3.amazonaws.com/Minecraft.Download/versions/versions.json'
minecraft_version = node[:minecraft][:version] || JSON.parse(open(minecraft_versions_url).read)['latest']['release']

minecraft_dir = "/opt/minecraft/.minecraft/versions/#{minecraft_version}"
minecraft_client_url = "https://s3.amazonaws.com/Minecraft.Download/versions/#{minecraft_version}/#{minecraft_version}.jar"
filename = File.basename(minecraft_client_url)
minecraft_path = "#{minecraft_dir}/#{filename}"

minecraft_user = node[:minecraft][:user] || 'minecraft'

execute 'add overviewer to apt sources.list' do
  command 'echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list'
  not_if 'cat /etc/apt/sources.list | grep http://overviewer.org/debian'
end

execute 'add apt-key' do
  command 'wget -O - http://overviewer.org/debian/overviewer.gpg.asc | sudo apt-key add -'
  not_if 'apt-key list | grep overviewer.org'
end

execute 'apt-get update' do
  command 'apt-get update'
end

package 'minecraft-overviewer'

directory "/opt/minecraft/.minecraft/versions/#{node[:minecraft][:version]}" do
  owner minecraft_user
  group minecraft_user
end

execute 'download minecraft client' do
  command "wget #{minecraft_client_url} -O #{minecraft_path}"
  not_if  "test -f #{minecraft_path}"
end
