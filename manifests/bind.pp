class dns::bind {
    user {
        'named-update':
            ensure => present,
            system => true,
            home   => '/var/named';
    }
    
    exec {
        # The install script for bind makes /var/named/chroot/var/named/slaves, which angers svn checkout
        'dns-svn-cleanup':
            cwd         => "/var/named/chroot/var/named/",
            command     => "/bin/rm -rf /var/named/chroot/var/named/slaves /var/named/chroot/var/named/data",
            environment => "SVN_SSH=/usr/bin/ssh -oStrictHostKeyChecking=no",
            onlyif      => '/usr/bin/test -d /var/named/chroot/var/named/slaves -a \! -d /var/named/chroot/var/named/.svn',
            require     => Package['bind-chroot'];
    }
    
    host {
        'svn.mozilla.org':
            ensure  => present,
            ip      => "63.245.213.57",
            comment => "Need this for the nameservers to access svn via the external interface";
    }
}
