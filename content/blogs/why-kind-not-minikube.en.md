---
title: "Why I Run Kubernetes on kind, Not minikube or a Hosted Lab"
date: 2026-07-30T10:00:00-03:00
draft: false
author: "Joaquín Gómez"
tags:
  - Kubernetes
  - kind
  - Local Development
description: "A local cluster decision made under a real constraint: 24 GB of RAM, multi-node required, and destroyed several times a day."
toc: true
---

Every guide that tells you to "spin up a local cluster" skips the part where you choose which one, as if the choice were cosmetic. It isn't. The tool you pick determines which skill you end up practising, and most people pick the one that quietly removes the skill they were trying to learn.

Here is my decision, the constraints behind it, and where it's wrong.

## The constraints

**24 GB of RAM on a laptop that is also running my actual job.** This is the binding constraint and it eliminates more options than anything else. The cluster is not the only thing on the machine.

**Multi-node is not optional.** A single-node cluster hides an entire category of behaviour. Scheduling is trivial when there's one place to schedule to. You cannot see a `nodeSelector` do anything, you cannot drain a node, you cannot watch a pod get evicted and land somewhere else, and pod anti-affinity is a no-op. Those are exactly the things that separate "I can deploy" from "I can operate," and they need at least a control plane plus two workers.

**I destroy the cluster several times a day.** This is deliberate. If recreating the cluster is expensive, I start protecting it, and a cluster I'm afraid to break is useless for learning. Cheap teardown is what buys permission to experiment.

## The options

**Hosted labs** (browser-based, ready-made clusters). Zero setup, nothing to install, no RAM cost at all. And they solve the wrong problem for me: they hand you a running cluster. If the skill I'm buying is operating a cluster, a service that pre-operates it removes the exact thing I came for. I never write the node topology, never see bootstrap fail, never learn what a broken cluster looks like on the way up. They're excellent for exam drilling under time pressure and I'd use one for that. Not for this.

**minikube.** Mature, huge addon ecosystem, a real `LoadBalancer` story via `minikube tunnel`, ingress as a one-line addon. It is the friendliest option and for a single-node workflow I'd probably recommend it over kind. But its multi-node support is heavier and slower than kind's, and its centre of gravity is a VM per cluster. With 24 GB shared with everything else, multi-node minikube is where my constraint bites.

**kind.** Nodes are Docker containers, not VMs. A three-node cluster comes up in well under a minute and costs a fraction of the equivalent in VMs. Topology is a YAML file I own and commit. That last point is the one that decided it.

## What actually decided it

The cluster definition is a file in the repository:

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
```

and creation and teardown are scripts, not instructions:

```bash
make cluster-up     # bootstrap/up.sh
make cluster-down   # bootstrap/down.sh
```

This is the difference between a cluster another person can reproduce and a cluster only I can reproduce. It's also the difference between "here are eleven commands you should run" in a README and one command that either works or fails loudly. Scripting the lifecycle is worth more than any feature comparison between the tools, and it's the part people skip.

## What kind costs me

Being honest about the trade-off, because a decision article that only lists upsides is an advertisement:

**No `LoadBalancer`.** Services of type `LoadBalancer` stay `Pending` forever. You work around it with `extraPortMappings` in the kind config, with NodePort, or by installing MetalLB. On a managed cluster this is free, so I'm practising a workaround that doesn't transfer.

**Images need loading.** A locally built image isn't visible to the nodes until `kind load docker-image`. Forgetting this and staring at `ErrImagePull` is a rite of passage. Real clusters pull from a registry, so again, my daily loop is slightly unlike the real one.

**Storage is local-path only.** Fine for learning PVC mechanics, useless for learning how a real `StorageClass` behaves, and it teaches you nothing about what happens when a volume can't detach.

**Nodes are containers.** Anything that cares about the kernel or the boundary between node and host behaves differently. Some `NetworkPolicy` and CNI experiments do not reproduce faithfully.

The pattern in that list is worth naming: kind is excellent at the control plane and the workload layer, and weak everywhere the cluster touches real infrastructure. Which is a reasonable place to be weak while you're learning workloads, and a bad place to be weak later. When I get to the infrastructure-facing layers, this tool stops being the right one, and I'd rather write that down now than discover it as a surprise.

## Where I'd choose differently

- **If I only needed one node:** minikube. The addon ecosystem is worth more than kind's speed advantage when speed isn't the constraint.
- **If I were preparing for a timed exam:** a hosted lab, because the skill being tested is speed inside someone else's cluster, which is precisely what those environments train.
- **If I had 64 GB:** the constraint disappears and I'd probably run k3s on real VMs, which is closer to a real cluster in the ways kind is furthest from it.

The general rule I'd extract: pick the local cluster that makes the thing you're currently trying to learn *cheap*, and be explicit about what it makes invisible. Every one of these tools is a simplification, and the simplification is only safe while you can name it.
