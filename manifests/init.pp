class dns {
    include dns::packages
    include dns::files
    include dns::bind
    include dns::service
    include dns::dnsmasq
}
