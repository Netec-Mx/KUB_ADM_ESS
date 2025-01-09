# Práctica 15. Implementando CRDs y Aggregated APIs

## Objetivo de la práctica:

Al finalizar la práctica, serás capaz de:

- Implementar Custom Resource Definitions (CRDs) en un clúster de Kubernetes.
- Crear y aplicar un recurso personalizado utilizando la CRD definida.
- Desarrollar una API agregada y registrarla en el clúster de Kubernetes.
- Comprender cómo extender la funcionalidad de Kubernetes con CRDs y APIs agregadas.

## Descripción de Actividades

Se describe las actividades que debes realizar durante la práctica. Asegúrate de seguir cada paso de manera detallada para lograr los objetivos del laboratorio.

### Actividades principales:

1. **Crear una Custom Resource Definition (CRD)**  
   En esta tarea, crearás una definición personalizada de recurso que se utilizará para extender la API de Kubernetes.

2. **Crear un recurso personalizado usando la CRD**  
   Utilizando la CRD creada en la actividad anterior, generarás un recurso personalizado de Kubernetes.

3. **Desarrollar y registrar una Aggregated API**  
   Crearás un servidor API usando un framework como kube-builder y lo registrarás con APIService para integrarlo al clúster.

### Duración aproximada:

- 60 minutos

## Guía de Ayuda:

A continuación se presenta una tabla con información relevante para la práctica. Esta tabla contiene los valores y configuraciones que utilizarás en las tareas de la práctica.

| Concepto                  | Descripción                                                                     |
| ------------------------- | ------------------------------------------------------------------------------- |
| **API Server**            | Deberás contar con un API Server en funcionamiento en el clúster de Kubernetes. |
| **Configuración de CRD**  | La CRD se aplicará con el archivo `crontab-crd.yaml`.                           |
| **Recurso Personalizado** | El archivo de recurso personalizado es `my-crontab.yaml`.                       |
| **URL de API Agregada**   | La API agregada se registrará en `my-api-apiservice.yaml`.                      |

---

## Instrucciones de Actividades

### Tarea 1. Crear una Custom Resource Definition (CRD)

1. **Definir la CRD**  
   Abre un archivo YAML y define la Custom Resource Definition. A continuación, un ejemplo de la estructura básica de la CRD:
   
   ```yaml
   apiVersion: apiextensions.k8s.io/v1
   kind: CustomResourceDefinition
   metadata:
     name: crontabs.stable.example.com
   spec:
     group: stable.example.com
     versions:
       - name: v1
         served: true
         storage: true
         schema:
           openAPIV3Schema:
             type: object
             properties:
               spec:
                 type: object
                 properties:
                   cronSpec:
                     type: string
                   image:
                     type: string
                   replicas:
                     type: integer
     scope: Namespaced
     names:
       plural: crontabs
       singular: crontab
       kind: CronTab
       shortNames:
         - ct
   ```

2. **Aplicar la CRD**  
   Ejecuta el siguiente comando para aplicar la CRD en el clúster de Kubernetes:
   
   ```bash
   kubectl apply -f crontab-crd.yaml
   ```

### Tarea 2. Crear un recurso personalizado usando la CRD

1. **Definir el recurso personalizado**  
   En un archivo YAML, define el recurso personalizado utilizando la CRD creada. Aquí tienes un ejemplo de configuración para el recurso personalizado:
   
   ```yaml
   apiVersion: stable.example.com/v1
   kind: CronTab
   metadata:
     name: my-crontab
   spec:
     cronSpec: "* * * * */5"
     image: my-cron-image
     replicas: 1
   ```

2. **Aplicar el recurso personalizado**  
   Ejecuta el siguiente comando para aplicar el recurso personalizado al clúster:
   
   ```bash
   kubectl apply -f my-crontab.yaml
   ```

### Tarea 3. Desarrollar y registrar una Aggregated API

1. **Desarrollar el servidor API**  
   Utiliza un framework como kube-builder para desarrollar un servidor API que manejará las solicitudes hacia el nuevo recurso personalizado.

2. **Registrar la Aggregated API**  
   Crea el archivo YAML para registrar la API agregada:
   
   ```yaml
   apiVersion: apiregistration.k8s.io/v1
   kind: APIService
   metadata:
     name: vlalpha1.my-api.example.com
   spec:
     service:
       name: my-api-service
       namespace: default
     group: my-api.example.com
     version: vlalpha1
     insecureSkipTLSVerify: true
     groupPriorityMinimum: 1000
     versionPriority: 15
   ```

3. **Aplicar el registro de la API agregada**  
   Ejecuta el siguiente comando para registrar la API agregada en el clúster de Kubernetes:
   
   ```bash
   kubectl apply -f my-api-apiservice.yaml
   ```

---

## Resultado esperado

Al completar esta práctica, deberías haber logrado los siguientes resultados:

1. **Custom Resource Definition (CRD)**: Se habrá creado y aplicado correctamente la CRD en el clúster.
2. **Recurso personalizado**: El recurso personalizado `CronTab` estará disponible en el clúster y se podrá gestionar.
3. **API agregada**: Se habrá desarrollado e integrado con éxito la API agregada utilizando APIService.
