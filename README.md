# Mi Sitio Web

## Estructura del Proyecto

A continuación se describen las ubicaciones clave dentro del proyecto para agregar nuevo contenido o elementos multimedia:

### 1. **Agregar Contenido (Markdown)**

Para agregar un nuevo artículo o guía, crea un archivo Markdown en la carpeta `content/blog/`. Los archivos en esta carpeta se renderizarán como entradas de blog en tu sitio.

- Ejemplo de cómo agregar un nuevo post:
  ```bash
  hugo new blog/mi-nuevo-articulo.md
  ```

  Luego, edita el archivo creado en la carpeta `content/blog/` y añade el contenido de tu artículo.

### 2. **Agregar Imágenes**

Las imágenes y otros archivos estáticos deben ir en la carpeta `static/Images/`. Las imágenes que pongas aquí podrán ser referenciadas dentro de tu contenido.

- Ejemplo: Si subes una imagen llamada `mi-imagen.jpg` a `static/Images/`, puedes usarla en tu archivo Markdown de la siguiente manera:
  
  ```markdown
  ![Mi Imagen](../Images/mi-imagen.jpg)
  ```

## Desarrollando el Sitio

Si deseas ver cómo se ve tu sitio localmente antes de hacer cambios, puedes usar el servidor local de Hugo:

```bash
hugo server
```

Esto iniciará un servidor local donde podrás previsualizar el sitio en `https://gomezjoaquin.github.io`.

## Generar el Sitio Estático

Una vez que hayas terminado de agregar tu contenido y estés listo para publicarlo, ejecuta el siguiente comando para generar los archivos estáticos:

```bash
hugo
```

## Deploy
Eliminar docs y eliminar public y eliminar archivo build.lock
usar el comando: hugo
luego esto generará la carpeta public y
para publicar el sitio hay que cambiarle el nombre a la carpeta public por "docs".