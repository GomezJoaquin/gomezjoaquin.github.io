---
title: "Postmortem: The README Was the Incident"
date: 2026-08-01T10:00:00-03:00
draft: false
author: "Joaquín Gómez"
tags:
  - Postmortem
  - Kubernetes
  - CI/CD
description: "I audited my own portfolio repository and found that half of what its README promised did not exist. This is the postmortem for that."
images:
  - "/images/og/postmortem-readme-was-the-incident.en.png"
toc: true
---

## Summary

`pipeforge` is my Kubernetes delivery project. Its README opens with a four-word pitch:

> **Scaffold, ship, observe, auto-rollback.**

Two of those four verbs describe software that is not in the repository. There is no metrics collection. There is no automated rollback. There never was.

Nothing failed in production, because I don't have a production. What failed is the only job a portfolio has: letting a stranger predict what I can do from what I wrote. This is the postmortem.

## Impact

A recruiter or engineer who reads that headline forms an expectation: this person has wired a progressive delivery pipeline that watches a signal and reverts a bad deploy without a human. Someone who then opens the repo finds a well-organized scaffold and no such thing.

The damage is not "the project is incomplete." Incomplete is normal and forgivable. The damage is that the gap between the claim and the artifact is itself a data point, and it's the worst kind: it says I can't calibrate my own claims.

Calibration is most of the job. An on-call engineer who reports "the database is down" when one replica is degraded costs the team an hour. Someone who says "I have auto-rollback" when they have a `Makefile` costs a hiring manager an interview loop. The technical gap is recoverable in a weekend. The credibility gap is not.

## What actually exists

To be precise about the delta, here is what the repository really contains, all of it verifiable by cloning it:

- A `kind` cluster definition: one control plane, two workers, created by `bootstrap/up.sh` and torn down by `bootstrap/down.sh`.
- Three service stubs: `catalog-api` (Python/FastAPI), `orders-api` (Go), `notifications-worker` (Node.js). Each has tests that pass.
- A `Makefile` with `cluster-up`, `test-all`, `build-all`, `cluster-down`.
- A GitHub Actions workflow that, per service, installs the toolchain, runs the test suite, and builds a Docker image.

That is a competent scaffold. `make cluster-up && make test-all` works on a clean machine, which is more than a lot of tutorial repos can say.

And here is what does not exist:

- No Prometheus, no metrics endpoint, no scraping. Nothing "observes" anything.
- No Argo Rollouts, no canary, no analysis template, no rollback of any kind — automated or manual.
- `platform/` and `infra/` are empty directories labelled `(coming)`.

## Timeline

| When | What |
|---|---|
| April 2026 | Repo scaffolded over roughly two weeks. README written at this point, describing the intended system. |
| 19 April 2026 | Last push. The scaffold is done; the interesting half is not started. |
| June 2026 | I audit my own public repositories. The gap becomes explicit. |
| Week of 19 June 2026 | I commit to building the auto-rollback for real. |
| 1 August 2026 | README unchanged. Still promises observe and auto-rollback. |

Six weeks between "I will fix this" and "I have not fixed this" is the part of the timeline that matters. It rules out the comfortable explanation — that I hadn't noticed.

## Root cause

The proximate cause is trivial: I wrote the README before the software, and never corrected it.

The interesting question is why the correction never happened, given that I knew. Working backwards:

**Why is the rollback not built?** Because it is the hard part. Scaffolding has fast feedback and no real failure mode — a directory tree is done when it looks right. Making a rollback fire correctly on a real signal has slow feedback and can visibly fail: the metric can be wrong, the threshold can be wrong, the analysis can pass while the service is broken. Those are the failures that teach you something, which is exactly why they're the ones I deferred.

**Why did the README not get corrected in the meantime?** Because a README is the only artifact in a repository with no test. The Go code has `go test`. The Python code has `pytest`. CI runs all of it on every push. The README is the single file where I can assert anything and no part of the system disagrees. Documentation drift is normally discussed as a maintenance problem — docs falling behind code. This is the reverse and it's worse: docs running *ahead* of code, which is not drift, it's a forecast published as a fact.

**Why did `(coming)` survive four months?** Because `(coming)` is a promise with no due date and no owner. In a real postmortem an action item without an assignee and a date doesn't get done, and everyone knows it. I wrote three of them into my own repo layout and treated them as progress.

So the root cause is not laziness or time. It's that I had a workflow where writing the claim was a substitute for the satisfaction of building the thing, and no mechanism anywhere that made the claim answer for itself.

## What went well

- The scaffold is genuinely reproducible. Cluster lifecycle is scripted rather than documented as a list of manual steps, which is the difference between something another person can run and something only I can run.
- CI exists and does real work on every push across three languages.
- The audit happened, and it happened because I went looking, not because someone else pointed at it.

## What went badly

- The README described intent in the present tense.
- I used `(coming)` as a decoration to make an empty directory look like a plan.
- I confused "I know what should be built here" with "I have built it." The first is worth very little; every engineer knows what a progressive delivery pipeline should contain, and an LLM will write you the directory tree in ten seconds.

## Action items

| Action | Owner | Status |
|---|---|---|
| Rewrite the README to describe only what runs today | me | done — this post is the public version of it |
| Delete every `(coming)` marker rather than restyling it | me | done |
| Every claim in the headline must map to a command a reader can run | me | ongoing rule |
| Build the rollback, then write about the rollback — in that order | me | open |

The last one is the actual work and I'm not going to predict a date for it here, because predicting dates in public is the failure mode this entire document is about.

## What I'd tell someone else

If you have a portfolio repository, open the README and mark every sentence as one of three things: something a reader can verify by running a command, something they can verify by reading the code, or something they'd have to take on faith. Delete the third category. All of it.

Then check the direction of your errors. Everyone's documentation is imperfect, but the *sign* matters. Docs that undersell what's there cost you credit you'd have earned. Docs that oversell cost you the credit you actually earned, because once a reader catches one inflated claim they discount everything else on the page — including the parts that were true.

I had a working multi-node cluster bootstrap and honest CI across three languages, and I buried both under a headline that made a reader distrust the whole repository. That's a bad trade, and I made it for free.
