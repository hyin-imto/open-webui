# =============================
#  OpenWebUI - Compilar Frontend + Lanzar Backend
# =============================

Write-Host "=== OPEN WEBUI DEV SCRIPT ===" 

$root = Split-Path $MyInvocation.MyCommand.Path
$frontend = "$root\frontend"
$backend = "$root\backend"
$buildFolder = "$root\build"
$targetFolder = "$backend\open_webui\frontend"
$venvPath = "$root\.venv\Scripts\Activate.ps1"  # <-- Ajusta si tu venv se llama .venv


# --------------------------------------------------
# 0) ACTIVAR ENTORNO VIRTUAL
# --------------------------------------------------
Write-Host "[0/4] Activando entorno virtual..." 

if (Test-Path $venvPath) {
    . $venvPath
} 

# --------------------------------------------------
# 1) COMPILAR FRONTEND
# --------------------------------------------------
Write-Host "[1/4] Compilando frontend..." 
Set-Location $frontend

npm install
npm run build 2>&1 | ForEach-Object { Write-Host $_ }


Write-Host " Frontend compilado correctamente" 

# --------------------------------------------------
# 2) COPIAR BUILD AL BACKEND
# --------------------------------------------------
Write-Host "`n[2/4] Copiando build al backend..." 

Copy-Item -Path $buildFolder -Destination $targetFolder -Recurse -Force

Write-Host " Build copiado en backend" 

# # --------------------------------------------------
# # 3) LANZAR BACKEND
# # --------------------------------------------------
# Write-Host [3/4] Lanzando backend
# Set-Location $backend
# $portToUse = 8090
# # UTF-8 para PowerShell
# chcp 65001 | Out-Null
# $OutputEncoding = [System.Text.Encoding]::UTF8

# # UTF-8 para Python
# $env:PYTHONUTF8="1"

# uvicorn open_webui.main:app --host 0.0.0.0 --port $portToUse --reload 2>&1 | ForEach-Object { Write-Host $_ }
