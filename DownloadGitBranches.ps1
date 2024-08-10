# Script to download all branches from a GitHub repository

# Set the repository URL
# Replace with the URL of the GitHub repository you want to clone
$repoUrl = "https://github.com/username/repository.git"

# Set the directory where the branches will be cloned
# Replace with the path where you want to save the cloned branches
$cloneDir = "C:\Path\To\Clone\Directory"

# Step 1: Create the clone directory if it doesn't exist
# This ensures the directory exists before cloning
if (-not (Test-Path $cloneDir)) {
    New-Item -ItemType Directory -Path $cloneDir
}

# Step 2: Navigate to the clone directory
# This is where the temporary repository will be stored
Set-Location $cloneDir

# Step 3: Clone the repository without checking out any branch
# --no-checkout ensures that we don't check out any branch immediately
# The repository is cloned into a temporary directory named 'repo-temp'
git clone --no-checkout $repoUrl repo-temp
Set-Location "repo-temp"

# Step 4: Get a list of all remote branches in the repository
# The 'git branch -r' command lists all remote branches
# We clean up the output by trimming whitespace and removing the 'origin/' prefix
$branches = git branch -r | ForEach-Object { $_.Trim() -replace "^origin/", "" }

# Step 5: Loop through each branch and process it
foreach ($branch in $branches) {
    # Check out the branch from the remote repository
    git checkout -b $branch origin/$branch

    # Create a directory for the branch in the main clone directory
    # This ensures each branch's content is stored separately
    $branchDir = Join-Path $cloneDir $branch
    if (-not (Test-Path $branchDir)) {
        New-Item -ItemType Directory -Path $branchDir
    }

    # Copy all files from the branch to the branch directory
    # This effectively saves the branch's contents
    Get-ChildItem -Recurse -File | Copy-Item -Destination $branchDir

    # Clean up by switching back to the default branch (e.g., master or main)
    # and deleting the local branch to prepare for the next iteration
    git checkout master  # Replace 'master' with 'main' if your repo uses 'main'
    git branch -D $branch
}

# Step 6: Clean up the temporary repository directory
# Once all branches are processed, delete the temporary directory
Set-Location $cloneDir
Remove-Item "repo-temp" -Recurse -Force
