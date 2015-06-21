Vagrant.configure("2") do |config|
  config.vm.define 'local' do |box|
    box.vm.box = 'ubuntu/trusty64'
    box.vm.provision 'shell', path: 'scripts/provision.sh'
    box.vm.network 'private_network', ip: '172.18.123.121'
  end

  if File.file?('private/token')
    config.vm.define 'keygen-radio-remote' do |box|
      box.vm.synced_folder '.', '/vagrant', disabled: true
      box.vm.provision 'shell', path: 'scripts/provision.sh'
      box.vm.provider :digital_ocean do |provider, override|
        override.ssh.private_key_path = '~/.ssh/vagrant_do_rsa'
        override.vm.box = 'digital_ocean'
        override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

        provider.token = File.read('private/token').strip
        provider.image = 'ubuntu-14-04-x64'
        provider.region = 'ams2'
        provider.size = '512mb'
      end
    end
  end
end
