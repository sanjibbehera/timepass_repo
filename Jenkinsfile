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
			//def server = Artifactory.server "artifactory@ibsrv02"
			def server = Artifactory.server 'Artifactory' url: 'http://localhost:8082/artifactory', credentialsId: 'jfrog_creds'
			def buildInfo = Artifactory.newBuildInfo()
			buildInfo.env.capture = true
			def rtMaven = Artifactory.newMavenBuild()
			rtMaven.tool = MAVEN_TOOL // Tool name from Jenkins configuration
			//rtMaven.opts = "-Denv=dev"
			rtMaven.deployer releaseRepo:'libs-release-local', snapshotRepo:'libs-snapshot-local', server: server
			//rtMaven.resolver releaseRepo:'libs-release', snapshotRepo:'libs-snapshot', server: server

			rtMaven.run pom: 'pom.xml', goals: 'publish', buildInfo: buildInfo
			server.bypassProxy = true
			server.connection.timeout = 300
			server.publishBuildInfo buildInfo
			//def server = Artifactory.server 'Artifactory' url: 'http://localhost:8082/example-repo-local', credentialsId: 'jfrog_creds'
			/*steps {
				script {
					echo 'Stage 3'
				}
			}*/
		}
	}
}