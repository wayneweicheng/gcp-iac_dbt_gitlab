pipeline {
    agent any
    environment {
        // Define your environment variables and secrets here
        SERVICE_ACCOUNT = credentials('gcp_ab_sa_json')
        GCP_PROJECT_ID = 'animated-bay-224723'
        TF_VAR_branch = 'dev'
        TF_VAR_suffix = 'wayne'
    }
    stages {
        stage('Terraform Validate') {
            agent {
                docker { 
                    image 'hashicorp/terraform:light' 
                    args '--entrypoint /usr/bin/env'
                }
            }
            steps {
                script {
                    sh '''
                        rm -rf .terraform
                        terraform --version
                        mkdir -p ./creds
                        echo $SERVICE_ACCOUNT | base64 -d > ./creds/serviceaccount.json
                        terraform -chdir=terraform init
                    '''
                }
            }
        }
        stage('Terraform Plan') {
            agent {
                docker { 
                    image 'hashicorp/terraform:light' 
                    args '--entrypoint /usr/bin/env'
                }
            }
            steps {
                script {
                    sh '''
                        rm -rf .terraform
                        terraform --version
                        mkdir -p ./creds
                        echo $SERVICE_ACCOUNT | base64 -d > ./creds/serviceaccount.json
                        terraform -chdir=terraform init
                        terraform -chdir=terraform plan -out planfile
                    '''
                    // Save planfile as artifact if needed
                    archiveArtifacts artifacts: 'terraform/planfile', onlyIfSuccessful: true
                }
            }
        }
        stage('Terraform Apply') {
            agent {
                docker { 
                    image 'hashicorp/terraform:light' 
                    args '--entrypoint /usr/bin/env'
                }
            }
            steps {
                script {
                    sh '''
                        rm -rf .terraform
                        terraform --version
                        mkdir -p ./creds
                        echo $SERVICE_ACCOUNT | base64 -d > ./creds/serviceaccount.json
                        terraform -chdir=terraform init
                        terraform -chdir=terraform apply -input=false planfile
                    '''
                }
            }
        }
        stage('Run DBT Scripts') {
            agent {
                docker {
                    image 'python:3.10-slim-buster'
                    args '--entrypoint /usr/bin/env'
                }
            }
            steps {
                script {
                    sh '''
                        mkdir -p ./creds
                        echo $SERVICE_ACCOUNT | base64 -d > ./creds/serviceaccount.json
                        echo "---"
                        echo $GCP_PROJECT_ID
                        echo "---"
                        export DBT_PROFILES_DIR="./dbt_profiles"
                        export DBT_ENVIRONMENT=dev
                        cd dbt
                        pip install -r requirements.txt --user
                        cd dbt_sample_bigquery
                        dbt run
                    '''
                }   
            }
        }
    }
}
