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
