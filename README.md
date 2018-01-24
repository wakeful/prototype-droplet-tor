## Requirements

[Digital Ocean Account](https://m.do.co/c/1bd9b3ad149e), [Ansible](https://www.ansible.com) and [terraform](https://www.terraform.io) installed on your local machine.


## Usage

Initializ provider plugin
```
$ terraform init

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "digitalocean" (0.1.2)...

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.
```

We need to copy and edit the **tfvars** file - add [do_token](https://cloud.digitalocean.com/settings/api/tokens) / change [region](https://developers.digitalocean.com/documentation/v2/#list-all-regions) etc.

```
$ cp terraform.tfvars.example terraform.tfvars
```

After editing **terraform.tfvars** file validate the configuration
```
$ terraform plan

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + digitalocean_droplet.tor
      id:                   <computed>
      disk:                 <computed>
      image:                "freebsd-11-1-x64"
      ipv4_address:         <computed>
      ipv4_address_private: <computed>
      ipv6_address:         <computed>
      ipv6_address_private: <computed>
      locked:               <computed>
      name:                 "pTor"
      price_hourly:         <computed>
      price_monthly:        <computed>
      region:               "lon1"
      resize_disk:          "true"
      size:                 "s-1vcpu-1gb"
      ssh_keys.#:           <computed>
      status:               <computed>
      vcpus:                <computed>

  + digitalocean_ssh_key.tor_key
      id:                   <computed>
      fingerprint:          <computed>
      name:                 "pTor ssh key"
      public_key:           "ssh-rsa AAAA...\n"

Plan: 2 to add, 0 to change, 0 to destroy.
```


Create **droplet**
```
$ terraform apply
digitalocean_ssh_key.tor_key: Refreshing state... (ID: 17773129)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + digitalocean_droplet.tor
      id:                   <computed>
      disk:                 <computed>
      image:                "freebsd-11-1-x64"
      ipv4_address:         <computed>
      ipv4_address_private: <computed>
      ipv6_address:         <computed>
      ipv6_address_private: <computed>
      locked:               <computed>
      name:                 "pTor"
      price_hourly:         <computed>
      price_monthly:        <computed>
      region:               "lon1"
      resize_disk:          "true"
      size:                 "s-1vcpu-1gb"
      ssh_keys.#:           "1"
      ssh_keys.0:           "17773129"
      status:               <computed>
      vcpus:                <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

digitalocean_droplet.tor: Creating...
  disk:                 "" => "<computed>"
  image:                "" => "freebsd-11-1-x64"
  ipv4_address:         "" => "<computed>"
  ipv4_address_private: "" => "<computed>"
  ipv6_address:         "" => "<computed>"
  ipv6_address_private: "" => "<computed>"
  locked:               "" => "<computed>"
  name:                 "" => "pTor"
  price_hourly:         "" => "<computed>"
  price_monthly:        "" => "<computed>"
  region:               "" => "lon1"
  resize_disk:          "" => "true"
  size:                 "" => "s-1vcpu-1gb"
  ssh_keys.#:           "" => "1"
  ssh_keys.0:           "" => "17773129"
  status:               "" => "<computed>"
  vcpus:                "" => "<computed>"

digitalocean_droplet.tor: Provisioning with 'local-exec'...
digitalocean_droplet.tor (local-exec): Executing: /bin/sh -c "sleep 30; ansible-playbook -i 'digitalocean_droplet_ip_address,' main.yml"

digitalocean_droplet.tor (local-exec): PLAY [main build] **************************************************************

digitalocean_droplet.tor (local-exec): TASK [tor : turn on random IP IDs] *********************************************
digitalocean_droplet.tor (local-exec): changed: [digitalocean_droplet_ip_address]

digitalocean_droplet.tor (local-exec): TASK [tor : install tor package] ***********************************************
digitalocean_droplet.tor (local-exec): changed: [digitalocean_droplet_ip_address]

digitalocean_droplet.tor (local-exec): TASK [tor : start tor on boot] *************************************************
digitalocean_droplet.tor (local-exec): changed: [digitalocean_droplet_ip_address]

digitalocean_droplet.tor (local-exec): TASK [tor : start tor Service] *************************************************
digitalocean_droplet.tor (local-exec): changed: [digitalocean_droplet_ip_address]

digitalocean_droplet.tor (local-exec): TASK [privoxy : install privoxy package] ***************************************
digitalocean_droplet.tor (local-exec): changed: [digitalocean_droplet_ip_address]

digitalocean_droplet.tor (local-exec): TASK [privoxy : check if config file is in place] ******************************
digitalocean_droplet.tor (local-exec): ok: [digitalocean_droplet_ip_address]

digitalocean_droplet.tor (local-exec): TASK [privoxy : copy sample config] ********************************************
digitalocean_droplet.tor (local-exec): changed: [digitalocean_droplet_ip_address]

digitalocean_droplet.tor (local-exec): TASK [privoxy : set tor as sock5 Proxy] ****************************************
digitalocean_droplet.tor (local-exec): changed: [digitalocean_droplet_ip_address]

digitalocean_droplet.tor (local-exec): TASK [privoxy : start privoxy on boot] *****************************************
digitalocean_droplet.tor (local-exec): changed: [digitalocean_droplet_ip_address]

digitalocean_droplet.tor (local-exec): TASK [privoxy : start privoxy Service] *****************************************
digitalocean_droplet.tor (local-exec): changed: [digitalocean_droplet_ip_address]

digitalocean_droplet.tor (local-exec): TASK [syslogd : configure syslogd] *********************************************
digitalocean_droplet.tor (local-exec): changed: [digitalocean_droplet_ip_address]

digitalocean_droplet.tor (local-exec): TASK [syslogd : restart syslogd service] ***************************************
digitalocean_droplet.tor (local-exec): changed: [digitalocean_droplet_ip_address]

digitalocean_droplet.tor (local-exec): PLAY RECAP *********************************************************************
digitalocean_droplet.tor (local-exec): digitalocean_droplet_ip_address               : ok=12   changed=11   unreachable=0    failed=0

digitalocean_droplet.tor: Creation complete

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.[0m

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: terraform.tfstate

Outputs:

  connection string = ssh -L 8118:127.0.0.1:8118 freebsd@digitalocean_droplet_ip_address
```

Now we just need to open a ssh tunel to new droplet (using the '*connection string*') and configure local **web browser** to use proxy on **127.0.0.1:8118**


## To remove droplet run
```
$ terraform destroy

Do you really want to destroy?
  Terraform will delete all your managed infrastructure.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

digitalocean_ssh_key.tor_key: Refreshing state... (ID: digitalocean_ssh_key_id)
digitalocean_droplet.tor: Refreshing state... (ID: digitalocean_droplet_id)
digitalocean_droplet.tor: Destroying...
digitalocean_droplet.tor: Destruction complete
digitalocean_ssh_key.tor_key: Destroying...
digitalocean_ssh_key.tor_key: Destruction complete

Apply complete! Resources: 0 added, 0 changed, 2 destroyed.
```
