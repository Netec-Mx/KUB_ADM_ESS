# Práctica 3: Introducción a Minikube

## Objetivo de la práctica

Al finalizar esta práctica, serás capaz de:

- Comprender los aspectos generales de Minikube y su instalación.
- Desplegar una aplicación básica en un clúster local usando Minikube.
- Utilizar comandos básicos de Kubernetes y Minikube para la administración de un clúster.

## Representación Detallada de las Actividades

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

## Duración aproximada

- 90 minutos.

## Guía de Referencia Rápida

Esta sección contiene información clave que podrás necesitar durante la práctica.

| Aspecto             | Detalle                                                                                                                                  |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Versión de Minikube | Asegúrate de usar la versión estable más reciente. Puedes consultarla en la [documentación oficial](https://minikube.sigs.k8s.io/docs/). |
| Requisitos previos  | Tener instalado Docker o un hipervisor compatible como VirtualBox.                                                                       |
| Comandos útiles     | `minikube start`, `minikube status`, `minikube stop`, `kubectl get pods`, `kubectl describe`                                             |
| Problemas comunes   | - Error al iniciar: Verifica que Docker esté corriendo.                                                                                  |
|                     | - Conexión fallida: Asegúrate de que tu red permite conexiones locales.                                                                  |
| Documentación       | Revisa la documentación oficial para soluciones específicas a problemas: https://minikube.sigs.k8s.io/docs/                              |

## Instrucciones

### Tarea 1. Explorar la documentación de Minikube

1. Visitar [https://minikube.sigs.k8s.io/docs/](https://minikube.sigs.k8s.io/docs/).
2. Leer la introducción y familiarizarte con los conceptos básicos.
3. Revisar las guías de instalación según tu sistema operativo.

### Tarea 2. Desinstalar cualquier instalación previa de Kubernetes

1. Verificar si tienes Kubernetes previamente instalado ejecutando `kubectl version`
2. Desinstalar componentes existentes según las instrucciones de tu sistema operativo.

### Tarea 3. Instalar Minikube

1. Descargar Minikube desde la página oficial: [https://minikube.sigs.k8s.io/docs/start/](https://minikube.sigs.k8s.io/docs/start/).
2. Seguir las instrucciones según tu sistema operativo:
   - **Windows:** Usar el instalador MSI o Chocolatey.
   - **macOS:** Usar Homebrew.
   - **Linux:** Descargar y instalar el paquete deb.
3. Verificar la instalación ejecutando `minikube version`.

### Tarea 4. Iniciar un clúster en Minikube

1. Ejecutar `minikube start` para iniciar el clúster.
2. Verificar el estado del clúster con `minikube status`.
3. Practicar con comandos básicos como `kubectl get nodes` y `kubectl cluster-info`.

### Tarea 5. Desplegar una aplicación en Minikube

1. Crear un despliegue ejecutando:
   
   ```bash
   kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4
   ```

2. Exponer el despliegue para acceder a él desde un navegador:
   
   ```bash
   kubectl expose deployment hello-minikube --type=NodePort --port=8080
   ```

3. Obtener la URL para acceder a la aplicación:
   
   ```bash
   minikube service hello-minikube --url
   ```

4. Visitar la URL en un navegador para comprobar que la aplicación está funcionando.

### Resultado esperado

Al finalizar, deberías poder ver en tu navegador un mensaje similar a:

```
Request served by hello-minikube-7d48979fd6-xscqv
```

Esto confirma que el servidor Nginx desplegado está funcionando correctamente en tu clúster Minikube.

### Tarea 6. Documentar tu experiencia

1. Anotar los pasos seguidos y los problemas encontrados.
2. Describir las soluciones aplicadas a los problemas.
3. Preparar una breve presentación o informe con tus aprendizajes.
