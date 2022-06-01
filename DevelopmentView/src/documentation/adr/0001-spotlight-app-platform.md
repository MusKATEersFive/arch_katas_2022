# 1. Platform

Date: 2022-06-01

## Status
proposed

## Context
Platform that will host Spotlight application is one of key factors for price, security, scalability (feature/performance) and so on.

There are two main options:
- Self hosting system
- Cloud provider

In cloud computing, there are several providers.

## Decision
SpotlightApp will be hosted in cloud by AWS.
Reasons:
- It's more price efficient - no initial investment in hardware, could scale up/down based on usage/traffic.
- There are a lots of security features for free in shared responsibility model on managed services.
- Reducing Time-To-Market

## Consequences
All the data will be inside cloud.
