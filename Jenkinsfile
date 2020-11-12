pipeline {
	agent any
	stages {

		stage('SCM Checkout') {
			steps {
				script {
					echo 'Stage 1'
					git branch: 'master',
					credentialsId: 'git_secrets',
					url: 'https://github.com/sanjibbehera/timepass_repo.git'
				}
			}
		}

		stage('Stage 2') {
			steps {
				script {
					echo 'Stage 2'
				}
			}
		}
	}
}