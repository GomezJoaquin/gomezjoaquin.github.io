---
title: "I AM Policies"
date: 2024-12-28T01:54:00+05:30
draft: false
author: "Joaquín Gómez"
tags:
  - AWS
  - Cloud
  - IAM
image: /images/structure-policies.png
description: ""
toc: true
mathjax: true
---

## AWS: IAM Policies

Las políticas se utilizan para definir los permisos de los usuarios. 
A los usuarios se les pueden asignar politicas mediante documentos JSON.

Es una buena práctica aplicar el ***principio de mínimo privilegio.*** : No dar más permisos de los que el usuario necesita. 

## Herencia de políticas IAM

Existen las políticas por grupo y las politicas directas. 

Las políticas directas se aplican directamente sobre el usuario a diferencia de las politicas de grupos que se aplican a todos los usuarios pertenecientes a ese grupo.

## Estructura de las políticas IAM

Consta de: 
- **Version**: Version del lenguaje de la política, siempre incluye "2012-10-17" 
- **Id**: Un identificador para la política (opcional)
- **Statement**: Una o más declaraciones individuales (Obligatorio).
- **Sid**: Es un identificador para la declaración 
- **Prinicipal**: Cuenta/Usuario/Rol al que se aplica esta política. 
- **Action**: Lista de recursos a los que se aplican las acciones.
- **Resource:** Lista de recursos a los que se aplican las acciones. 
- **Condicion:** Condiciones para cuando esta política está en efecto (opcional).