class dns::confd {
    file {
        '/etc/confd/conf.d/':
            ensure => directory,
            recurse => true,
            owner   => 0,
            group   => 0,
            source  => 'puppet:///modules/dns/confd/conf.d/',
    }

    file {
        '/etc/confd/templates/':
            ensure => directory,
            recurse => true,
            owner   => 0,
            group   => 0,
            source  => 'puppet:///modules/dns/confd/templates/',
    }
}
