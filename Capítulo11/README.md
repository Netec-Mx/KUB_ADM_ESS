# Práctica 13. Configuración y Gestión del Scheduler en Kubernetes

## Objetivos de la práctica

Al finalizar esta práctica, serás capaz de:

- Configurar el Scheduler en un clúster de Kubernetes para optimizar la asignación de Pods.
- Especificar Pods con configuraciones avanzadas, como volúmenes y recursos dedicados.
- Aplicar reglas de afinidad para optimizar el posicionamiento de Pods en los nodos.
- Gestionar taints y tolerations para controlar la ubicación de los Pods en el clúster.

## Explicación:

A continuación, se incluye una descripción organizada de las actividades de la práctica:

1. Configuración del Scheduler:
   - Modificación de parámetros mediante archivos YAML.
   - Uso de plugins para personalizar el Scheduler.
2. Especificación de Pods:
   - Definición de recursos mínimos y máximos para contenedores.
   - Configuración de volúmenes persistentes.
3. Reglas de Afinidad:
   - Uso de nodeAffinity para limitar el posicionamiento de Pods en nodos específicos.
   - Configuración de afinidad mediante operadores como `In` y `NotIn`.
4. Taints y Tolerations:
   - Adición de taints a nodos específicos para restringir la asignación.
   - Uso de tolerations en Pods para permitir excepciones.

| Sección        | Descripción                                                                     |
| ------------------ | ----------------------------------------------------------------------------------- |
| Scheduler          | Configuración avanzada con plugins y parámetros personalizados.                     |
| Pods               | Definición de recursos, volúmenes y configuraciones avanzadas como init containers. |
| Node Affinity      | Reglas para la ubicación óptima de los Pods en los nodos.                           |
| Taints/Tolerations | Restricción y control de ubicación mediante políticas de tolerancia.                |

## Duración aproximada:

- 60 minutos.

## Tabla de ayuda:

Esta sección proporciona información útil para realizar la práctica:

| Elemento                | Explicación                                                                                         |
| --------------------------- | ------------------------------------------------------------------------------------------------------- |
| Versión de Kubernetes   | Asegúrate de usar una versión compatible con Node Affinity y tolerations (recomendado 1.22 o superior). |
| Configuración de Pods   | Incluye siempre especificaciones como recursos solicitados (CPU, memoria) y límites.                    |
| Nodo reservado          | Para pruebas con taints, selecciona un nodo que no esté crítico en el clúster.                          |
| Herramientas necesarias | kubectl instalado y configurado correctamente para interactuar con el clúster.                          |

## Instrucciones:

### Tarea 1. Configurar el Scheduler.

Paso 1. Revisa la configuración actual del Scheduler:
   
   ```bash
   kubectl get componentstatuses
   ```

Paso 2. Crea o modifica un archivo YAML para personalizar el Scheduler:
   
   ```yaml
   apiVersion: kubescheduler.config.k8s.io/v1
   kind: KubeSchedulerConfiguration
   leaderElection:
     leaderElect: true
   ```

Paso 3. Aplica la configuración personalizada:
   
   ```bash
   kubectl apply -f scheduler-config.yaml
   ```

### Tarea 2. Especificar un Pod.

Paso 1. Crea un archivo YAML para definir un Pod:
   
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: example-pod
   spec:
     containers:
     - name: nginx
       image: nginx
       resources:
         requests:
           memory: "64Mi"
           cpu: "250m"
         limits:
           memory: "128Mi"
           cpu: "500m"
   ```

Paso 2. Aplica la especificación del Pod:
   
   ```bash
   kubectl apply -f pod-definition.yaml
   ```

### Tarea 3. Aplicar Node Affinity.

Paso 1. Crea un archivo YAML para Node Affinity:
   
   ```yaml
   affinity:
     nodeAffinity:
       requiredDuringSchedulingIgnoredDuringExecution:
         nodeSelectorTerms:
         - matchExpressions:
           - key: kubernetes.io/e2e-az-name
             operator: In
             values:
             - e2e-az1
             - e2e-az2
   ```

Paso 2. Aplica el archivo de configuración:
   
   ```bash
   kubectl apply -f affinity-config.yaml
   ```

### Tarea 4. Configurar Taints y Tolerations.

Paso 1. Agrega un taint a un nodo:
   
   ```bash
   kubectl taint nodes nodename key=value:NoSchedule
   ```

Paso 2. Define tolerations en el Pod:
   
   ```yaml
   tolerations:
   - key: "key"
     operator: "Equal"
     value: "value"
     effect: "NoSchedule"
   ```

Paso 3. Aplica las configuraciones:
   
   ```bash
   kubectl apply -f pod-tolerations.yaml
   ```

### Resultado esperado:

- Scheduler configurado correctamente con parámetros personalizados.
- Pods definidos con configuraciones avanzadas.
- Reglas de afinidad aplicadas, posicionando Pods de forma óptima en los nodos.
- Taints y tolerations gestionados adecuadamente, controlando la asignación de Pods en el clúster.

| Resultados clave | Descripción                                            |
| -------------------- | ---------------------------------------------------------- |
| Scheduler            | Personalización aplicada con éxito.                        |
| Pods                 | Configurados con especificaciones avanzadas.               |
| Node Affinity        | Afinidad correctamente implementada.                       |
| Taints/Tolerations   | Gestión eficiente y restrictiva según políticas definidas. |

## Aclaraciones y conceptos útiles

- Node Affinity: Permite definir reglas que controlan en qué nodos pueden ejecutarse los Pods.
- Taints: Restringen la asignación de Pods a nodos específicos.
- Tolerations: Permiten que ciertos Pods puedan superar las restricciones impuestas por taints.
- Scheduler: Es el componente de Kubernetes responsable de asignar Pods a nodos específicos según reglas y configuraciones predefinidas.
