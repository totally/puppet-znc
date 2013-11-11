class znc::config(
    $irc_user   = hiera('znc_irc_user', $znc::params::irc_user ),
    $irc_pass   = hiera('znc_irc_pass', $znc::params::irc_pass ),
    $irc_server = hiera('znc_irc_server', $znc::params::irc_server ),
    $irc_port   = hiera('znc_irc_port', $znc::params::irc_port ),
    $pass_hash  = hiera('znc_pass_hash', $znc::params::pass_hash ),
    $pass_salt  = hiera('znc_pass_salt', $znc::params::pass_salt ),
    $pass_method  = hiera('znc_pass_method', $znc::params::pass_method ),
    $datadir    = hiera('znc_datadir', $znc::params::datadir),
) inherits znc::params {

    file {[
            "${datadir}",
            "${datadir}/configs",
            "${datadir}/modules",
            "${datadir}/users",
            "${datadir}/moddata",
            "${datadir}/moddata/cyrusauth",
        ]:
        ensure  => directory,
        mode    => 700,
        owner   => 'znc',
        group   => 'sasl',
    } -> 
    # ONLY load config file on first run,
    # afterwards, user data will be stored in the config
    # ie. the config file becomes a database 
    # ie. replace = false
    file { "${datadir}/configs/znc.conf":
        ensure  => present,
        mode    => 600,
        owner   => 'znc',
        group   => 'sasl',
        content => template('znc/znc.conf.erb'),
        replace => false,  
    } -> 
    # Create pem cert if necessary
    exec {'create znc pem':
        command => "znc --datadir=${datadir} --makepem",
        user    => 'znc',
        cwd     => $datadir,
        unless  => "test -f ${datadir}/znc.pem",
        require => Class['znc::package'],
        logoutput   => true,
    } -> 
    file {"${datadir}/moddata/cyrusauth/.registry":
        ensure  => present,
        mode    => 600,
        owner   => 'znc',
        group   => 'sasl',
        content => "CloneUser clonethisuser\nCreateUser yes",
    }

    # 
}
