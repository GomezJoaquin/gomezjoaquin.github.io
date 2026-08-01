---
title: "Una nube, no dos: por qué maté mi track de Azure"
date: 2026-07-28T10:00:00-03:00
draft: false
author: "Joaquín Gómez"
tags:
  - AWS
  - Azure
  - Cloud
  - Career
description: "Tengo una certificación de fundamentos de Azure y dejé de profundizar en Azure a propósito. El razonamiento, y el caso en contra."
toc: true
---

Tengo el AZ-900 junto a mis certificaciones de AWS, y mi proyecto de portfolio originalmente pusheaba imágenes a Azure Container Registry. A principios de este año lo migré a ECR y dejé de sumar al track de Azure por completo.

No fue un juicio sobre las plataformas. Fue un juicio sobre lo que cuesta una segunda nube, y sobre lo que un CV con dos nubes comunica realmente.

## Qué señaliza la amplitud

Hay una suposición común: que listar AWS y Azure duplica tu mercado. Por lo que veo leyendo búsquedas y hablando con gente que contrata, en mi nivel hace algo más parecido a lo contrario.

Un CV con dos nubes a profundidad intermedia se lee como *familiaridad*. Un CV con una nube a profundidad operativa se lee como *competencia*. Son afirmaciones distintas y solo la segunda sobrevive una entrevista, porque las entrevistas no evalúan cobertura: evalúan el fondo de tu conocimiento en un solo lugar. La pregunta nunca es "nombrame un servicio que haga X". Es "esto está roto, ¿qué mirás primero?", y esa pregunta tiene fondo.

El que operó una nube en profundidad tiene el fondo muy abajo. El que cubrió dos nubes con el mismo esfuerzo total lo toca el doble de rápido, para cualquiera de los dos lados. Y la falla se nota más de lo que jamás se notó la amplitud, porque una respuesta superficial a una pregunta operativa se recuerda de una manera en que una lista larga de skills no.

## Qué transfiere y qué no

El argumento a favor de aprender multi-cloud es que los conceptos transfieren. Transfieren — y la transferencia es mucho más delgada de lo que suena.

**Transfiere bien.** Los modelos mentales. Identidad y evaluación de políticas, segmentación de red, la idea de un control plane manejado, el radio de impacto, la forma de una revisión bien arquitecturada. Si entendés por qué importa el menor privilegio en IAM, lo entendés en Entra ID.

**Transfiere mal.** Todo lo operativo. La forma específica en que la evaluación de políticas de IAM resuelve un deny explícito entre una SCP, una policy de recurso y un permissions boundary. Cuáles fallas son silenciosas. Qué cuota de servicio vas a tocar primero y qué error te tira cuando la tocás. Cuánto tarda de verdad una operación cuando está degradada, para saber si cinco minutos significan "esperá" o "escalá".

Esa segunda categoría es el valor entero de la experiencia, y es la parte que no transfiere. Saber el concepto significa que leés la documentación más rápido. No significa que puedas diagnosticar nada, y diagnosticar es lo escaso.

## El costo real es el mantenimiento, no el aprendizaje

El costo que subestimé no fueron las horas de aprender Azure. Fue que dos plataformas significan mantener dos juegos de hábitos, y los hábitos se degradan.

Cada nube que decís tener es una nube en la que tenés que mantenerte al día. Los servicios cambian, los defaults cambian, la forma recomendada de hacer algo se reemplaza. Seis meses sin tocar Azure y no soy una persona con skills de Azure: soy una persona con un modelo de Azure desactualizado, que es peor que ninguno, porque voy a agarrar algo con confianza y voy a estar equivocado. En una entrevista prefiero decir "no usé Azure" antes que recordarlo a medias.

Y el argumento de composición es decisivo para mí: toco AWS todos los días en el trabajo. La profundidad en AWS compone con mi trabajo — el mismo conocimiento se refuerza dos veces, y cada lado abarata al otro. Azure era lo opuesto: esfuerzo que ni reforzaba mi trabajo ni era reforzado por él. Era el único frente que tenía que no sacaba palanca de nada más de lo que estaba haciendo.

## El caso en contra de mi decisión

Corresponde ser honesto: esta decisión no es obviamente correcta, y los contraargumentos son reales.

**Si trabajás en una consultora, la amplitud es el producto.** A las agencias les cae lo que el cliente ya tiene corriendo. Ahí, "tenemos gente de Azure" es un hecho comercial, y un especialista angosto sirve menos que alguien a quien podés poner en cualquiera de las dos.

**Los mercados regionales difieren.** En mercados donde dominan la empresa grande y el sector público, la penetración de Azure es alta y el especialista solo-AWS está pescando en el estanque chico. Conviene verificarlo localmente en vez de suponerlo, porque los números globales de market share no describen tu ciudad.

**Dos nubes son un seguro real.** Apostar una carrera a la vigencia continuada de un solo proveedor es una apuesta. Es una que me resulta cómoda a cinco años y bastante menos cómoda a quince.

**Hay roles que son genuinamente multi-cloud.** Existen y pagan bien. Y también, casi sin excepción, piden profundidad en una y conocimiento funcional de la otra — que es un argumento sobre el orden, no sobre la amplitud. Primero profundo, después la segunda. El orden inverso no produce el mismo ingeniero.

## Qué recomendaría de verdad

No "AWS". La regla es: elegí la nube que puedas tocar más seguido, y preferí la que usa tu trabajo actual aunque no sea la de mejores números de mercado, porque mientras construís profundidad la frecuencia le gana al market share. Sesenta horas en la nube que usás a diario valen más que sesenta horas en la que paga mejor en el papel, porque solo una de las dos se está reforzando el lunes a la mañana.

Después, una vez que sabés operar una bajo falla, una segunda nube es cuestión de semanas y no de años — porque a esa altura estás aprendiendo nombres para cosas que ya entendés. Ese es el orden. Profundidad primero no es una posición moral sobre el foco: es que la profundidad abarata lo segundo, y la amplitud nunca vuelve profundo lo primero.
