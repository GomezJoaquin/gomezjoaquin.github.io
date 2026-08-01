---
title: "One Cloud, Not Two: Why I Killed My Azure Track"
date: 2026-07-28T10:00:00-03:00
draft: false
author: "Joaquín Gómez"
tags:
  - AWS
  - Azure
  - Cloud
  - Career
description: "I hold an Azure fundamentals certification and I stopped going deeper on Azure on purpose. The reasoning, and the case against it."
toc: true
---

I hold AZ-900 alongside my AWS certifications, and my portfolio project originally pushed images to Azure Container Registry. Earlier this year I migrated it to ECR and stopped adding to the Azure track entirely.

This wasn't a judgement about the platforms. It was a judgement about what a second cloud costs, and about what a CV listing two clouds actually communicates.

## What breadth signals

There's a common assumption that listing AWS and Azure doubles your addressable market. In my experience reading job posts and talking to people who hire, it does something closer to the opposite at my level.

A CV with two clouds at intermediate depth reads as *familiarity*. A CV with one cloud at operational depth reads as *competence*. These are different claims and only the second one survives an interview, because interviews don't test coverage — they test the bottom of your knowledge in one place. The question is never "name a service that does X." It's "this is broken, what do you check first," and that question has a bottom.

The person who has run one cloud deeply has a bottom that's far down. The person who has covered two clouds to the same total effort hits it twice as fast, in either direction. And the failure is more visible than the breadth ever was, because a shallow answer to an operational question is memorable in a way that a wide skills list is not.

## What actually transfers, and what doesn't

The argument for multi-cloud learning is that concepts transfer. They do — and the transfer is much thinner than it sounds.

**Transfers well.** The mental models. Identity and policy evaluation, network segmentation, the idea of a managed control plane, blast radius, the shape of a well-architected review. If you understand why least privilege matters in IAM, you understand it in Entra ID.

**Transfers badly.** Everything operational. The specific way IAM policy evaluation resolves an explicit deny across an SCP, a resource policy and a permissions boundary. Which failures are silent. Which service quota you'll hit first and what the error looks like when you do. How long a given operation actually takes when it's degraded, so you know whether five minutes means "wait" or "escalate."

That second category is the entire value of experience, and it's the part that doesn't transfer. Knowing the concept means you can read the docs faster. It does not mean you can diagnose anything, and diagnosis is what's scarce.

## The real cost is maintenance, not learning

The cost I underestimated wasn't the hours to learn Azure. It was that two platforms means maintaining two sets of habits, and habits decay.

Every cloud you claim is a cloud you have to keep current in. Services change, defaults change, the recommended way to do something is replaced. Six months without touching Azure and I'm not a person with Azure skills — I'm a person with an out-of-date Azure model, which is worse than none, because I'll reach for something confidently and be wrong. In an interview I'd rather say "I haven't used Azure" than half-remember it.

And the compounding argument is decisive for me: I touch AWS every day at work. Depth in AWS compounds with my job — the same knowledge is being reinforced twice, and each side makes the other cheaper. Azure was the opposite: effort that neither reinforced my work nor was reinforced by it. It was the only front I had that got no leverage from anything else I was doing.

## The case against my decision

I should be honest that this call is not obviously correct, and the counterarguments are real.

**If you work at a consultancy, breadth is the product.** Agencies get handed whatever the client already runs. There, "we have Azure people" is a sales fact, and a narrow specialist is less useful than someone who can be dropped into either.

**Regional markets differ.** In markets where enterprise and public sector dominate, Azure penetration is high and the AWS-only specialist is fishing in the smaller pond. This is worth checking locally rather than assuming, because the global market share numbers do not describe your city.

**Two clouds is real insurance.** Betting a career on one vendor's continued relevance is a bet. It's one I'm comfortable making over a five-year horizon and less comfortable over fifteen.

**Some roles genuinely are multi-cloud.** They exist and they pay well. They also, almost without exception, want deep in one and working knowledge of the other — which is an argument about sequence, not about breadth. Get deep first, add the second later. The reverse order doesn't produce the same engineer.

## What I'd actually recommend

Not "AWS." The rule is: pick the cloud you can touch most often, and prefer the one your current job uses even if it isn't the one with better market numbers, because frequency beats market share while you're building depth. Sixty hours in the cloud you use daily is worth more than sixty hours in the one that pays better on paper, because only one of those is being reinforced on Monday morning.

Then, once you can operate one under failure, a second cloud is a matter of weeks rather than years — because by then you're learning names for things you already understand. That's the sequence. Depth first is not a moral position about focus. It's that depth makes the second thing cheap, and breadth never makes the first thing deep.
