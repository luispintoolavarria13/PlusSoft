#!/usr/bin/env pwsh
# install.ps1 - Instala todos los skills de LuisPinto en OpenCode
# Ejecutar: .\install.ps1

$REPO_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$SKILLS_DIR = "$env:USERPROFILE\.opencode\skills"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Instalando skills de LuisPinto..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Crear directorio de skills si no existe
if (-not (Test-Path $SKILLS_DIR)) {
    New-Item -ItemType Directory -Path $SKILLS_DIR -Force | Out-Null
    Write-Host "  ✓ Creado $SKILLS_DIR" -ForegroundColor Green
}

# Copiar cada skill
$skills = Get-ChildItem "$REPO_DIR\skills" -Directory
$count = 0

foreach ($skill in $skills) {
    $src = $skill.FullName
    $dst = Join-Path $SKILLS_DIR $skill.Name
    
    if (Test-Path $dst) {
        Remove-Item -Recurse -Force $dst
    }
    Copy-Item -Recurse -Force $src $dst
    Write-Host "  ✓ $($skill.Name)" -ForegroundColor Green
    $count++
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  $count skills instalados correctamente" -ForegroundColor Green
Write-Host "  Reinicia OpenCode para usarlos" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
