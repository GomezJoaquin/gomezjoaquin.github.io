---
title: "IAM"
date: 2024-12-28T01:54:00+05:30
draft: false
tags:
  - AWS
  - Cloud
  - IAM
image: /images/iam.png
description: ""
toc: true
mathjax: true
---

## AWS: IAM (Identity and Access Management)

IAM is a **global service**.

It is used to manage access to cloud resources, controlling **who** can perform **what actions** on **which resources** through permission policies.

---

### **Root Account**
The **root account** is the account that is created by default when setting up AWS. It is a best practice to use the root account **only when absolutely necessary** (e.g., for account-level tasks). For all other tasks, use an account with the **principle of least privilege**.

---

### **Users**
**Users** represent individuals within an organization. The general rule is **1 user = 1 person**.

---

### **Groups**
**Groups** are used to organize users. Their sole purpose is to contain users, and it is not possible for one group to contain another group.

- Users do not need to belong to a group.
- Users can belong to multiple groups simultaneously.

For example:
- A user can belong to both the "Developers" group and the "Admins" group, inheriting permissions from both.

For more details on IAM policies, check out this [IAM Policies Guide](https://gomezjoaquin.github.io/blogs/aws-iam-policies/).

---

## **Difference Between Groups and Roles**

### **Groups**
- **Purpose**: Groups are used to manage permissions for multiple users at once.
- **Use Case**: When you have multiple users who need the same set of permissions, you can assign them to a group and attach the necessary policies to the group. This simplifies permission management.
- **Example**: 
  - A "Developers" group might have permissions to access EC2 instances and S3 buckets.
  - An "Admins" group might have full access to all resources.

### **Roles**
- **Purpose**: Roles are used to grant temporary permissions to entities (users, applications, or services) without requiring long-term credentials.
- **Use Case**: When an AWS service or external entity (e.g., an application running on an EC2 instance) needs to access AWS resources, you assign a role to that service or entity. Roles are also used for cross-account access.
- **Example**:
  - An EC2 instance needs to read data from an S3 bucket. You assign a role to the EC2 instance with the necessary permissions.
  - A Lambda function needs to write logs to CloudWatch. You assign a role to the Lambda function with the appropriate permissions.

---

### **When to Use Groups vs. Roles**

| **Feature**       | **Groups**                                   | **Roles**                                   |
|--------------------|----------------------------------------------|--------------------------------------------|
| **Who uses it?**   | Users within your AWS account                | AWS services, applications, or external entities |
| **Purpose**        | Manage permissions for multiple users        | Grant temporary permissions to entities    |
| **Example**        | Assign "Developers" group to all developers  | Assign a role to an EC2 instance to access S3 |

---
