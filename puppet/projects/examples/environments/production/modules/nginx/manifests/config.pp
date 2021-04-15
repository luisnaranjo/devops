# @summary Manages the nginx.conf file
#
# Manages the nginx.conf file
#
# @example
#   include nginx::config
class nginx::config (
  # Using params.pp file.
  $config_path   = $nginx::params::config_path,
  $config_source = $nginx::params::config_source,
) inherits nginx::params{
  file { 'nginx_config':
    path   => $config_path,             # Using params.pp file.
    source => $config_source,           # Using params.pp file.
    ensure => $nginx::config_ensure,    # Using Hiera parameters.
    notify => Service['nginx_service'], # Notify the class specified in service.pp to restart the service one the configuration files are updated.
                                        # Note we use "Service" not "service" here.
  }
}
