---
title: "Por qué corro Kubernetes en kind y no en minikube ni en un lab hosteado"
date: 2026-07-30T10:00:00-03:00
draft: false
author: "Joaquín Gómez"
tags:
  - Kubernetes
  - kind
  - Local Development
description: "Una decisión de cluster local tomada bajo una restricción real: 24 GB de RAM, multinodo obligatorio y destruido varias veces por día."
images:
  - "/images/og/why-kind-not-minikube.es.png"
toc: true
---

Cada guía que te dice "levantá un cluster local" se saltea la parte donde elegís cuál, como si la elección fuera cosmética. No lo es. La herramienta que elegís determina qué habilidad terminás practicando, y la mayoría elige la que justamente elimina la habilidad que quería aprender.

Esta es mi decisión, las restricciones detrás, y dónde está equivocada.

## Las restricciones

**24 GB de RAM en una laptop donde además trabajo.** Esta es la restricción que ata todo y elimina más opciones que cualquier otra cosa. El cluster no es lo único que corre en la máquina.

**Multinodo no es opcional.** Un cluster de un solo nodo esconde una categoría entera de comportamiento. El scheduling es trivial cuando hay un solo lugar donde schedulear. No podés ver a un `nodeSelector` hacer nada, no podés drenar un nodo, no podés mirar cómo desalojan un pod y aterriza en otro lado, y el anti-affinity es un no-op. Eso es exactamente lo que separa "sé desplegar" de "sé operar", y necesita como mínimo un control plane más dos workers.

**Destruyo el cluster varias veces por día.** Es deliberado. Si recrear el cluster es caro, empiezo a protegerlo, y un cluster que tengo miedo de romper no sirve para aprender. El teardown barato es lo que compra el permiso de experimentar.

## Las opciones

**Labs hosteados** (clusters listos, en el navegador). Cero setup, nada que instalar, cero costo de RAM. Y resuelven el problema equivocado para mí: te entregan un cluster andando. Si la habilidad que estoy comprando es operar un cluster, un servicio que lo pre-opera me saca justo aquello por lo que fui. Nunca escribo la topología de nodos, nunca veo fallar el bootstrap, nunca aprendo cómo se ve un cluster roto mientras levanta. Son excelentes para practicar exámenes contra reloj y los usaría para eso. Para esto no.

**minikube.** Maduro, ecosistema enorme de addons, una historia real de `LoadBalancer` vía `minikube tunnel`, ingress como addon de una línea. Es la opción más amable y para un flujo de un solo nodo probablemente lo recomendaría por encima de kind. Pero su soporte multinodo es más pesado y más lento que el de kind, y su centro de gravedad es una VM por cluster. Con 24 GB compartidos con todo lo demás, minikube multinodo es donde mi restricción muerde.

**kind.** Los nodos son contenedores Docker, no VMs. Un cluster de tres nodos levanta en bastante menos de un minuto y cuesta una fracción del equivalente en VMs. La topología es un YAML que es mío y está commiteado. Ese último punto fue el que decidió.

## Qué decidió de verdad

La definición del cluster es un archivo del repositorio:

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
```

y crear y destruir son scripts, no instrucciones:

```bash
make cluster-up     # bootstrap/up.sh
make cluster-down   # bootstrap/down.sh
```

Esta es la diferencia entre un cluster que otra persona puede reproducir y un cluster que solo reproduzco yo. Y también la diferencia entre "acá van once comandos que tenés que correr" en un README y un comando que o funciona o falla ruidosamente. Scriptear el ciclo de vida vale más que cualquier comparación de features entre las herramientas, y es la parte que la gente se saltea.

## Qué me cuesta kind

Siendo honesto con el trade-off, porque un artículo de decisión que solo lista ventajas es una publicidad:

**No hay `LoadBalancer`.** Los Services de tipo `LoadBalancer` quedan en `Pending` para siempre. Lo resolvés con `extraPortMappings` en la config de kind, con NodePort, o instalando MetalLB. En un cluster manejado esto es gratis, así que estoy practicando un workaround que no se transfiere.

**Las imágenes hay que cargarlas.** Una imagen construida localmente no la ven los nodos hasta que hacés `kind load docker-image`. Olvidarse de esto y quedarse mirando un `ErrImagePull` es un rito de iniciación. Los clusters reales bajan de un registry, así que otra vez, mi loop diario se parece apenas al real.

**El almacenamiento es solo local-path.** Alcanza para aprender la mecánica de los PVC, no sirve para aprender cómo se comporta una `StorageClass` de verdad, y no te enseña nada sobre qué pasa cuando un volumen no se puede desmontar.

**Los nodos son contenedores.** Todo lo que dependa del kernel o del límite entre nodo y host se comporta distinto. Algunos experimentos de `NetworkPolicy` y de CNI no se reproducen fielmente.

Vale la pena nombrar el patrón de esa lista: kind es excelente en el control plane y en la capa de workloads, y débil en todo lugar donde el cluster toca infraestructura real. Que es un lugar razonable para ser débil mientras aprendés workloads, y un mal lugar para ser débil después. Cuando llegue a las capas que miran a la infraestructura, esta herramienta deja de ser la correcta, y prefiero escribirlo ahora que descubrirlo como sorpresa.

## Dónde elegiría distinto

- **Si necesitara un solo nodo:** minikube. El ecosistema de addons vale más que la ventaja de velocidad de kind cuando la velocidad no es la restricción.
- **Si estuviera preparando un examen con tiempo:** un lab hosteado, porque la habilidad que se evalúa es velocidad dentro del cluster de otro, que es exactamente lo que esos entornos entrenan.
- **Si tuviera 64 GB:** la restricción desaparece y probablemente correría k3s sobre VMs reales, que se parece a un cluster de verdad justo en las dimensiones donde kind está más lejos.

La regla general que sacaría: elegí el cluster local que abarate lo que estás tratando de aprender *ahora*, y sé explícito sobre lo que te vuelve invisible. Todas estas herramientas son una simplificación, y la simplificación solo es segura mientras la puedas nombrar.
