pipeline{
    options{
	buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
	}

    agent any

    tools{python 'python_3.7'}

    environment{
        AWS_ACCESS_KEY_ID = credentials()
        AWS_SCERET_ACCESS_KEY_ID = credentials()
    }

    //stages
    satges{
        // terraform plan
        stage('Terraform plan'){
            steps{
                echo "[+] GET TERRAFORM PLAN"
                sh "terraform --version"
                sh "/usr/bin/terraform plan -out=tfplan.txt -input=false -var-file='terraform.tfvars' "
            }
        }

        // Admin Aproval
        stage('Approval'){
            when{
                not{
                    equals expected: true, actual: params.autoApprove
                } // not ends
            } // when ends
            steps{
                script{
                    def plan=readFile 'tfplanl.txt'
                    input message: "Do you wanna apply the plan..?"
                    parameters: [text(name: 'Plan', description:'please review the plan', defaultValue:plan)]
                }
            }
        }

        // Terraform apply
        stage('Terraform Apply'){
            steps{
                sh 'terraform apply tfplan.txt'
            }
        }

        // build docker image
        stage('building docker image'){

        }

        // docker push to AWS ECR
        stage('DockerImage Push to AWS ECR'){
            
        }
    }
}
