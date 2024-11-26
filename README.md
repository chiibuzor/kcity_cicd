# KnowledgeCity CI/CD Pipeline

This repository contains the CI/CD pipeline configuration and scripts for automating the deployment of KnowledgeCity's infrastructure.

---

## Features

1. **Automated Builds**: Builds React and Svelte frontends.
2. **Testing**: Runs unit tests for all components.
3. **Multi-Region Deployment**: Deploys services to primary and failover regions.
4. **Rollback Mechanism**: Safely reverts deployments in case of failure.
5. **Database Schema Management**: Handles Aurora Global Database migrations.

---

## Setup Instructions

### Prerequisites

1. Jenkins installed and configured. [Install Jenkins](https://www.jenkins.io/download/)
2. AWS CLI installed and configured. [Install AWS CLI](https://aws.amazon.com/cli/)
3. Ensure permissions to deploy resources in AWS.

---

