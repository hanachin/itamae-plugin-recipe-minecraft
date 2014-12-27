minecraft_dir = '/opt/minecraft'
minecraft_server_url = 'https://s3.amazonaws.com/Minecraft.Download/versions/1.8.1/minecraft_server.1.8.1.jar'
filename = File.basename(minecraft_server_url)
minecraft_path = "#{minecraft_dir}/#{filename}"

directory minecraft_dir do
  action :create
end

execute 'download minecraft server' do
  command "wget #{minecraft_server_url} -O #{minecraft_path}"
  not_if  "test -f #{minecraft_path}"
end
