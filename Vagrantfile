# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.provision :shell, :path => "puppet/install_puppet_dependancies.sh"

  config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "site.pp"
      puppet.facter = {
	"motd" => "Built by Vagrant using librarian-puppet.",
	"fqdn" => "ckan.home",
	"pgpasswd" => "pass",
      }
  end

  # Allow local machines to view the VM
  #config.vm.network :public_network
  config.vm.network :forwarded_port, host: 8080, guest: 80
  # config.vm.network :forwarded_port, host: 8983, guest: 8983
  # config.vm.network :forwarded_port, host: 5432, guest: 5433
  # config.vm.network :forwarded_port, host: 5050, guest: 5000

  config.vm.provider :virtualbox do |vb|
    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"
    # This allows symlinks to be created within the /vagrant root directory,
    # which is something librarian-puppet needs to be able to do. This might
    # be enabled by default depending on what version of VirtualBox is used.
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    # don't boot with headless mode
    vb.gui = false
    # Virtualbox Custom CPU count:
    vb.customize ["modifyvm", :id, "--name", "ckan_vm"]
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.provider :vmware_fusion do |vmware, override|
    override.vm.box = "precise64_vmware"
    override.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"
    # 4GB RAM and 2 CPU cores
    vmware.vmx["memsize"] = "4096"
    vmware.vmx["numvcpus"] = "2"
    vmware.vmx["displayName"] = "ckan_vm"
    vmware.vmx["annotation"] = "Virtualised ckan environment"
  end
end
