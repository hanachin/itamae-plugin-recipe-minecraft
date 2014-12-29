execute 'add overviewer to apt sources.list' do
  command 'echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list && apt-get update'
  not_if 'cat /etc/apt/sources.list | grep http://overviewer.org/debian'
end

package 'minecraft-overviewer'
