# NAS Repository Navigation Script



This project provides a PowerShell script (`repos.ps1`) and a batch file (`repos.bat`) to simplify navigation to a specific folder on a NAS (Network Attached Storage) device containing GitHub repository backups. The script uses environment variables for secure credential management.



## Table of Contents

- [Features](#features)

- [Requirements](#requirements)

- [Setup Instructions](#setup-instructions)

- [Customizing the Script](#customizing-the-script)

- [Setting Up Environment Variables](#setting-up-environment-variables)

- [Usage](#usage)

- [License](#license)



## Features

- Securely connects to a NAS using user credentials stored in environment variables.

- Changes the current directory to a specified folder for easier navigation.

- Customizable prompt for a cleaner command line experience.



## Requirements

- Windows operating system

- PowerShell

- Access to a NAS device



## Setup Instructions



1. **Clone the Repository**:

Clone this repository to your local machine using:

```powershell
git clone https://github.com/yourusername/nas-repo-navigation.git
```



2. **Navigate to the Directory**:

Change to the directory where the scripts are located:

```powershell
cd nas-repo-navigation
```



3. **Edit the PowerShell Script**:

Open `repos.ps1` in a text editor and replace the following parts with your specific information:

- **Network Path**: Update the path in the `net use` and `cd` commands to point to your NAS location.

```powershell

net use "\\192.168.1.97\nas2" /user:$username $password

cd "\\192.168.1.97\nas2\Server\Dokumentai\Aplankas\Repos"

```



4. **Edit the Batch File**:

Open `repos.bat` in a text editor and ensure the path to `repos.ps1` is correct:

```powershell
powershell -ExecutionPolicy Bypass -File "C:\sukurtas\scripts\repos\repos.ps1" %\*
```



## Customizing the Script

- **Change the NAS Path**: Modify the paths in both `repos.ps1` and `repos.bat` to match your NAS configuration.

- **Prompt Customization**: If you want to change the prompt displayed after running the script, you can modify the `prompt` function in `repos.ps1`.



## Setting Up Environment Variables

To securely store your NAS username and password, set up environment variables:



1. **Open Environment Variables**:

- Right-click on "This PC" or "Computer" and select "Properties."

- Click on "Advanced system settings."

- Click on "Environment Variables."



2. **Add New Variables**:

- Click "New" under "User variables" or "System variables."

- For **Variable name**, enter `NAS2\_USER` and for **Variable value**, enter your NAS username.

- Click "OK" and repeat for `NAS2\_PASSWORD` with your NAS password.



## Usage

1. Open a Command Prompt window.

2. Navigate to the directory where `repos.bat` is located.

3. Run the command:

```bash
repos
```

4. The script will map the NAS drive and change the directory to the specified path. The prompt will display as `Repos>` for easier navigation.
