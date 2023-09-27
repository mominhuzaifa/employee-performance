pipeline{
    options{
	buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
	}

    agent any

    tools{python 'python_3.7.16'}
}
