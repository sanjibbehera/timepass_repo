pipeline {
	agent any
	stages {

		stage('Cleanup') {
			steps {
				cleanWs()
			}
		}

		stage('SCM Checkout') {
			steps {
				script {
					echo 'Stage 1'
					git branch: 'main',
					credentialsId: 'git_secrets',
					url: 'https://github.com/sanjibbehera/timepass_repo.git'
				}
			}
		}

		stage('Zip Repo') {
			environment {
				mvnHome = tool name: 'maven3.6', type: 'maven'
			}
			steps {
				withMaven(maven: 'maven3.6'){
				  sh "${mvnHome}/bin/mvn package"
				}
			}
		}

		stage('Publish to Artifact') {
			steps {
				script {
					echo 'Stage 3'
				}
			}
		}
	}
}