# Claude GLM Profile Switcher
# Backs up current settings and loads GLM configuration

$settingsPath = "$env:USERPROFILE\.claude\settings.json"
$backupPath = "$env:USERPROFILE\.claude\settings-backup.json"
$glmPath = "$env:USERPROFILE\.claude\settings-glm.json"

# Create backup of current settings
if (Test-Path $settingsPath) {
    Copy-Item $settingsPath $backupPath -Force
    Write-Host "✓ Backed up current settings" -ForegroundColor Green
}

# Load GLM configuration
if (Test-Path $glmPath) {
    Copy-Item $glmPath $settingsPath -Force
    Write-Host "✓ Switched to GLM profile" -ForegroundColor Green
    Write-Host "Models: GLM-5 (Opus/Sonnet/Haiku) via Z.AI" -ForegroundColor Cyan
} else {
    Write-Host "⚠ GLM settings file not found at: $glmPath" -ForegroundColor Yellow
    Write-Host "Creating GLM-5 configuration with Z.AI endpoint..." -ForegroundColor Yellow
    
    $glmConfig = @{
        apiKey = "ADD-ZAI-TOKEN-HERE"
        apiUrl = "https://api.z.ai/api/anthropic"
        env = @{
            ANTHROPIC_AUTH_TOKEN = "ADD-ZAI-TOKEN-HERE"
            ANTHROPIC_BASE_URL = "https://api.z.ai/api/anthropic"
            API_TIMEOUT_MS = "3000000"
            ANTHROPIC_DEFAULT_HAIKU_MODEL = "glm-5"
            ANTHROPIC_DEFAULT_SONNET_MODEL = "glm-5"
            ANTHROPIC_DEFAULT_OPUS_MODEL = "glm-5"
        }
    } | ConvertTo-Json -Depth 10
    
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude" | Out-Null
    $glmConfig | Out-File -FilePath $glmPath -Encoding utf8
    Copy-Item $glmPath $settingsPath -Force
    Write-Host "✓ Created GLM-5 profile with Z.AI API key" -ForegroundColor Green
}

Write-Host "`nRun 'claude' to start with GLM-5 via Z.AI" -ForegroundColor White