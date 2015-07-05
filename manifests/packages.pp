class dns::packages {
    package {
        'bind':
            ensure => installed;
    }
    
    package {
        'bind-utils':
            ensure => installed;
    }
    
    package {
        'bind-chroot':
            ensure => installed;
    }
    
    package {
        'bind-libs':
            ensure => installed;
    }
        
    package {
        'subversion':
            ensure => installed,
    }
}
