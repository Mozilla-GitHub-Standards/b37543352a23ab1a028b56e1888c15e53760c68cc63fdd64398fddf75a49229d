class dns {
    include dns::packages
    include dns::files
    include dns::bind
    include dns::service

    case $::operatingsystemrelease {
        /^5/: {
            $package_prefix="bind97"
        }
        /^6/: {
            $package_prefix="bind"
        }
    }

    /* <Hack> */
    file {
        "/var/named/.ssh/id_rsa":
            ensure  => present,
            mode    => '0600',
            owner   => "named-update",
            group   => "named-update",
    }

    file {
        "/var/named/.ssh/id_rsa.pub":
            ensure  => present,
            mode    => '0600',
            owner   => "named-update",
            group   => "named-update",
    }
    /* </Hack> */
}
