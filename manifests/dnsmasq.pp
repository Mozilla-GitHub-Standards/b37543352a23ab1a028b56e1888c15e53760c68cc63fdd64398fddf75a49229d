class dns::dnsmasq {
    file {
        '/etc/dnsmasq.d/bind-interfaces.conf':
            ensure => present,
            owner => 0,
            group => 0,
            content => "bind-interfaces",
    }
}
