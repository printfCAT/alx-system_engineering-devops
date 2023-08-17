# Increase the ULIMIT of the default file
exec { 'fix--for-nginx':
  command     => 'sed -i "s/15/4096/" /etc/default/nginx',
  path        => ['/usr/local/bin', '/bin'],
  refreshonly => true,  # Only run when needed (when nginx.conf is modified)
} ->

# Restart Nginx
service { 'nginx':
  ensure  => 'running',   # Ensure Nginx service is running
  enable  => true,        # Start Nginx service on boot
  require => Exec['fix--for-nginx'],  # Wait for the file update before restarting
}
