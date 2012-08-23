#Class: django 
class django {
     $libmysqlclient = $lsbdistdescription ? {
	    "Ubuntu 10.04.4 LTS" => "libmysqlclient16",
		"Ubuntu 11.10"   => "libmysqlclient16",
		"Ubuntu 12.04 LTS"   => "libmysqlclient18",
		default  => 'none',
	  }	

    class {
    'mysql::server':
      config_hash => { 'root_password' => 'foo' };
    'mysql':;
    'mysql::python':;
    }
    package { 
    "libmysqlclient-dev":
        ensure => present;
    "python-pip":
        ensure => present;
    "python-dev":
        ensure => present;
    $libmysqlclient:
        ensure => present;
   }
    exec {
       "django":
       command => "sudo pip install django==1.3",
       path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin",
       require => [Package["python-pip"], Package["python-dev"], Class['mysql::python']];
    }

}
