class dns::dnsmasq {
    package {
        'dnsmasq':
            ensure => absent,
    }

    file {
        '/etc/dhcp/dhclient.conf':
            ensure => present,
            content => 'timeout 300;',
    }
}
