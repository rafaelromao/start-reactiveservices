# This script shall be used to start the Reactive Services application over Mono on a Docker container

# http://boot2docker.io/ must be installed
# https://github.com/rafaelromao/start-docker must be installed
# RabbitMQ must be running at the address informed in the dockerfile

function Start-ReactiveServices($appname, $runparams) {
	if ($appname -eq $null) {
		Write-Host "App name must be informed!"
	} else {
		# Start Docker and Prepare Shell
		start-docker 
		# Check if the image exists
		$imageExists = docker images | grep $appname
		if ($imageExists -eq $null) {
			Write-Host "Creating $appname image..."
			docker build --rm=true -t $appname . 2> $null | Out-Null
		} 
		# Check if container exists
		$existingContainerId = docker ps -a -q --filter="name=$appname"
		if ($existingContainerId -ne $null) {
			$runningContainerId = docker ps -q --filter="name=$appname"
			if ($runningContainerId -ne $null) {
				Write-Host "Stopping previous $appname container..."
				docker stop $runningContainerId
			}
			Write-Host "Removing previous $appname container..."
			docker rm $existingContainerId
		}
		# Creates and starts the container
		Write-Host "Creating and running $appname container..."
		docker run --name=$appname $runparams $appname
	}
}