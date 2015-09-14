class dns::dnsmasq {
    package {
        'dnsmasq':
            ensure => absent,
    }
}
