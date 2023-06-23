# kills a process called killmenow
exec { 'stop_process':
  command => 'pkill -f killmenow',
  path    => '/usr/bin',
}
