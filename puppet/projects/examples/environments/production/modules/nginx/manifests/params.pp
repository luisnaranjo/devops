# @summary Stores OS-specific parameters.
#
# Stores OS-specific parameters.
#
# @example
#   include nginx::params
class nginx::params {
  # Default values.
  $package_name = 'nginx'
  $service_name = 'nginx'

  # OS family specific values.
  # Using a case.
  case $::osfamily {
    'RedHat': {
      $config_path   = '/etc/nginx/nginx.conf'
      $config_source = 'puppet:///modules/nginx/rh-nginx.conf'
      $vhosts_dir    = '/etc/nginx/conf.d/'
    }
    'Debian': {
      $config_path   = '/etc/nginx/nginx.conf'
      $config_source = 'puppet:///modules/nginx/deb-nginx.conf'
      $vhosts_dir    = '/etc/nginx/sites-available/'
    }
  }
}
