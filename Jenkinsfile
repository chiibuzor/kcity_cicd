pipeline {
    agent any

    environment {
        PRIMARY_REGION = 'me-central-1'
        SECONDARY_REGION = 'me-south-1'
        S3_BUCKET_REACT = 'frontend-app-react'
        S3_BUCKET_SVELTE = 'frontend-app-svelte'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo/knowledgecity.git'
            }
        }

        stage('Build and Test Frontends') {
            parallel {
                stage('React Frontend') {
                    steps {
                        sh '''
                        cd react-app
                        npm install
                        npm run build
                        npm test
                        '''
                    }
                }
                stage('Svelte Frontend') {
                    steps {
                        sh '''
                        cd svelte-app
                        npm install
                        npm run build
                        npm test
                        '''
                    }
                }
            }
        }

        stage('Build and Test Backend Services') {
            steps {
                sh '''
                cd backend
                composer install
                ./vendor/bin/phpunit
                '''
            }
        }

        stage('Deploy Frontends') {
            parallel {
                stage('React Frontend Deployment') {
                    steps {
                        sh './scripts/deploy-frontend.sh react ${S3_BUCKET_REACT} ${PRIMARY_REGION}'
                    }
                }
                stage('Svelte Frontend Deployment') {
                    steps {
                        sh './scripts/deploy-frontend.sh svelte ${S3_BUCKET_SVELTE} ${PRIMARY_REGION}'
                    }
                }
            }
        }

        stage('Deploy Backend Services') {
            steps {
                sh './scripts/deploy-backend.sh'
            }
        }

        stage('Database Migration') {
            steps {
                sh './scripts/database-migration.sh'
            }
        }

        stage('Deploy to Secondary Region') {
            parallel {
                stage('Sync Frontends') {
                    steps {
                        sh '''
                        aws s3 sync s3://${S3_BUCKET_REACT} s3://${S3_BUCKET_REACT} --source-region ${PRIMARY_REGION} --region ${SECONDARY_REGION}
                        aws s3 sync s3://${S3_BUCKET_SVELTE} s3://${S3_BUCKET_SVELTE} --source-region ${PRIMARY_REGION} --region ${SECONDARY_REGION}
                        '''
                    }
                }
                stage('Sync Backend Services') {
                    steps {
                        sh './scripts/deploy-backend.sh ${SECONDARY_REGION}'
                    }
                }
            }
        }
    }

    post {
        failure {
            echo 'Deployment failed. Triggering rollback...'
            sh './scripts/rollback.sh'
        }
    }
}
