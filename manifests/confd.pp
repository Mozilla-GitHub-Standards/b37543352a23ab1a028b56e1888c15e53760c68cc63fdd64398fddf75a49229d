class dns::confd {
    file {
        '/etc/confd/conf.d/':
            ensure => directory,
            recurse => true,
            owner   => 0,
            group   => 0,
            source  => 'puppet:///',
    }

    file {
        '/etc/confd/templates/':
    }
}
