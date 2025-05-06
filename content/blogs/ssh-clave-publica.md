---

title: "Configuring SSH Keys on Windows and Linux: A Practical Guide"
date: 2024-12-28T01:54:00+05:30
draft: false
author: "Joaquín Gómez"
tags:
  - Linux
  - Windows
  - SSH
image: /images/cifrado-asimetrico.jpg
description: ""
toc: true
mathjax: true
---

## Enable SSH Connection with Public Key on Windows and Linux Servers

###### Use the public key located in the user's folder on Windows

The SSH public key on Windows can be found at the following path:

```
C:UsersYourUser.sshid_rsa.pub
```

If there is no key, you will need to **generate one**.

---

###### Generate an SSH key on the local machine

1. Open **PowerShell** and run the following command to generate a new SSH key:

   ```bash
   ssh-keygen -t rsa -b 4096
   ```

---

###### Copy the public key to the server

To copy the public key to the server, you can use the following command:

```bash
ssh-copy-id user@server_ip_address
```

**Note:** This command is **not natively available on Windows**. However, if you have **Git Bash** installed on Windows, you can use it.

---

###### Copy the public key to the Linux server manually

If you don't have Git Bash or prefer to do it manually, follow these steps:

1. **Copy the content of the public key** from the local machine:

   ```bash
   cat $HOME.sshid_rsa.pub
   ```

2. **Connect to the server** using the password and run the following commands:

   ```bash
   mkdir -p ~/.ssh
   chmod 700 ~/.ssh
   echo "PASTE_YOUR_PUBLIC_KEY_HERE" >> ~/.ssh/authorized_keys
   chmod 600 ~/.ssh/authorized_keys
   ```

Alternatively, you can use this command, which is more practical and ensures the key is copied correctly:

```bash
cat ~/.ssh/id_rsa.pub | ssh joaquin@192.168.1.5 'cat >> ~/.ssh/authorized_keys'
```

---

### Enable public-private key connection

In the latest versions of **Ubuntu Server**, the lines that allow public-private key connections are often commented out in the configuration file. To enable it:

1. Edit the SSH configuration file:

   ```bash
   sudo vi /etc/ssh/sshd_config
   ```

2. Make sure the following lines are enabled (without `#` at the beginning):

   ```bash
   PubkeyAuthentication yes
   AuthorizedKeysFile .ssh/authorized_keys
   ```

3. **Restart the SSH service** to apply the changes:

   ```bash
   sudo systemctl restart ssh
   ```

---
