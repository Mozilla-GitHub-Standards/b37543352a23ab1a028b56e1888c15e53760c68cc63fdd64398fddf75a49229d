class dns::bind {
    user {
        'named-update':
            ensure => present,
            system => true,
            home   => '/var/named';
    }
    
    exec {
        # Generate our rndc key
        'rndc-keygen':
            cwd       => "/var/named/chroot/etc",
            command   => "/usr/sbin/rndc-confgen -r /dev/urandom -a -k rndckey -b 384 -c rndc.key",
            creates   => "/var/named/chroot/etc/rndc.key",
            logoutput => on_failure,
            before    => Service['named'],
            require   => Package['bind'];
    
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
            ip      => "63.245.217.46",
            comment => "Need this for the nameservers to access svn via the external interface";
    }
}
