class dns::service {
    service {
        'named':
            ensure     => stopped,
            enable     => true,
            hasstatus  => true,
            hasrestart => false,
            require    => Package['bind'];
    }
}
