/* Instances */
resource "oci_core_instance" "Webserver-AD1" {
  availability_domain = data.oci_identity_availability_domains.ashburn.availability_domains[0]["name"]
  compartment_id      = var.compartment_ocid
  display_name        = "Webserver-ASHBURN_AD1"
  shape               = var.instance_shape

  create_vnic_details {
    subnet_id        = oci_core_subnet.subnet1.id
    display_name     = "primaryvnic"
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.phx.aaaaaaaaknx2ppduoemdgkwck7ghc3kok74ljctqaelczm5jipop3cef55pq"
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = base64encode(var.user-data)
  }

  timeouts {
    create = "60m"
  }
}

resource "oci_core_instance" "Webserver-AD2" {
  availability_domain = data.oci_identity_availability_domains.ashburn.availability_domains[1]["name"]
  compartment_id      = var.compartment_ocid
  display_name        = "Webserver-AD2"
  shape               = var.instance_shape

  create_vnic_details {
    subnet_id        = oci_core_subnet.subnet2.id
    display_name     = "primaryvnic"
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.phx.aaaaaaaaknx2ppduoemdgkwck7ghc3kok74ljctqaelczm5jipop3cef55pq"
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = base64encode(var.user-data)
  }

  timeouts {
    create = "60m"
  }
}

variable "user-data" {
  default = <<EOF
#!/bin/bash -x
echo '################### webserver userdata begins #####################'
touch ~opc/userdata.`date +%s`.start

# echo '########## yum update all ###############'
# yum update -y

echo '########## basic webserver ##############'
yum install -y httpd
systemctl enable  httpd.service
systemctl start  httpd.service

echo '<html><head></head><body><pre><code>' > /var/www/html/index.html
each '' >> /var/www/html/index.html
echo '<H1><p style="color:red;">' >> /var/www/html/index.html

hostname >> /var/www/html/index.html

echo '</p></H1>' >> /var/www/html/index.html
echo '<p>' >> /var/www/html/index.html
echo '<img src="http://bit.ly/2NBa8MA" alt="OOW2018" align="left">' >> /var/www/html/index.html

echo '</code></pre></body></html>' >> /var/www/html/index.html

firewall-offline-cmd --add-service=http
systemctl enable  firewalld
systemctl restart  firewalld

touch ~opc/userdata.`date +%s`.finish
echo '################### webserver userdata ends #######################'
EOF

}

output "Webserver-AD1" {
  value = [oci_core_instance.Webserver-AD1.public_ip]
}

output "Webserver-AD2" {
  value = [oci_core_instance.Webserver-AD2.public_ip]
}

