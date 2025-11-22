This PowerShell script remotely checks all Active Directory–joined computers and reports which logical disks are above or below a defined free-space threshold.

<h1>Features</h1>

- Retrieves all AD computer names automatically

- Queries each machine using Invoke-Command

- Checks all fixed disks (DriveType=3)

- Compares free space vs. total size using a configurable threshold

- Color-coded output for easy visibility (Red = below threshold, Green = above)

- Summary per machine (how many volumes are below/above threshold)

<h1>How It Works</h1>

- Pull all computer objects from Active Directory

<h3>For each computer:</h3>

- Collect disk free space

- Collect disk size

- Collect disk names

- Compare free space percentage to the threshold

- Print results and a final summary

<h1>Prerequisites</h1>

- Active Directory module (Get-ADComputer)

- WinRM enabled on remote machines

- Sufficient permissions to run remote PowerShell commands
