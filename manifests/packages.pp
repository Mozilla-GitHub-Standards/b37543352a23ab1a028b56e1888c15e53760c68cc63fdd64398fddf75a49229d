class dns::packages {
    package {
        $dns::package_prefix:
            ensure => installed;
    }
    
    package {
        "${dns::init::package_prefix}-utils":
            ensure => installed;
    }
    
    package {
        "${dns::package_prefix}-chroot":
            ensure => installed;
    }
    
    package {
        "${dns::package_prefix}-libs":
            ensure => installed;
    }
    
    package {
        'dnstop':
            ensure => installed;
    }
    
    package {
        'mtree':
            ensure => installed,
    }
    
    package {
        'subversion':
            ensure => installed,
    }
}
