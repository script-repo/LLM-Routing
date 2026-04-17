# Claude Anthropic Profile Switcher
# Backs up current settings and loads Anthropic configuration

$settingsPath = "$env:USERPROFILE\.claude\settings.json"
$backupPath = "$env:USERPROFILE\.claude\settings-backup.json"
$anthropicPath = "$env:USERPROFILE\.claude\settings-anthropic.json"

# Create backup of current settings
if (Test-Path $settingsPath) {
    Copy-Item $settingsPath $backupPath -Force
    Write-Host "✓ Backed up current settings" -ForegroundColor Green
}

# Load Anthropic configuration
if (Test-Path $anthropicPath) {
    Copy-Item $anthropicPath $settingsPath -Force
    Write-Host "✓ Switched to Anthropic profile" -ForegroundColor Green
    Write-Host "Models: Claude Opus 4.5, Sonnet 4.5, Haiku 4" -ForegroundColor Cyan
} else {
    Write-Host "⚠ Anthropic settings file not found at: $anthropicPath" -ForegroundColor Yellow
    Write-Host "Creating default Anthropic configuration..." -ForegroundColor Yellow
    
    $anthropicConfig = @{
        apiKey = $null
        env = @{}
    } | ConvertTo-Json -Depth 10
    
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude" | Out-Null
    $anthropicConfig | Out-File -FilePath $anthropicPath -Encoding utf8
    Copy-Item $anthropicPath $settingsPath -Force
    Write-Host "✓ Created default Anthropic profile" -ForegroundColor Green
}

Write-Host "`nRun 'claude' to start with Anthropic models" -ForegroundColor White