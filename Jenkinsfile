#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "aws eks update-kubeconfig --name mongoapp-eks-cluster"
                        sh "kubectl apply -f mongo-secret.yml"
                        sh "kubectl apply -f mongo.yml"
                        sh "kubectl apply -f mongo-configmap.yml"
                        sh "kubectl apply -f mongo-express.yml"
                        sh "kubectl apply -f complete-demo.yml"
                        sh "kubectl apply -f manifests-monitoring"
                    }
                }
            }
        }
    }
}
