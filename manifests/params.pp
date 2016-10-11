class certbot::params {
  $agree_tos           = true
  $unsafe_registration = false
  $manage_config       = true
  $manage_install      = true
  $manage_dependencies = true
  $package_ensure      = 'installed'
  $config_file         = '/etc/certbot/cli.ini'
  $path                = '/opt/certbot'
  $venv_path           = '/opt/certbot/.venv' # virtualenv path for vcs-installed certbot
  $repo                = 'https://github.com/certbot/certbot.git'
  $version             = 'v0.8.1'
  $config              = {
    'server' => 'https://acme-v01.api.letsencrypt.org/directory',
  }

  if $::operatingsystem == 'Debian' and versioncmp($::operatingsystemrelease, '8') >= 0 {
    include apt::backports
    $install_method = 'package'
    $package_name = ['certbot', 'python-certbot']
    $package_command = 'certbot'
  } elsif $::operatingsystem == 'Ubuntu' and versioncmp($::operatingsystemrelease, '16.04') >= 0 {
    $install_method = 'package'
    $package_name = 'letsencrypt'
    $package_command = 'letsencrypt'
  } elsif $::osfamily == 'RedHat' and versioncmp($::operatingsystemmajrelease, '7') >= 0 {
    $install_method = 'package'
    $package_name = 'certbot'
    $package_command = 'certbot'
  } elsif $::osfamily == 'Gentoo' {
    $install_method = 'package'
    $package_name = 'app-crypt/certbot'
    $package_command = 'certbot'
  } else {
    $install_method = 'vcs'
    $package_name = 'certbot'
    $package_command = 'certbot'
  }

  if $::osfamily == 'RedHat' {
    $configure_epel = true
  } else {
    $configure_epel = false
  }
}
