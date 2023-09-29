pipeline{
    options{
	buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
	}

    agent any

    //stages
    stages{
        // Creating AWS ECR repository using terraform 
        stage('terraform provisioning'){
            steps{
                echo "[+] Creating AWS ECR repository using terraform"
                echo "[+] Done"
            }
        }

        // docker push to AWS ECR
        stage('DockerImage Push to AWS ECR'){
            steps{
                script{
                    withDockerRegistry([credentialsId:'ecr:ap-south-1:ecr-credential', url:'https://150387322390.dkr.ecr.ap-south-1.amazonaws.com/employee-performance-prod']){
                        //Docker Build
                        sh 'docker build -t employee-performance-prod:prod-img-v1.${BUILD_NUMBER} .'
                        
                        // Docker Tag
                        sh 'docker tag employee-performance-prod:prod-img-v1.${BUILD_NUMBER} 150387322390.dkr.ecr.ap-south-1.amazonaws.com/employee-performance-prod:prod-img-v1.${BUILD_NUMBER}'
                        
                        // Docker Push
                        sh 'docker push 150387322390.dkr.ecr.ap-south-1.amazonaws.com/employee-performance-prod:prod-img-v1.${BUILD_NUMBER}'       
                    }
                }
            }
        }

        // Delete Docker image from Jenkins Server
        stage('Delete Docker image from Jenkins'){
            steps{
                echo "[+] Deleting Docker image from Jenkins to freeup spaces"
                //sh 'docker stop $(docker ps -q)'    // this will stop all running container
                //sh 'docker rm $(docker ps -a -q)'   // this will remove all the containers
                //sh 'docker image prune -a'          // this will remove all unused images that are not associated to any container (dangling images)
                sh 'docker rmi $(docker images -q)' // this will remove all docker images.
            }
        }
    }
}
