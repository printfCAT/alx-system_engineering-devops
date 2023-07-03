# automates creating a custom HTTP header response
package { 'nginx':
  ensure => installed,
}

file { '/etc/nginx/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}

file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => "server {
      listen      80 default_server;
      listen      [::]:80 default_server;
      root        /etc/nginx/html;
      index       index.html index.htm;

      add_header X-Served-By $hostname;
  }",
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  hasstatus  => true,
}
