# Práctica 3. Introducción a Minikube

## Objetivo de la práctica:

Al finalizar esta práctica, serás capaz de:

- Comprender los aspectos generales de Minikube y su instalación.
- Desplegar una aplicación básica en un clúster local usando Minikube.
- Utilizar comandos básicos de Kubernetes y Minikube para la administración de un clúster.

## Objetivo visual:

A continuación, se describe de manera estructurada las actividades necesarias para esta práctica:

```
Inicio de la práctica
  ├── Explorar la documentación de Minikube
  ├── Desinstalar cualquier instalación previa de Kubernetes
  ├── Instalar Minikube según el sistema operativo
  ├── Iniciar un clúster en Minikube
  │     ├── Ejecutar comandos de configuración
  │     └── Verificar el estado del clúster
  ├── Desplegar una aplicación
  │     ├── Configurar y desplegar servidor Nginx
  │     └── Verificar el estado del despliegue
  └── Documentar experiencia y resultados
        ├── Anotar pasos realizados
        ├── Identificar problemas y soluciones
        └── Preparar informe o presentación
Fin de la práctica
```

## Duración aproximada:

- 90 minutos.

## Tabla de ayuda:

Esta sección contiene información clave que podrás necesitar durante la práctica.

| Aspecto             | Detalle                                                                                                                                  |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Versión de Minikube | Asegúrate de usar la versión estable más reciente. Puedes consultarla en la [documentación oficial](https://minikube.sigs.k8s.io/docs/). |
| Requisitos previos  | Tener instalado Docker o un hipervisor compatible como VirtualBox.                                                                       |
| Comandos útiles     | `minikube start`, `minikube status`, `minikube stop`, `kubectl get pods`, `kubectl describe`                                             |
| Problemas comunes   | - Error al iniciar: Verifica que Docker esté corriendo.                                                                                  |
|                     | - Conexión fallida: Asegúrate de que tu red permite conexiones locales.                                                                  |
| Documentación       | Revisa la documentación oficial para soluciones específicas a problemas: https://minikube.sigs.k8s.io/docs/                              |

## Instrucciones:

### Tarea 1. Explorar la documentación de Minikube.

Paso 1. Visita el siguiente enlace: [https://minikube.sigs.k8s.io/docs/](https://minikube.sigs.k8s.io/docs/).

Paso 2. Lee la introducción y familiarízate con los conceptos básicos.

Paso 3. Revisa las guías de instalación según tu sistema operativo.

### Tarea 2. Desinstalar cualquier instalación previa de Kubernetes.

Paso 1. Verifica si tienes Kubernetes previamente instalado ejecutando el siguiente comando:
```
kubectl version
```

Paso 2. Desinstala los componentes existentes según las instrucciones de tu sistema operativo.

### Tarea 3. Instalar Minikube.

Paso 1. Descarga Minikube desde la página oficial: [https://minikube.sigs.k8s.io/docs/start/](https://minikube.sigs.k8s.io/docs/start/).

Paso 2. Sigue las instrucciones según tu sistema operativo:

   - **Windows:** Usar el instalador MSI o Chocolatey.
   - **macOS:** Usar Homebrew.
   - **Linux:** Descargar y instalar el paquete deb.

Paso 3. Verifica la instalación ejecutando el comando:

```
minikube version
```

### Tarea 4. Iniciar un clúster en Minikube.

Paso 1. Ejecuta el siguiente comando para iniciar el clúster:

```
minikube start
```

Paso 2. Verifica el estado del clúster con el comando:

```
minikube status
```

Paso 3. Practica con comandos básicos, tales como: `kubectl get nodes` y `kubectl cluster-info`.

### Tarea 5. Desplegar una aplicación en Minikube.

Paso 1. Crea un despliegue ejecutando:
   
   ```bash
   kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4
   ```

2. Debes exponer el despliegue para acceder a él desde un navegador:
   
   ```bash
   kubectl expose deployment hello-minikube --type=NodePort --port=8080
   ```

3. Obtén la URL para acceder a la aplicación:
   
   ```bash
   minikube service hello-minikube --url
   ```

4. Visita la URL en un navegador para comprobar que la aplicación está funcionando.

### Resultado esperado:

Al finalizar, deberías poder ver en tu navegador un mensaje similar a:

```
Request served by hello-minikube-7d48979fd6-xscqv
```

Esto confirma que el servidor Nginx desplegado está funcionando correctamente en tu clúster Minikube.

### Tarea 6. Documentar tu experiencia.

1. Anota los pasos seguidos y los problemas encontrados.
2. Describe las soluciones aplicadas a los problemas.
3. Prepara una breve presentación o informe con tus aprendizajes.
