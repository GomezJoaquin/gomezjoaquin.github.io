---
title: "I AM"
date: 2024-12-28T01:54:00+05:30
draft: false
#author: "Joaquín Gómez"
tags:
  - AWS
  - Cloud
  - IAM
image: /images/iam.png
description: ""
toc: true
mathjax: true
---

## AWS: I AM Identiy and Acces Management

Es un servicio global. 

Se utiliza para gestionar el acceso a los recursos de la nube, controlando quién puede realizar qué acciones sobre qué recursos mediante políticas de permisos.

**Cuenta root/ raíz** es la cuenta que se crea por defecto, es buena práctica utilizarla unicamente. cuando es necesario ser root, para el resto de tareas utilizar una cuenta con el mimino privilegio. 

**Usuarios**: Representan a personas dentro de una organización. 1 usuario  = 1 persona. 

**Grupos:** Su única función en contener a los usuarios, no es posible que un grupo contenga a otro grupo. 

* Los usuarios no tienen por que pertenecer a un grupo. 
* Los usuarios pueden pertenecer a multiples grupos en simultaneo. 


The [IAM Policies](https://gomezjoaquin.github.io/blogs/aws-iam-policies/).
