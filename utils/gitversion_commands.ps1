# Install gitversion using choco
choco install gitversion.portable -y

# Determine version using gitversion
gitversion /overrideconfig next-version=1.0.0 /output json /output file

# Get fullsemver value from gitversion.json
$jsonObj = Get-Content -Path Gitversion.json | ConvertFrom-Json
$jsonObj.FullSemVer