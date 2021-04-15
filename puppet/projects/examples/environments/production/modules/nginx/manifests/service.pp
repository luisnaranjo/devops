# @summary Manage the state of the nginx service.
#
# Manage the state of the nginx service.
#
# @example
#   include nginx::service
class nginx::service (
  # Using params.pp file.
  $service_name = $nginx::params::service_name
) inherits nginx::params {
  service {'nginx_service':
    name       => $service_name,                # Using params.pp file.
    ensure     => $nginx::service_ensure,       # Using Hiera.
    enable     => $nginx::service_enable,       # Using Hiera.
    hasrestart => $nginx::service_hasrestart,   # Using Hiera.
  }
}
