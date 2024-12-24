# Práctica 8: Implementación de DaemonSets y uso de etiquetas

## Objetivo de la práctica
Al finalizar esta práctica, serás capaz de:
- Implementar DaemonSets en Kubernetes para desplegar Pods en cada nodo del clúster.
- Utilizar etiquetas para organizar y administrar Pods de manera eficiente.
- Escalar el clúster y verificar la actualización automática de DaemonSets en nuevos nodos.

## Explicación ilustrativa
En esta práctica, aprenderemos a desplegar DaemonSets y a utilizar etiquetas para clasificar y gestionar Pods. Las etiquetas son útiles para filtrar, organizar y aplicar configuraciones específicas a subconjuntos de Pods.

| Concepto clave | Descripción |
| --- | --- |
| **DaemonSet** | Garantiza que un Pod específico se ejecute en todos o en un subconjunto de nodos del clúster. |
| **Etiqueta** | Par clave-valor que se asigna a objetos en Kubernetes para clasificarlos y organizarlos. |

### Esquema textual del flujo de actividades:
1. Crear el manifiesto YAML para un DaemonSet básico.
2. Aplicar el manifiesto al clúster con `kubectl`.
3. Verificar los Pods creados y organizarlos mediante etiquetas.
4. Escalar el clúster y observar la actualización automática del DaemonSet.

## Duración estimada:
- 60 minutos.

## Ayuda para la práctica: Recursos y contexto
| Elemento | Descripción |
| --- | --- |
| **Archivo YAML** | El manifiesto para definir y gestionar DaemonSets. |
| **Comandos esenciales** | `kubectl apply`, `kubectl get pods`, `kubectl label`. |
| **Rol de etiquetas** | Identificar y agrupar Pods para operaciones específicas. |
| **Escalar clúster** | Incrementar el número de nodos para observar la propagación del DaemonSet. |
| **Documentación oficial** | [DaemonSets en Kubernetes](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) |

---

## Instrucciones detalladas

### Tarea 1: Crear un DaemonSet básico
#### Paso 1: Escribir el manifiesto YAML para el DaemonSet
1. Abrir un editor de texto de tu elección y crear un archivo llamado `nginx-daemonset.yaml`.
2. Añadir el siguiente contenido al archivo:

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: nginx-daemonset
spec:
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
        role: logging
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
```
> **Nota**: Este manifiesto define un DaemonSet que ejecutará un contenedor Nginx en todos los nodos del clúster.

#### Paso 2: Aplicar el archivo YAML
- Utilizar el siguiente comando para implementar el DaemonSet en el clúster:

```bash
kubectl apply -f nginx-daemonset.yaml
```

#### Paso 3: Verificar la creación de Pods
- Verificar que los Pods se han desplegado en cada nodo:

```bash
kubectl get pods -o wide
```

---

### Tarea 2: Agregar y gestionar etiquetas
#### Paso 1: Verificar las etiquetas de los Pods
- Ejecutar el siguiente comando para listar los Pods con etiquetas:

```bash
kubectl get pods --show-labels
```

#### Paso 2: Modificar etiquetas existentes (si es necesario)
- Para agregar o actualizar una etiqueta en un Pod específico, utiliza el siguiente comando:

```bash
kubectl label pods <pod-name> role=logging --overwrite
```
> Reemplaza `<pod-name>` con el nombre del Pod que deseas modificar.

---

### Tarea 3: Escalar el clúster y observar el comportamiento de DaemonSets
#### Paso 1: Escalar el clúster
- Si estás usando Minikube, puedes agregar un nodo adicional con el siguiente comando:

```bash
minikube node add
```

#### Paso 2: Verificar la propagación del DaemonSet
- Confirmar que los Pods del DaemonSet se han desplegado en los nuevos nodos:

```bash
kubectl get pods -o wide
```

---

## Resultado esperado
Al finalizar esta práctica, deberás haber logrado:
- Crear un DaemonSet que implemente Nginx en todos los nodos.
- Utilizar etiquetas para identificar y organizar Pods.
- Observar cómo los DaemonSets se actualizan automáticamente al escalar el clúster.

---

## Notas y aclaraciones
- Un **DaemonSet** asegura que un Pod se ejecute en cada nodo del clúster. Esto es útil para tareas como la recopilación de registros o la implementación de aplicaciones críticas.
- Las **etiquetas** son esenciales para administrar objetos en Kubernetes de manera eficiente. Ayudan a filtrar y aplicar configuraciones específicas.
- La escalabilidad de los DaemonSets garantiza que se adapten automáticamente a los cambios en la infraestructura del clúster.

---

## Consideraciones finales
- Familiarízate con los comandos de `kubectl` utilizados en esta práctica, ya que son esenciales para administrar Kubernetes.
- Consulta la [documentación oficial](https://kubernetes.io/docs/home/) para obtener más detalles y mejores prácticas sobre DaemonSets y etiquetas.
