# Set the execution policy for the current session
Set-ExecutionPolicy Bypass -Scope Process -Force

# Retrieve the username and password from environment variables
$username = $env:NAS2_USER
$password = $env:NAS2_PASSWORD

# Check if the environment variables are set
if (-not $username -or -not $password) {
    Write-Host "Error: Please set the NAS2_USER and NAS2_PASSWORD environment variables."
    exit
}

# Map the network drive
net use "\\192.168.1.97\nas2" /user:$username $password

# Change directory to the desired path
cd "\\192.168.1.97\nas2\Server\Dokumentai\Aplankas\Repos"
