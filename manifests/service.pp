class dns::service {
    service {
        'named':
            ensure     => stopped,
            enable     => false,
            hasstatus  => true,
            hasrestart => false,
            require    => Package['bind'];
    }
}
