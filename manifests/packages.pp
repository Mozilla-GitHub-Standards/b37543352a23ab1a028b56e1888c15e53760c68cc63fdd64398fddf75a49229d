class dns::packages {
    package {
        $package_prefix:
            ensure => installed;
    }
    
    package {
        "${package_prefix}-utils":
            ensure => installed;
    }
    
    package {
        "${package_prefix}-chroot":
            ensure => installed;
    }
    
    package {
        "${package_prefix}-libs":
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
