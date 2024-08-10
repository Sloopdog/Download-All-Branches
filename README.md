# GitHub Branch Downloader Script

## Overview

This PowerShell script allows you to download all branches from a GitHub repository into separate directories. Each branch will be saved in its own folder, making it easier to access and work with multiple branches independently.

## How It Works

1. The script clones the specified GitHub repository without checking out any branches.
2. It then iterates through each branch, checks it out, and copies the branch's contents to a corresponding directory.
3. After processing all branches, the temporary repository is deleted, leaving behind only the folders containing the branches.

## Prerequisites

- **Git**: Ensure Git is installed and added to your system's PATH.
- **PowerShell**: The script is written for PowerShell, which is available by default on Windows.

## Usage

### Step 1: Download the Script

Download the script file (`DownloadGitBranches.ps1`) and save it to a location on your computer.

### Step 2: Modify the Script

Open the script in a text editor and update the following variables:

- `$repoUrl`: Replace this with the URL of the GitHub repository you want to clone.
- `$cloneDir`: Replace this with the directory where you want to save the branches.

### Step 3: Run the Script

1. **Run PowerShell as Administrator**:
    - Open PowerShell as an Administrator by right-clicking on the PowerShell icon and selecting "Run as administrator".

2. **Set Execution Policy (if needed)**:
    - Temporarily allow running the script by entering:
    ```powershell
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    ```

3. **Navigate to the Script Directory**:
    - Use `cd` to navigate to the directory where the script is saved.

4. **Run the Script**:
    - Execute the script with the following command:
    ```powershell
    .\DownloadGitBranches.ps1
    ```

### Step 4: Review the Downloaded Branches

After the script completes, you will find a folder for each branch in the directory specified by `$cloneDir`. Each folder contains the files for that particular branch.

### Step 5: Reset Execution Policy (Optional)

If you changed the execution policy, you can reset it by closing PowerShell or by running:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Restricted
