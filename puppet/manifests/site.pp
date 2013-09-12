Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin",
}
node default {
  user { "vagrant":
    groups => ["www-data"],
  }
  file { '/etc/fqdn':
    content => $::fqdn
  }
  file { '/etc/motd':
    content => "Welcome to your Vagrant-built virtual machine!
                Managed by Puppet.
                Ready for running Ckan 2.2a <http://ckan.org>.
                $motd\n"
  }
  file { '/home/vagrant/.bashrc':
     ensure => 'file',
     source => '/vagrant/.bashrc',
  }
  package { ["screen", "vim", "emacs23-nox", "htop", "pv", "unzip"]:
    ensure => "installed"
  }
}
node /^ckan/ inherits default {
  include ckan
}
