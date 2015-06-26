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
}
