#!/bin/bash

# Script para desplegar el sitio Hugo a GitHub Pages

echo "🧹 Limpiando archivos anteriores..."
rm -rf docs public .hugo_build.lock

echo "🏗️  Generando sitio con Hugo..."
hugo

if [ $? -ne 0 ]; then
    echo "❌ Error al generar el sitio"
    exit 1
fi

echo "📁 Renombrando public a docs..."
mv public docs

echo "📝 Agregando cambios a Git..."
git add .

echo "💬 Ingresa el mensaje del commit:"
read commit_message

if [ -z "$commit_message" ]; then
    commit_message="Actualizar sitio - $(date '+%Y-%m-%d %H:%M')"
fi

git commit -m "$commit_message"

echo "🚀 Subiendo a GitHub..."
git push origin main

echo "✅ ¡Sitio desplegado exitosamente!"
echo "🌐 Tu sitio estará disponible en: https://gomezjoaquin.github.io"