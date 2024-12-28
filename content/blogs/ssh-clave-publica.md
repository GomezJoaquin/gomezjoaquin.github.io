---
title: "Configuración de Claves SSH en Windows y Linux: Guía Práctica"
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

## Habilita Conexión SSH con Clave Pública en Windows y Servidores Linux

###### Usar la clave pública que en Windows se encuentra en la carpeta del usuario

La clave pública de SSH en Windows se encuentra en la siguiente ruta:

```
C:\Users\TuUsuario\.ssh\id_rsa.pub
```

Si no hay una clave, será necesario **generar una**.

---

###### Generar una clave SSH en la máquina local

1. Abrir **PowerShell** y ejecutar el siguiente comando para generar una nueva clave SSH:

   ```bash
   ssh-keygen -t rsa -b 4096
   ```

---

###### Copia la clave pública al servidor

Para copiar la clave pública al servidor, puedes utilizar el siguiente comando:

```bash
ssh-copy-id usuario@direccion_ip_del_servidor
```

**Nota:** Este comando **no es nativo en Windows**. Sin embargo, si tienes instalado **Git Bash** en Windows, puedes usarlo.

---

###### Copiar la clave pública al servidor Linux a la "vieja escuela"

Si no tienes Git Bash o prefieres hacerlo manualmente, sigue estos pasos:

1. **Copiar el contenido de la clave pública** desde la máquina local:

   ```bash
   cat $HOME\.ssh\id_rsa.pub
   ```

2. **Conéctate al servidor** usando la contraseña y ejecuta los siguientes comandos:

   ```bash
   mkdir -p ~/.ssh
   chmod 700 ~/.ssh
   echo "PEGA_AQUÍ_TU_CLAVE_PÚBLICA" >> ~/.ssh/authorized_keys
   chmod 600 ~/.ssh/authorized_keys
   ```

O puedes usar este comando, que es más práctico y seguro de que quede bien copiado:

```bash
cat ~/.ssh/id_rsa.pub | ssh joaquin@192.168.1.5 'cat >> ~/.ssh/authorized_keys'
```

---

### Habilitar la conexión con clave pública-privada

En las últimas versiones de **Ubuntu Server**, las líneas que permiten la conexión con clave pública-privada suelen venir comentadas en el archivo de configuración. Para habilitarla:

1. Edita el archivo de configuración de SSH:

   ```bash
   sudo vi /etc/ssh/sshd_config
   ```

2. Asegúrate de que las siguientes líneas estén habilitadas (sin `#` al principio):

   ```bash
   PubkeyAuthentication yes
   AuthorizedKeysFile .ssh/authorized_keys
   ```

3. **Reinicia el servicio SSH** para aplicar los cambios:

   ```bash
   sudo systemctl restart ssh
   ```

---

