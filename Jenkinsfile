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
			steps {
				script {
					echo 'Stage 2'
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