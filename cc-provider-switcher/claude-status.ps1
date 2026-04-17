# Claude Profile Status Checker
# Shows current active profile

$settingsPath = "$env:USERPROFILE\.claude\settings.json"

if (Test-Path $settingsPath) {
    $settings = Get-Content $settingsPath | ConvertFrom-Json
    
    Write-Host "`n=== Claude Code Profile Status ===" -ForegroundColor Cyan
    
    if ($settings.env.ANTHROPIC_BASE_URL -match "z.ai") {
        Write-Host "Active Profile: GLM (Z.AI)" -ForegroundColor Green
        Write-Host "API Endpoint: $($settings.env.ANTHROPIC_BASE_URL)" -ForegroundColor White
        Write-Host "Models:" -ForegroundColor White
        Write-Host "  Opus:   $($settings.env.ANTHROPIC_DEFAULT_OPUS_MODEL)" -ForegroundColor Gray
        Write-Host "  Sonnet: $($settings.env.ANTHROPIC_DEFAULT_SONNET_MODEL)" -ForegroundColor Gray
        Write-Host "  Haiku:  $($settings.env.ANTHROPIC_DEFAULT_HAIKU_MODEL)" -ForegroundColor Gray
    } else {
        Write-Host "Active Profile: Anthropic" -ForegroundColor Green
        Write-Host "API Endpoint: Default (https://api.anthropic.com)" -ForegroundColor White
        Write-Host "Models: Claude Opus 4.5, Sonnet 4.5, Haiku 4" -ForegroundColor Gray
    }
    
    Write-Host "`nSwitch profiles with:" -ForegroundColor Cyan
    Write-Host "  claude-anthropic  - Use Anthropic Claude models" -ForegroundColor White
    Write-Host "  claude-glm        - Use Z.AI GLM models" -ForegroundColor White
} else {
    Write-Host "⚠ No Claude settings found at: $settingsPath" -ForegroundColor Yellow
}