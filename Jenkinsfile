pipeline {
	agent any
	tools {
        maven 'maven3.6' 
    }
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
				bat "mvn clean package"
			}
		}

		stage('Publish to Artifact') {
			steps {
				echo 'Upload starts'
				bat "mvn build-info"
				echo 'Upload finished'
			}
		}
	}
}