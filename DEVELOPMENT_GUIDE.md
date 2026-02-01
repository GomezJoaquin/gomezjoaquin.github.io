# Guía de Desarrollo - Sitio Personal

Esta guía te muestra cómo trabajar en el desarrollo local de tu sitio y cómo subirlo a GitHub.

## 📋 Tabla de Contenidos

1. [Requisitos Previos](#requisitos-previos)
2. [Configuración Inicial](#configuración-inicial)
3. [Desarrollo Local](#desarrollo-local)
4. [Agregar Cambios](#agregar-cambios)
5. [Subir a GitHub](#subir-a-github)
6. [Estructura del Proyecto](#estructura-del-proyecto)

---

## 🔧 Requisitos Previos

Asegúrate de tener instalado:

- **Hugo** (v0.123.7 o superior)
- **Git**
- **Navegador web** (Chrome, Firefox, Safari, etc.)

### Verificar instalación

```bash
hugo version
git --version
```

---

## 🚀 Configuración Inicial

### 1. Clonar el repositorio (primera vez)

```bash
git clone https://github.com/GomezJoaquin/gomezjoaquin.github.io.git
cd gomezjoaquin.github.io
```

### 2. Verificar la rama correcta

```bash
git branch
# Deberías estar en 'main'
```

---

## 💻 Desarrollo Local

### 1. Iniciar el servidor de desarrollo

```bash
hugo server
```

**Salida esperada:**
```
Web Server is available at http://localhost:1313/
```

### 2. Acceder al sitio

Abre tu navegador y ve a: **http://localhost:1313/**

### 3. Hacer cambios

El servidor está en modo "Fast Render", así que los cambios se reflejan automáticamente:

- Edita archivos en `config.yaml`
- Modifica contenido en `content/blogs/`
- Agrega imágenes en `static/images/`

**Recarga el navegador** para ver los cambios.

### 4. Detener el servidor

Presiona `Ctrl + C` en la terminal.

---

## 📝 Agregar Cambios

### Agregar un nuevo blog post

```bash
hugo new blogs/mi-nuevo-articulo.md
```

Esto crea un archivo en `content/blogs/mi-nuevo-articulo.md` con la estructura básica.

**Edita el archivo:**

```markdown
---
title: "Mi Nuevo Artículo"
date: 2026-01-31T00:00:00+00:00
draft: false
author: "Joaquín Gómez"
tags:
  - AWS
  - DevOps
image: /images/mi-imagen.jpg
description: "Descripción breve del artículo"
toc: true
---

## Contenido del artículo

Tu contenido aquí...
```

### Agregar una imagen

1. Coloca la imagen en `static/images/`
2. Referencia en tu contenido:

```markdown
![Descripción](../images/mi-imagen.jpg)
```

### Modificar configuración

Edita `config.yaml` para cambiar:
- Título, descripción
- Skills, experiencia
- Certificaciones
- Información de contacto

---

## 🔄 Subir a GitHub

### Paso 1: Ver cambios

```bash
git status
```

**Salida esperada:**
```
On branch main
Changes not staged for commit:
  modified:   config.yaml
  new file:   content/blogs/nuevo-articulo.md
```

### Paso 2: Agregar cambios

```bash
# Agregar todos los cambios
git add .

# O agregar archivos específicos
git add config.yaml
git add content/blogs/nuevo-articulo.md
```

### Paso 3: Crear commit

```bash
git commit -m "Descripción clara de los cambios"
```

**Ejemplos de buenos mensajes:**

```bash
git commit -m "Agregar nuevo artículo sobre Kubernetes"
git commit -m "Actualizar sección de skills"
git commit -m "Agregar nueva certificación AWS"
git commit -m "Mejorar descripción en About"
```

### Paso 4: Generar sitio estático

```bash
# Limpiar archivos anteriores
rm -rf docs public .hugo_build.lock

# Generar el sitio
hugo

# Renombrar public a docs (para GitHub Pages)
mv public docs
```

### Paso 5: Agregar cambios generados

```bash
git add .
```

### Paso 6: Subir a GitHub

```bash
git push origin main
```

**Salida esperada:**
```
Enumerating objects: 55, done.
...
To https://github.com/GomezJoaquin/gomezjoaquin.github.io.git
   e1df1ae..50d5175  main -> main
```

---

## 🔄 Flujo Completo (Resumen Rápido)

```bash
# 1. Hacer cambios en el código
# (editar config.yaml, agregar blog posts, etc.)

# 2. Probar localmente
hugo server
# Visita http://localhost:1313/

# 3. Generar sitio estático
rm -rf docs public .hugo_build.lock
hugo
mv public docs

# 4. Subir a GitHub
git add .
git commit -m "Descripción de cambios"
git push origin main
```

---

## 📁 Estructura del Proyecto

```
gomezjoaquin.github.io/
├── config.yaml              # Configuración principal del sitio
├── content/
│   └── blogs/               # Artículos del blog
│       ├── aws-iam.md
│       ├── ssh-clave-publica.md
│       └── ...
├── static/
│   └── images/              # Imágenes del sitio
│       ├── hero.png
│       ├── me.png
│       └── ...
├── docs/                    # Sitio generado (NO editar)
├── themes/
│   └── hugo-profile/        # Tema del sitio
├── deploy.sh                # Script de despliegue
└── README.md
```

---

## 📋 Checklist Antes de Subir

- [ ] Probé los cambios localmente con `hugo server`
- [ ] El sitio se ve bien en modo claro y oscuro
- [ ] Los links funcionan correctamente
- [ ] Las imágenes se cargan sin problemas
- [ ] No hay errores en la consola del navegador
- [ ] Generé el sitio con `hugo` y renombré `public` a `docs`
- [ ] Escribí un mensaje de commit descriptivo

---

## 🐛 Solución de Problemas

### El servidor no inicia

```bash
# Verifica que estés en el directorio correcto
pwd
# Deberías ver: /home/joaquin/Proyectos/gomezjoaquin.github.io

# Verifica que Hugo esté instalado
hugo version
```

### Los cambios no se reflejan

```bash
# Detén el servidor (Ctrl + C)
# Limpia la caché
rm -rf resources

# Reinicia el servidor
hugo server
```

### Error al hacer push

```bash
# Verifica que tengas credenciales configuradas
git config --global user.email "ggomezjjoaquin@gmail.com"
git config --global user.name "Joaquín Gómez"

# Intenta de nuevo
git push origin main
```

---

## 📚 Recursos Útiles

- [Documentación de Hugo](https://gohugo.io/documentation/)
- [Guía de Git](https://git-scm.com/doc)
- [Markdown Syntax](https://www.markdownguide.org/)
- [GitHub Pages](https://pages.github.com/)

---

## 💡 Tips Útiles

### Ver historial de commits

```bash
git log --oneline
```

### Ver cambios antes de hacer commit

```bash
git diff
```

### Deshacer cambios no guardados

```bash
git checkout -- archivo.md
```

### Crear una rama para experimentar

```bash
git checkout -b nueva-rama
# Hacer cambios...
git push origin nueva-rama
```

---

## 🎯 Próximos Pasos

1. Agrega más artículos al blog
2. Actualiza tu experiencia laboral
3. Agrega nuevas certificaciones
4. Mejora las imágenes del sitio
5. Considera agregar un formulario de contacto

---

**Última actualización:** 31 de Enero, 2026
