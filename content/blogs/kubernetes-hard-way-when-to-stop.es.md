---
title: "Kubernetes the Hard Way: para qué sirve y cuándo parar"
date: 2026-07-26T10:00:00-03:00
draft: false
author: "Joaquín Gómez"
tags:
  - Kubernetes
  - Learning
description: "Enseña una sola cosa muy bien y calla sobre todo lo demás. Saber cuál es cuál te dice cuándo terminaste."
toc: true
---

Hice Kubernetes the Hard Way, cumplió su función, y después paré y me pasé a `kind`. Las dos mitades importan. El ejercicio se recomienda mucho y se acota poco, así que la gente o lo saltea y queda supersticiosa respecto del control plane, o lo repite y confunde la repetición con avance.

## Para qué sirve realmente

El punto no es aprender a instalar Kubernetes. Nadie instala Kubernetes así, incluida la gente que recomienda el ejercicio. El punto es que saca la abstracción que te permite tratar al control plane como una única cosa opaca llamada "el cluster".

Generás los certificados vos. Levantás etcd vos. Configurás el API server, el scheduler y el controller manager como procesos separados con flags explícitos, y conectás cada kubelet al API server a mano. Nada viene empaquetado, así que nada se puede esconder.

El resultado es un cambio específico y duradero: dejás de pensar Kubernetes como un sistema y empezás a pensarlo como un puñado de programas que se hablan por una API, con todo guardado en un solo key-value store. Eso no es un dato de color. Es el modelo que después hace posible diagnosticar, porque cuando algo se rompe podés preguntarte *qué componente* está en problemas en vez de concluir "el cluster está roto".

La parte de certificados es la que más paga y de la que más se queja todo el mundo. Cablear mTLS entre cada componente a mano es tedioso, y también es la razón por la que seis meses después un certificado vencido en un kubelet es una molestia para vos en vez de un misterio. Casi todo el que encuentra indescifrables las fallas de auth de un cluster nunca emitió esos certificados ni una vez.

## Qué no enseña

Esta es la parte que se suele omitir, y es la mayor parte de la superficie del trabajo.

No te enseña nada sobre **operar** un cluster. Nada de upgrades, de drenar nodos, de backup y restore de etcd, ni de capacidad. Construís el cluster una vez, en estado limpio, sin tráfico y sin usuarios, y ahí termina el tutorial — que es exactamente donde empieza el trabajo operativo.

No te enseña nada sobre **workloads**. Deployments, Services, ConfigMaps, probes, resource requests, ingress, RBAC para humanos de verdad: nada. Vas a terminar con un control plane andando y sin idea de cómo correr bien una aplicación arriba.

No te enseña nada sobre **debugging**. Cada paso es una instrucción que ya se sabe correcta. Nunca diagnosticás nada: seguís y funciona, o tenés un error de tipeo. El trabajo real con clusters es casi enteramente la otra cosa.

O sea: construye un modelo mental y no construye nada más. Es un intercambio justo por el tiempo, siempre que sepas que ese es el intercambio.

## Cuándo parar

La señal que usé: **cuando podés explicar qué hace cada componente y por qué necesita hablar con los otros, sin mirar, terminaste.**

Concretamente, si podés responder esto de memoria, pará:

- ¿Qué escribe realmente el scheduler cuando schedulea un pod, y quién actúa sobre eso?
- ¿Qué hay en etcd, y qué le pasa a un cluster andando si etcd no está disponible?
- ¿Por qué el kubelet necesita un certificado, y qué se rompe cuando vence?
- ¿Cuál es la diferencia entre el controller manager y el scheduler?

Si podés, hacer el ejercicio una segunda vez no te enseña nada nuevo. Es ritual. Y acá hay una tentación real, porque el tutorial tiene una propiedad inusualmente satisfactoria: es largo, es difícil, y tiene el éxito garantizado si lo seguís. Esa combinación se siente exactamente igual que avanzar sin producir avance, y es una forma mucho más cómoda de pasar un sábado que debuggear tu propio cluster roto sin instrucciones.

## Qué hacer después

Pasá a la capa de arriba, y cambiá a una herramienta que abarate los clusters para que tu tiempo se vaya en workloads y no en bootstrap. Para mí eso es `kind`: tres nodos en menos de un minuto, destruidos y recreados varias veces por día.

El orden importa y es el inverso del consejo habitual. La mayoría de los caminos arrancan con `kubectl apply` sobre un cluster manejado y bajan hacia el control plane, si es que alguna vez llegan. Arrancar desde abajo significa que cuando te encontrás con Deployments y Services ya sabés qué hay debajo, así que son mecanismos y no palabras mágicas. Vale el desvío una vez.

Una. El valor de Kubernetes the Hard Way está todo adelante, y el modo de falla no es saltearlo: es quedarse ahí, porque la planta baja es el lugar más cómodo del edificio y es la única parte de Kubernetes que viene con instrucciones.
