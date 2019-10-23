provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.gcp_project}"
  region      = "${var.region}"
}


resource "google_compute_address" "sonarqubeip" {
  name   = "${var.splunk_instance_ip_name}"
  region = "${var.splunk_instance_ip_region}"
}


resource "google_compute_instance" "splunk" {
  name         = "${var.instance_name}"
  machine_type = "n1-standard-2"
  zone         = "us-east1-b"

  tags = ["name", "splunk", "http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  #scratch_disk {
  #}

  network_interface {
    network    = "${var.splunkvpc}"
    subnetwork = "${var.splunksub}"
    access_config {
      // Ephemeral IP
      nat_ip = "${google_compute_address.splunkip.address}"
    }
  }
  metadata = {
    name = "splunk"
  }

  metadata_startup_script = "sudo apt-get update -y;sudo apt-get install git -y; sudo git clone https://github.com/Diksha86/splunk.git; cd splunk; sudo chmod 777 /splunk/*; sudo sh splunk.sh"
}
