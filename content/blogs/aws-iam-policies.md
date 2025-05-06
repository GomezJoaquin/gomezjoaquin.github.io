---
title: "IAM Policies"
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

Policies are used to **define permissions** for users.  
Users can be assigned policies through JSON documents.

It is a best practice to apply the **_principle of least privilege_**: Do not grant more permissions than the user needs.

---

## Inheritance of IAM Policies

There are **group policies** and **direct policies**.

- **Direct policies** are applied directly to the user.
- **Group policies** are applied to all users belonging to that group.

---

## Structure of IAM Policies

IAM policies have the following structure:

- **Version**: The version of the policy language, always includes `"2012-10-17"`.
- **Id**: A unique identifier for the policy (optional).
- **Statement**: One or more individual statements (Required).
- **Sid**: Identifier for the statement (optional).
- **Principal**: The account/user/role to which this policy applies.
- **Action**: A list of actions that can be performed on the resources.
- **Resource**: A list of resources on which the actions can be performed.
- **Condition**: Conditions for when this policy is in effect (optional).
---