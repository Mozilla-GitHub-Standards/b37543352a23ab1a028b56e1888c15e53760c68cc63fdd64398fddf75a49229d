class dns::service {
    service {
        'named':
            ensure     => running,
            enable     => true,
            hasstatus  => true,
            hasrestart => false,
            require    => Package['bind'];
    }
}
