#Class: django 
class django ( $version = "NONE") {
    require apt

     $libmysqlclient = $lsbdistdescription ? {
	    "Ubuntu 10.04.4 LTS" => "libmysqlclient16",
		"Ubuntu 11.10"   => "libmysqlclient16",
		"Ubuntu 12.04 LTS"   => "libmysqlclient18",
		default  => 'none',
	  }	
    if $version == "NONE" {
        $cmd = "sudo pip install django",
    }
    else {
        $cmd = "sudo pip install django==$version",
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
    "tree":
       ensure => present;
    "git-core":
       ensure => present;
    "screen":
       ensure => present;
   }
    exec {
       "django":
       command => $cmd,
       path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin",
       require => [Package["python-pip"], Package["python-dev"], Class['mysql::python']];
    }

}
