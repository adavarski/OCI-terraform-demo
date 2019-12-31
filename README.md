### OCI-terraform-demo

#### 1.Install oci-cli and terraform 
```
$ bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
$/Users/davar/bin/oci setup keys

...
If you haven't already uploaded your public key through the console,
follow the instructions on the page linked below in the section 'How toupload the public key':

    <https://docs.cloud.oracle.com/Content/API/Concepts/apisigningkey.htm#How2>

$ cat /Users/davar/.oci/config
[DEFAULT]
user=
fingerprint=
key_file=~/.oci/oci_api_key.pem
tenancy=
region=
$ /Users/davar/bin/oci setup repair-file-permissions --file /Users/davar/.oci/config
$ /Users/davar/bin/oci iam region list --output table
$ /Users/davar/bin/oci iam availability-domain list --output table --profile DEFAULT
$ /Users/davar/bin/oci compute image list -c ocid1.tenancy.oc1XXXXXXXXXX --output table --query "data [*].{ImageName:\"display-name\", OCID:id}"|grep CentOS
$ curl https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_darwin_amd64.zip --output terraform_0.12.18_darwin_amd64.zip
$ unzip terraform_0.12.18_darwin_amd64.zip
$ cp ./terraform /usr/local/bin
```
#### 2.Create env-vars file
```
$ cat env-vars
export TF_VAR_tenancy_ocid=
export TF_VAR_user_ocid=
export TF_VAR_compartment_ocid=

export TF_VAR_fingerprint=$(cat ~/.oci/oci_api_key_fingerprint)
export TF_VAR_private_key_path=~/.oci/oci_api_key.pem

export TF_VAR_ssh_public_key=$(cat ~/.ssh/id_rsa.pub)
export TF_VAR_ssh_private_key=$(cat ~/.ssh/id_rsa)

export TF_VAR_region=
```

#### 3.Create OCI infrastructure
```
$ source env-vars
$ terraform init
$ terraform plan
$ terraform apply

Plan: 6 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

oci_core_virtual_network.demo_vcn: Creating...
oci_core_virtual_network.demo_vcn: Creation complete after 2s [id=ocid1.vcn.oc1.phx.amaaaaaajkdonlqa3r6qt7ghfahlatwdickkkare5drna424uyyzjdtyyouq]
oci_core_internet_gateway.demo_igw: Creating...
oci_core_security_list.demo_sl: Creating...
oci_core_internet_gateway.demo_igw: Creation complete after 1s [id=ocid1.internetgateway.oc1.phx.aaaaaaaabpgnujbfrz7gpoddcf7x5miz7ksmxphde4vritfl4hchzjrze6fa]
oci_core_route_table.demo_rt: Creating...
oci_core_security_list.demo_sl: Creation complete after 1s [id=ocid1.securitylist.oc1.phx.aaaaaaaas75izc2cyd5snnfehhmp5ivzw44gb7lcglawvtphmayeikeeazfa]
oci_core_route_table.demo_rt: Creation complete after 1s [id=ocid1.routetable.oc1.phx.aaaaaaaa7xnlcsgousegj44e3kqsgqmswlbejg4wst7r4jwigzcslw62kyna]
oci_core_subnet.demo_subnet: Creating...
oci_core_subnet.demo_subnet: Creation complete after 0s [id=ocid1.subnet.oc1.phx.aaaaaaaaftsvzen7dxvpywcs7whbvhblasapzgm4skfxehf4nuf3ppxm6tya]
oci_core_instance.demo_vm: Creating...
oci_core_instance.demo_vm: Still creating... [10s elapsed]
oci_core_instance.demo_vm: Still creating... [20s elapsed]
oci_core_instance.demo_vm: Still creating... [30s elapsed]
oci_core_instance.demo_vm: Still creating... [40s elapsed]
oci_core_instance.demo_vm: Still creating... [50s elapsed]
oci_core_instance.demo_vm: Still creating... [1m0s elapsed]
oci_core_instance.demo_vm: Still creating... [1m10s elapsed]
oci_core_instance.demo_vm: Still creating... [1m20s elapsed]
oci_core_instance.demo_vm: Still creating... [1m30s elapsed]
oci_core_instance.demo_vm: Creation complete after 1m33s [id=ocid1.instance.oc1.phx.anyhqljrjkdonlqco2pde2xalfkcrcqcwqimo2ylpoxxubo5xceertxnmx6a]

Apply complete! Resources: 6 added, 0 changed, 0 destroyed.


```
#### 4. Connect to VM


```
Anastass-MacBook-Pro:oci-08 davar$ ssh -i ~/.ssh/id_rsa opc@129.146.99.136
The authenticity of host '129.146.99.136 (129.146.99.136)' can't be established.
ECDSA key fingerprint is SHA256:xOXVbdPOij+eH+vJEAFa6Ze3vrhsOXR5TJtN7DhVx18.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '129.146.99.136' (ECDSA) to the list of known hosts.
-bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
-bash-4.2$ sudo su -
[root@michalsvm ~]# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 08:23 ?        00:00:02 /usr/lib/systemd/systemd --switched-root --system --deserialize 21
root         2     0  0 08:23 ?        00:00:00 [kthreadd]
root         4     2  0 08:23 ?        00:00:00 [kworker/0:0H]
root         5     2  0 08:23 ?        00:00:00 [kworker/u4:0]
root         6     2  0 08:23 ?        00:00:00 [ksoftirqd/0]
root         7     2  0 08:23 ?        00:00:00 [migration/0]
root         8     2  0 08:23 ?        00:00:00 [rcu_bh]
root         9     2  0 08:23 ?        00:00:00 [rcu_sched]
root        10     2  0 08:23 ?        00:00:00 [lru-add-drain]
root        11     2  0 08:23 ?        00:00:00 [watchdog/0]
root        12     2  0 08:23 ?        00:00:00 [watchdog/1]
root        13     2  0 08:23 ?        00:00:00 [migration/1]
root        14     2  0 08:23 ?        00:00:00 [ksoftirqd/1]
root        15     2  0 08:23 ?        00:00:00 [kworker/1:0]
root        16     2  0 08:23 ?        00:00:00 [kworker/1:0H]
root        18     2  0 08:23 ?        00:00:00 [kdevtmpfs]
root        19     2  0 08:23 ?        00:00:00 [netns]
root        20     2  0 08:23 ?        00:00:00 [khungtaskd]
root        21     2  0 08:23 ?        00:00:00 [writeback]
root        22     2  0 08:23 ?        00:00:00 [kintegrityd]
root        23     2  0 08:23 ?        00:00:00 [bioset]
root        24     2  0 08:23 ?        00:00:00 [bioset]
root        25     2  0 08:23 ?        00:00:00 [bioset]
root        26     2  0 08:23 ?        00:00:00 [kblockd]
root        27     2  0 08:23 ?        00:00:00 [md]
root        28     2  0 08:23 ?        00:00:00 [edac-poller]
root        29     2  0 08:23 ?        00:00:00 [watchdogd]
root        30     2  0 08:23 ?        00:00:00 [kworker/1:1]
root        31     2  0 08:23 ?        00:00:00 [kworker/0:1]
root        36     2  0 08:23 ?        00:00:00 [kswapd0]
root        37     2  0 08:23 ?        00:00:00 [ksmd]
root        38     2  0 08:23 ?        00:00:00 [crypto]
root        46     2  0 08:23 ?        00:00:00 [kthrotld]
root        48     2  0 08:23 ?        00:00:00 [kmpath_rdacd]
root        49     2  0 08:23 ?        00:00:00 [kaluad]
root        50     2  0 08:23 ?        00:00:00 [kpsmoused]
root        51     2  0 08:23 ?        00:00:00 [ipv6_addrconf]
root        64     2  0 08:23 ?        00:00:00 [deferwq]
root        65     2  0 08:23 ?        00:00:00 [kworker/0:2]
root       132     2  0 08:23 ?        00:00:00 [kauditd]
root       200     2  0 08:23 ?        00:00:00 [iscsi_eh]
root       275     2  0 08:23 ?        00:00:00 [rpciod]
root       276     2  0 08:23 ?        00:00:00 [xprtiod]
root       409     2  0 08:23 ?        00:00:00 [ata_sff]
root       694     2  0 08:23 ?        00:00:00 [scsi_eh_0]
root       695     2  0 08:23 ?        00:00:00 [cnic_wq]
root       699     2  0 08:23 ?        00:00:00 [scsi_tmf_0]
root       700     2  0 08:23 ?        00:00:00 [bnx2i_thread/0]
root       701     2  0 08:23 ?        00:00:00 [bnx2i_thread/1]
root       703     2  0 08:23 ?        00:00:00 [scsi_eh_1]
root       705     2  0 08:23 ?        00:00:00 [virtscsi-scan]
root       706     2  0 08:23 ?        00:00:00 [scsi_tmf_1]
root       708     2  0 08:23 ?        00:00:00 [scsi_eh_2]
root       709     2  0 08:23 ?        00:00:00 [kworker/u4:2]
root       710     2  0 08:23 ?        00:00:00 [scsi_tmf_2]
root       716     2  0 08:23 ?        00:00:00 [ttm_swap]
root       874     2  0 08:23 ?        00:00:00 [bioset]
root       875     2  0 08:23 ?        00:00:00 [xfsalloc]
root       876     2  0 08:23 ?        00:00:00 [xfs_mru_cache]
root       877     2  0 08:23 ?        00:00:00 [xfs-buf/sda3]
root       878     2  0 08:23 ?        00:00:00 [xfs-data/sda3]
root       879     2  0 08:23 ?        00:00:00 [xfs-conv/sda3]
root       880     2  0 08:23 ?        00:00:00 [xfs-cil/sda3]
root       881     2  0 08:23 ?        00:00:00 [xfs-reclaim/sda]
root       882     2  0 08:23 ?        00:00:00 [xfs-log/sda3]
root       883     2  0 08:23 ?        00:00:00 [xfs-eofblocks/s]
root       884     2  0 08:23 ?        00:00:00 [xfsaild/sda3]
root       885     2  0 08:23 ?        00:00:00 [kworker/0:1H]
root      1001     1  0 08:23 ?        00:00:01 /usr/lib/systemd/systemd-journald
root      1017     1  0 08:23 ?        00:00:00 /usr/sbin/lvmetad -f
root      1033     1  0 08:23 ?        00:00:00 /usr/lib/systemd/systemd-udevd
root      1051     2  0 08:23 ?        00:00:00 [kworker/1:1H]
root      1218     2  0 08:23 ?        00:00:00 [kvm-irqfd-clean]
root      1308     2  0 08:23 ?        00:00:00 [nfit]
root      1401     1  0 08:23 ?        00:00:00 /sbin/auditd
root      1445     1  0 08:23 ?        00:00:00 /usr/lib/systemd/systemd-logind
dbus      1446     1  0 08:23 ?        00:00:00 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation
rpc       1447     1  0 08:23 ?        00:00:00 /sbin/rpcbind -w
root      1449     1  0 08:23 ?        00:00:00 /usr/sbin/irqbalance --foreground
root      1451     1  0 08:23 ?        00:00:00 /usr/sbin/abrtd -d -s
root      1453     1  0 08:23 ?        00:00:00 /usr/bin/abrt-watch-log -F BUG: WARNING: at WARNING: CPU: INFO: possible recursive locking detected ernel BUG at list_del corrupt
root      1454     1  0 08:23 ?        00:00:00 /usr/sbin/smartd -n -q never
root      1463     1  0 08:23 ?        00:00:00 /usr/sbin/gssproxy -D
root      1464     1  0 08:23 ?        00:00:01 /sbin/rngd -f
libstor+  1465     1  0 08:23 ?        00:00:00 /usr/bin/lsmd -d
polkitd   1467     1  0 08:23 ?        00:00:00 /usr/lib/polkit-1/polkitd --no-debug
chrony    1476     1  0 08:23 ?        00:00:00 /usr/sbin/chronyd
root      1916     1  0 08:23 ?        00:00:00 /sbin/dhclient -1 -q -lf /var/lib/dhclient/dhclient--ens3.lease -pf /var/run/dhclient-ens3.pid -H michalsvm ens3
root      1978     1  0 08:23 ?        00:00:00 /usr/bin/python2 -Es /usr/sbin/tuned -l -P
root      2233     1  0 08:23 ?        00:00:00 /usr/libexec/postfix/master -w
postfix   2234  2233  0 08:23 ?        00:00:00 pickup -l -t unix -u
postfix   2235  2233  0 08:23 ?        00:00:00 qmgr -l -t unix -u
oracle-+  2243     1  0 08:23 ?        00:00:00 /usr/sbin/oracle-cloud-agent
root      2246     1  0 08:23 ?        00:00:00 /usr/sbin/oracle-cloud-agent-updater
root      2249     1  0 08:23 ?        00:00:00 /usr/sbin/rsyslogd -n
oracle-+  2253  2243  0 08:23 ?        00:00:02 /usr/sbin/oracle-cloud-agent
root      2254  2246  0 08:23 ?        00:00:02 /usr/sbin/oracle-cloud-agent-updater
root      2256     1  0 08:23 ?        00:00:00 /usr/sbin/crond -n
root      2260     1  0 08:23 ?        00:00:00 /usr/sbin/atd -f
root      2270     1  0 08:23 ttyS0    00:00:00 /sbin/agetty --keep-baud 115200,38400,9600 ttyS0 vt220
root      2274     1  0 08:23 tty1     00:00:00 /sbin/agetty --noclear tty1 linux
root      2432     1  0 08:23 ?        00:00:00 /usr/sbin/sshd -D
root      8709     1  0 08:24 ?        00:00:00 nginx: master process /usr/sbin/nginx
nginx     8710  8709  0 08:24 ?        00:00:00 nginx: worker process
nginx     8711  8709  0 08:24 ?        00:00:00 nginx: worker process
root      8753     1  0 08:24 ?        00:00:00 /usr/bin/python2 -Es /usr/sbin/firewalld --nofork --nopid
root     10145  2432  0 08:28 ?        00:00:00 sshd: opc [priv]
opc      10148 10145  0 08:29 ?        00:00:00 sshd: opc@pts/0
opc      10149 10148  0 08:29 pts/0    00:00:00 -bash
root     10177 10149  0 08:29 pts/0    00:00:00 sudo su -
root     10179 10177  0 08:29 pts/0    00:00:00 su -
root     10180 10179  0 08:29 pts/0    00:00:00 -bash
root     10196     1  0 08:29 ?        00:00:00 /usr/sbin/abrt-dbus -t133
root     10216     2  0 08:29 ?        00:00:00 [kworker/1:2]
root     10218 10180  0 08:29 pts/0    00:00:00 ps -ef
[root@michalsvm ~]# exit


```
#### 5.Clean OCI infrastructure
```
$ terraform destroy
```
