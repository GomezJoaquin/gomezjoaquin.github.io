---

title: "Create a Read-Only User in MySQL"
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

## Creating a Read-Only User in MySQL
Create a read-only user for the `DataBase` database, allowing connections from any host.

---

## Steps Performed

### 1. Connect to the MySQL Server

Connected to the MySQL server using a user with sufficient privileges (e.g., `root`).

```bash
mysql -u root -p
```

### 2. Create the User

Created the `user_readonly` user, allowing connections from any host (`%`). This user was created without initial privileges using the following command:

```sql
CREATE USER 'user_readonly'@'%' IDENTIFIED BY 'password';
```

### 2.1 Create the User to Connect from a Specific Host

```sql
CREATE USER 'user_readonly'@'192.168.1.100' IDENTIFIED BY 'password';
```

For exact ranges:

```sql
CREATE USER 'user_readonly'@'192.168.1.100-192.168.1.110' IDENTIFIED BY 'password';
```

You can also specify a hostname if it is configured in the DNS:

```sql
CREATE USER 'user_readonly'@'examplehostname.com' IDENTIFIED BY 'password';
```

**Notes**:
- It is a good security practice to restrict the host from which the user can connect to the database server.
- Replace `'password'` with a secure password.

### 3. Grant Read-Only Permissions

Granted read-only permissions (`SELECT`) on all tables in the `DataBase` database using the following command:

```sql
GRANT SELECT ON DataBase.* TO 'user_readonly'@'%';
```

### 4. Apply Changes

Applied the changes to ensure that the new permissions take effect:

```sql
FLUSH PRIVILEGES;
```

### 5. Verify User Creation

To verify that the user was created successfully, the following query was executed:

```sql
SELECT User, Host FROM mysql.user;
```

The `user_readonly` user was searched for in the list of users. The expected output should include:

```
+---------------------+-----------+
| User                | Host      |
+---------------------+-----------+
| user_readonly       | %         |
| ...                 | ...       |
+---------------------+-----------+
```

### 6. Verify Permissions

To verify that the user has the correct permissions, logged in as `user_readonly` and executed:

```sql
SHOW GRANTS;
```

The expected output should include:

```
+----------------------------------------------------+
| Grants for user_readonly@%                         |
+----------------------------------------------------+
| GRANT USAGE ON *.* TO `user_readonly`@`%`          |
| GRANT SELECT ON `DataBase`.* TO `user_readonly`@`%`|
+----------------------------------------------------+
```

---

## Conclusions

A `user_readonly` user with read-only permissions has been created for the `DataBase` database, allowing connections from any host. It is recommended to secure the password and consider using secure connections (SSL) if the server is accessible over the Internet.

---
