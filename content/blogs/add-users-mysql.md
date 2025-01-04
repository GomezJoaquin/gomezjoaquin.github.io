---
title: "Crear un Usuario de Solo Lectura en MySQL"
date: 2025-01-04T00:00:00+00:00
draft: false
author: "Joaquín Gómez"
tags:
  - MySQL
image: /images/add-user-mysq.jpg
description: ""
toc: true
mathjax: true
---

## Creación de Usuario solo lectura en MySQL
Crear un usuario de solo lectura para la base de datos `DataBase`, permitiendo conexiones desde cualquier host.

---
## Pasos Realizados

### 1. Conexión al Servidor MySQL

Se realizó la conexión al servidor MySQL utilizando un usuario con privilegios suficientes (por ejemplo, `root`).

```bash
mysql -u root -p
```

### 2. Creación del Usuario

Se creó el usuario `user_readonly` que podrá conectarse desde cualquier host (`%`). Este usuario fue creado sin privilegios iniciales utilizando el siguiente comando:

```sql
CREATE USER 'user_readonly'@'%' IDENTIFIED BY 'contraseña';
```

### 2.1 Creación del Usuario para que solo se pueda conectar desde un host especifico




```sql
CREATE USER 'user_readonly'@'192.168.1.100' IDENTIFIED BY 'contraseña';
```
con rangos exactos: 

```sql
CREATE USER 'user_readonly'@'192.168.1.100-192.168.1.110' IDENTIFIED BY 'contraseña';
```


También se puede especificar un nombre de host, si está configurado en el DNS: 

```sql
CREATE USER 'user_readonly'@'examplehostname.com' IDENTIFIED BY 'contraseña';
```

**Notas**:
- Es una buena práctica de seguridad restringir el host desde donde el usuario debe conectarse al servidor de bases de datos. 
- Sustituir `'contraseña'` por una contraseña segura.
  

### 3. Otorgar Permisos de Solo Lectura

Se otorgaron permisos de solo lectura (`SELECT`) sobre todas las tablas de la base de datos `DataBase` con el siguiente comando:

```sql
GRANT SELECT ON DataBase.* TO 'user_readonly'@'%';
```

### 4. Aplicar Cambios

Se aplicaron los cambios realizados para asegurar que los nuevos permisos tomen efecto:

```sql
FLUSH PRIVILEGES;
```

### 5. Verificación de la Creación del Usuario

Para verificar que el usuario fue creado correctamente, se ejecutó la siguiente consulta:

```sql
SELECT User, Host FROM mysql.user;
```

Se buscó el usuario `user_readonly` en la lista de usuarios. La salida esperada debería incluir:

```
+---------------------+-----------+
| User                | Host      |
+---------------------+-----------+
| user_readonly       | %         |
| ...                 | ...       |
+---------------------+-----------+
```

### 6. Verificación de Permisos

Para verificar que el usuario tiene los permisos correctos, se inició sesión como `user_readonly` y se ejecutó:

```sql
SHOW GRANTS;
```

La salida esperada debería incluir:

```
+----------------------------------------------------+
| Grants for user_readonly@%                     |
+----------------------------------------------------+
| GRANT USAGE ON *.* TO `user_readonly`@`%`      |
| GRANT SELECT ON `DataBase`.* TO `user_readonly`@`%` |
+----------------------------------------------------+
```

## 

## Conclusiones

Se ha creado un usuario `user_readonly` con permisos de solo lectura en la base de datos `DataBase`, permitiendo conexiones desde cualquier host. Se recomienda asegurar la contraseña y considerar el uso de conexiones seguras (SSL) si el servidor es accesible a través de Internet.



---

