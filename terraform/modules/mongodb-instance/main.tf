resource "google_compute_instance" "mongodb" {
  count        = var.replica_count
  name         = "${var.name}-${count.index + 1}"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = var.disk_siz_gb
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  labels = merge({
    database = "mongodb"
  }, var.labels)
}
