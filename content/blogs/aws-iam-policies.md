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

Las políticas se utilizan para **definir los permisos** de los usuarios.  
A los usuarios se les pueden asignar políticas mediante documentos JSON.

Es una buena práctica aplicar el **_principio de mínimo privilegio_**: No dar más permisos de los que el usuario necesita. 

---

## Herencia de políticas IAM

Existen las políticas **por grupo** y las **políticas directas**.

- Las **políticas directas** se aplican directamente sobre el usuario.
- Las **políticas de grupo** se aplican a todos los usuarios pertenecientes a ese grupo.

---

## Estructura de las políticas IAM

Las políticas IAM tienen la siguiente estructura:

- **Version**: Versión del lenguaje de la política, siempre incluye `"2012-10-17"`.
- **Id**: Un identificador único para la política (opcional).
- **Statement**: Una o más declaraciones individuales (Obligatorio).
- **Sid**: Identificador para la declaración (opcional).
- **Principal**: Cuenta/Usuario/Rol al que se aplica esta política.
- **Action**: Lista de acciones que se pueden realizar sobre los recursos.
- **Resource**: Lista de recursos sobre los que se pueden realizar las acciones.
- **Condition**: Condiciones para cuando esta política está en efecto (opcional).

---

¡Ahora tienes una idea clara sobre las políticas IAM de AWS y su estructura!
