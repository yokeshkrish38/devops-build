🚀 Project 3 – Reactjs E-commerce Application
🔹 Project Overview

This project demonstrates a complete DevOps CI/CD pipeline for a ReactJS application using Jenkins, Docker, Docker Hub, and AWS EC2, along with monitoring using Prometheus and Grafana.

🔹 Tech Stack

AWS EC2 (Amazon Linux)

GitHub

Jenkins (Multibranch Pipeline + Webhook)

Docker & Docker Hub

Docker Compose

Prometheus

Grafana

Nginx (for React app)

🔹 Architecture Flow

Developer pushes code to GitHub

GitHub Webhook triggers Jenkins

Jenkins builds Docker image

Image pushed to Docker Hub

App deployed on EC2 using Docker

Monitoring via Prometheus & Grafana

🔹 Application URL
http://<YOUR_EC2_PUBLIC_IP>

🔹 Monitoring URLs

Prometheus: http://<EC2_IP>:9090

Grafana: http://<EC2_IP>:3000

🔹 CI/CD Features

Multibranch pipeline (dev & main)

Auto-triggered build using GitHub webhook

Docker image tagging per branch

Automated deployment

🔹 Monitoring Features

CPU, Memory, Disk, Network monitoring

Node Exporter integration

Grafana dashboards



