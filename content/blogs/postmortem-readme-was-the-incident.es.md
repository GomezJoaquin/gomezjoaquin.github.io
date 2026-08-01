---
title: "Postmortem: el incidente era el README"
date: 2026-08-01T10:00:00-03:00
draft: false
author: "Joaquín Gómez"
tags:
  - Postmortem
  - Kubernetes
  - CI/CD
description: "Audité mi propio repositorio de portfolio y encontré que la mitad de lo que prometía el README no existía. Este es el postmortem."
images:
  - "/images/og/postmortem-readme-was-the-incident.es.png"
toc: true
---

## Resumen

`pipeforge` es mi proyecto de entrega continua sobre Kubernetes. Su README abre con cuatro palabras:

> **Scaffold, ship, observe, auto-rollback.**

Dos de esos cuatro verbos describen software que no está en el repositorio. No hay recolección de métricas. No hay rollback automático. Nunca los hubo.

No se cayó nada en producción, porque no tengo producción. Lo que falló es lo único que un portfolio tiene que hacer: permitirle a un desconocido predecir lo que sé hacer a partir de lo que escribí. Este es el postmortem.

## Impacto

Un recruiter o un ingeniero que lee ese titular se forma una expectativa: esta persona armó un pipeline de progressive delivery que mira una señal y revierte un deploy malo sin intervención humana. Quien después abre el repo encuentra un scaffold bien ordenado y nada de eso.

El daño no es "el proyecto está incompleto". Incompleto es normal y perdonable. El daño es que la distancia entre lo que afirmo y lo que hay es en sí misma un dato, y es del peor tipo: dice que no sé calibrar mis propias afirmaciones.

Calibrar es buena parte del trabajo. Un ingeniero de guardia que reporta "se cayó la base" cuando hay una réplica degradada le cuesta una hora al equipo. Alguien que dice "tengo auto-rollback" cuando tiene un `Makefile` le cuesta a un hiring manager un proceso entero de entrevistas. La brecha técnica se recupera en un fin de semana. La de credibilidad no.

## Qué existe realmente

Para ser preciso sobre la diferencia, esto es lo que el repositorio contiene de verdad, todo verificable clonándolo:

- Una definición de cluster `kind`: un control plane y dos workers, creado por `bootstrap/up.sh` y destruido por `bootstrap/down.sh`.
- Tres servicios stub: `catalog-api` (Python/FastAPI), `orders-api` (Go) y `notifications-worker` (Node.js). Cada uno con tests que pasan.
- Un `Makefile` con `cluster-up`, `test-all`, `build-all`, `cluster-down`.
- Un workflow de GitHub Actions que, por servicio, instala el toolchain, corre los tests y construye una imagen Docker.

Eso es un scaffold competente. `make cluster-up && make test-all` funciona en una máquina limpia, que es más de lo que puede decir buena parte de los repos de tutorial.

Y esto es lo que no existe:

- No hay Prometheus, ni endpoint de métricas, ni scraping. No se "observa" nada.
- No hay Argo Rollouts, ni canary, ni analysis template, ni rollback de ningún tipo — ni automático ni manual.
- `platform/` e `infra/` son directorios vacíos con la etiqueta `(coming)`.

## Cronología

| Cuándo | Qué |
|---|---|
| Abril 2026 | Scaffold del repo a lo largo de unas dos semanas. El README se escribe acá, describiendo el sistema que pensaba construir. |
| 19 de abril 2026 | Último push. El scaffold está terminado; la mitad interesante no está empezada. |
| Junio 2026 | Audito mis propios repositorios públicos. La brecha queda explícita. |
| Semana del 19 de junio 2026 | Me comprometo a construir el auto-rollback de verdad. |
| 1 de agosto 2026 | README sin cambios. Sigue prometiendo observe y auto-rollback. |

Seis semanas entre "voy a arreglar esto" y "no arreglé esto" es la parte de la cronología que importa. Descarta la explicación cómoda: que no me había dado cuenta.

## Causa raíz

La causa próxima es trivial: escribí el README antes que el software, y nunca lo corregí.

La pregunta interesante es por qué la corrección no ocurrió, sabiéndolo. Yendo hacia atrás:

**¿Por qué no está construido el rollback?** Porque es la parte difícil. Hacer scaffold tiene feedback rápido y ningún modo de falla real: un árbol de directorios está listo cuando se ve bien. Hacer que un rollback dispare correctamente ante una señal real tiene feedback lento y puede fallar a la vista: la métrica puede estar mal, el umbral puede estar mal, el análisis puede pasar mientras el servicio está roto. Esas son las fallas que enseñan algo, que es exactamente por qué las postergué.

**¿Por qué no se corrigió el README mientras tanto?** Porque un README es el único artefacto de un repositorio que no tiene test. El código Go tiene `go test`. El Python tiene `pytest`. CI corre todo en cada push. El README es el único archivo donde puedo afirmar cualquier cosa y ninguna parte del sistema me contradice. La deriva de documentación se discute normalmente como problema de mantenimiento — docs que se quedan atrás del código. Esto es al revés y es peor: docs que van *adelante* del código, que no es deriva sino un pronóstico publicado como si fuera un hecho.

**¿Por qué `(coming)` sobrevivió cuatro meses?** Porque `(coming)` es una promesa sin fecha y sin responsable. En un postmortem real, un action item sin dueño y sin fecha no se hace, y todo el mundo lo sabe. Yo escribí tres en el layout de mi propio repo y los traté como avance.

Así que la causa raíz no es pereza ni falta de tiempo. Es que tenía un flujo donde escribir la afirmación sustituía la satisfacción de construir la cosa, y ningún mecanismo en ningún lado que obligara a la afirmación a responder por sí misma.

## Qué salió bien

- El scaffold es reproducible de verdad. El ciclo de vida del cluster está scripteado en vez de documentado como una lista de pasos manuales, que es la diferencia entre algo que otra persona puede correr y algo que solo corro yo.
- CI existe y hace trabajo real en cada push, sobre tres lenguajes.
- La auditoría ocurrió, y ocurrió porque fui a buscar, no porque alguien me lo señalara.

## Qué salió mal

- El README describía intenciones en presente.
- Usé `(coming)` como decoración para que un directorio vacío pareciera un plan.
- Confundí "sé lo que habría que construir acá" con "lo construí". Lo primero vale muy poco: cualquier ingeniero sabe qué debería contener un pipeline de progressive delivery, y un LLM te escribe el árbol de directorios en diez segundos.

## Action items

| Acción | Responsable | Estado |
|---|---|---|
| Reescribir el README para describir solo lo que corre hoy | yo | hecho — este post es la versión pública |
| Borrar cada marca `(coming)` en vez de maquillarla | yo | hecho |
| Toda afirmación del titular tiene que mapear a un comando que el lector pueda correr | yo | regla permanente |
| Construir el rollback y después escribir sobre el rollback — en ese orden | yo | abierto |

El último es el trabajo de verdad y no voy a poner una fecha acá, porque anunciar fechas en público es precisamente el modo de falla del que trata todo este documento.

## Lo que le diría a otro

Si tenés un repositorio de portfolio, abrí el README y marcá cada frase como una de tres cosas: algo que el lector puede verificar corriendo un comando, algo que puede verificar leyendo el código, o algo que tiene que creerte. Borrá la tercera categoría. Toda.

Después mirá el signo de tus errores. La documentación de todos es imperfecta, pero la dirección importa. Docs que subestiman lo que hay te cuestan crédito que ya te habías ganado. Docs que exageran te cuestan el crédito que sí te ganaste, porque cuando un lector detecta una afirmación inflada descuenta todo el resto de la página — incluido lo que era cierto.

Yo tenía un bootstrap funcionando de cluster multinodo y CI honesto en tres lenguajes, y enterré las dos cosas abajo de un titular que hace desconfiar del repositorio entero. Es un mal negocio, y lo hice gratis.
