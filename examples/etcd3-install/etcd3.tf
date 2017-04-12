// Create popular machine Profiles (convenience module)
module "profiles" {
  source = "../modules/profiles"
}

// Install CoreOS to disk before provisioning
resource "matchbox_group" "default" {
  name = "default"
  profile = "${module.profiles.coreos-install}"
  // No selector, matches all nodes
  metadata {
    coreos_channel = "stable"
    coreos_version = "1235.9.0"
    ignition_endpoint = "http://matchbox.example.com:8080/ignition"
    baseurl = "http://matchbox.example.com:8080/assets/coreos"
    ssh_authorized_key = "${var.ssh_authorized_key}"
  }
}

// Create matcher groups for 3 machines

resource "matchbox_group" "node1" {
  name = "node1"
  profile = "${module.profiles.etcd3}"
  selector {
    mac = "52:54:00:a1:9c:ae"
    os = "installed"
  }
  metadata {
    domain_name = "node1.example.com"
    etcd_name = "node1"
    etcd_initial_cluster = "node1=http://node1.example.com:2380,node2=http://node2.example.com:2380,node3=http://node3.example.com:2380"
    ssh_authorized_key = "${var.ssh_authorized_key}"
  }
}

resource "matchbox_group" "node2" {
  name = "node2"
  profile = "${module.profiles.etcd3}"
  selector {
    mac = "52:54:00:b2:2f:86"
    os = "installed"
  }
  metadata {
    domain_name = "node2.example.com"
    etcd_name = "node2"
    etcd_initial_cluster = "node1=http://node1.example.com:2380,node2=http://node2.example.com:2380,node3=http://node3.example.com:2380"
    ssh_authorized_key = "${var.ssh_authorized_key}"
  }
}

resource "matchbox_group" "node3" {
  name = "node3"
  profile = "${module.profiles.etcd3}"
  selector {
    mac = "52:54:00:c3:61:77"
    os = "installed"
  }
  metadata {
    domain_name = "node3.example.com"
    etcd_name = "node3"
    etcd_initial_cluster = "node1=http://node1.example.com:2380,node2=http://node2.example.com:2380,node3=http://node3.example.com:2380"
    ssh_authorized_key = "${var.ssh_authorized_key}"
  }
}

