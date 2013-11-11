class znc::params {
    $use_backport = true
    $irc_user   = 'default_irc_user'
    $irc_pass   = 'default_irc_pass'
    $irc_server = 'localhost'
    # a "+" before the servername indicates ssl is used
    $irc_port   = '+6697'
    $datadir    = '/var/lib/znc'
    $pass_hash  = 'default_password_hash'
    $pass_salt  = 'default_password_salt'
    $pass_method  = 'SHA256'
}
