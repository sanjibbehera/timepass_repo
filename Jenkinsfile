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

		/*stage('Publish to Artifact') {
			steps {
				echo 'Upload starts'
				bat "mvn --settings ${WORKSPACE}/settings.xml clean deploy"
				echo 'Upload finished'
			}
		}*/
		
		stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: "artifactory",
                    url: 'http://localhost:8081/artifactory',
                    credentialsId: 'artifactory'
                )

                rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "artifactory",
                    releaseRepo: "libs-release-local",
                    snapshotRepo: "libs-snapshot-local"
                )

                rtMavenResolver (
                    id: "MAVEN_RESOLVER",
                    serverId: "artifactory",
                    releaseRepo: "libs-release",
                    snapshotRepo: "libs-snapshot"
                )
            }
        }

        stage ('Exec Maven') {
            steps {
                rtMavenRun (
                    tool: maven, // Tool name from Jenkins configuration
                    pom: 'pom.xml',
                    goals: 'clean deploy',
                    deployerId: "MAVEN_DEPLOYER",
                    resolverId: "MAVEN_RESOLVER"
                )
            }
        }

        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: "artifactory"
                )
            }
        }    
	}
}