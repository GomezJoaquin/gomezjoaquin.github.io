---
title: "Kubernetes the Hard Way: What It's For, and When to Stop"
date: 2026-07-26T10:00:00-03:00
draft: false
author: "Joaquín Gómez"
tags:
  - Kubernetes
  - Learning
description: "It teaches one thing extremely well and is silent about everything else. Knowing which is which tells you when you're done."
toc: true
---

I worked through Kubernetes the Hard Way, it did its job, and then I stopped and moved to `kind`. Both halves of that matter. The exercise is widely recommended and rarely bounded, so people either skip it and stay superstitious about the control plane, or repeat it and mistake the repetition for progress.

## What it's actually for

The point is not learning to install Kubernetes. Nobody installs Kubernetes that way, including the people who recommend the exercise. The point is that it removes the abstraction that lets you treat the control plane as one opaque thing called "the cluster."

You generate the certificates yourself. You start etcd yourself. You configure the API server, the scheduler and the controller manager as separate processes with explicit flags, and you wire each kubelet to the API server by hand. Nothing is bundled, so nothing can hide.

The result is a specific and durable change: you stop thinking of Kubernetes as a system and start thinking of it as a handful of programs talking to each other over an API, all of it stored in one key-value store. That's not trivia. It's the model that makes diagnosis possible later, because when something breaks you can ask *which component* is unhappy instead of concluding "the cluster is broken."

The certificate work is the part that pays the most and gets complained about the most. Wiring mutual TLS between every component by hand is tedious, and it is also the reason that six months later, an expired certificate on a kubelet is an annoyance for you instead of a mystery. Almost everyone who finds cluster auth failures inscrutable has never once issued those certificates themselves.

## What it does not teach

This is the part that's usually left out, and it's most of the surface area of the job.

It teaches you nothing about **operating** a cluster. Nothing about upgrades, draining nodes, backing up and restoring etcd, or capacity. You build the cluster once, in a clean state, with no traffic and no users, and then the tutorial ends — which is precisely where operational work begins.

It teaches you nothing about **workloads**. Deployments, Services, ConfigMaps, probes, resource requests, ingress, RBAC for actual humans — none of it. You'll finish with a running control plane and no idea how to run an application well on it.

It teaches you nothing about **debugging**. Every step is a known-good instruction. You never diagnose anything; you follow along and it works, or you have a typo. Real cluster work is almost entirely the other thing.

So: it builds a mental model and it builds nothing else. That's a fair trade for the time, as long as you know that's the trade.

## When to stop

The signal I used: **when you can explain what each component does and why it needs to talk to the others, without looking, you're done.**

Concretely — if you can answer these from memory, stop:

- What does the scheduler actually write when it schedules a pod, and who acts on it?
- What is in etcd, and what happens to a running cluster if etcd is unavailable?
- Why does the kubelet need a certificate, and what breaks when it expires?
- What is the difference between the controller manager and the scheduler?

If you can, doing the exercise a second time teaches you nothing new. It's ritual. There's a real temptation here, because the tutorial has an unusually satisfying property: it's long, it's difficult, and it's guaranteed to succeed if you follow it. That combination feels exactly like progress while producing none, and it's a much more comfortable way to spend a Saturday than debugging your own broken cluster with no instructions.

## What to do next

Move to the layer above it, and switch to a tool that makes clusters cheap so your time goes into workloads instead of into bootstrap. For me that's `kind` — three nodes in under a minute, destroyed and recreated several times a day.

The order matters and it's the opposite of the usual advice. Most paths start with `kubectl apply` on a managed cluster and work down toward the control plane, if they ever get there. Starting from the bottom means that when you meet Deployments and Services you already know what's underneath them, so they're mechanisms rather than magic words. That's worth the detour once.

Once. The value of Kubernetes the Hard Way is entirely front-loaded, and the failure mode isn't skipping it — it's staying there, because the ground floor is the most comfortable place in the building and it's the one part of Kubernetes that comes with instructions.
