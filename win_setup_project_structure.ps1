param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName
)

# Function to create folder if it doesn't exist
function Create-FolderIfNotExists {
    param (
        [string]$Path
    )
    if (-not (Test-Path -Path $Path)) {
        New-Item -Path $Path -ItemType Directory
        Write-Host "Created folder: $Path"
    } else {
        Write-Host "Folder already exists: $Path"
    }
}

# Create root project folder
$rootFolder = Join-Path -Path $PScriptRoot -ChildPath $ProjectName
Create-FolderIfNotExists -Path $rootFolder

# Create subfolders
$subfolders =@(
    "001_Management",
    "002_Requirements",
    "003_Architecture",
    "004_Development",
    "005_Data",
    "006_Testing",
    "007_Monitoring",
    "008_Documentation",
    "009_Research"
)

foreach ($folder in $subfolders) {
    $folderPath = Join-Path -Path $rootFolder -ChildPath $folder
    Create-FolderIfNotExists -Path $folderPath
}

# Create README.md
$markdownContent = @"
# Project Folder Structure

## 001_Management

Store project timelines, stakeholder information, budget documents, and other administrative materials.

## 002_Requirements

Maintain business and technical requirements, including service level agreements (SLAs) and performance expectations.

## 003_Architecture

House system design documents, data flow diagrams, and technology comparisons for the project's infrastructure.

## 004_Development

Contain source code, configuration files, and deployment scripts related to the project's implementation.

## 005_Data

Store data schemas, mapping documents, and any data transformation logic required for the project.

## 006_Testing

Include varios test types such as unit tests, integration tests, and performance tests to ensure system reliability.

## 007_Monitoring

Contain monitoring designs, alert configurations, and dashboard setups for comprehensive system oversight.

## 008_Documentation

Store technical specifications, user guides, and operation runbooks for the project.

## 009_Research

Compile research on relevant technologies, industry best practices, and applicable case studies.
"@

# Create or update README.md
$markdownFile = Join-Path -Path $rootFolder -ChildPath "README.md"
if (-not (Test-Path -Path $markdownFile)) {
    $markdownContent | Out-File -FilePath $markdownFile -Encoding utf8
    Write-Host "Created README.md: $markdownFile"
} else {
    Write-Host "README.md file already exists: $markdownFile"
}

Write-Host "Project structure for '$ProjectName' has been created/updated successfully."