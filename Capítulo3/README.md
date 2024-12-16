
# **Implementación y gestión de un Pod en Kubernetes**

## Objetivos de la práctica:
Al finalizar esta práctica, los estudiantes serán capaces de:

- Implementar un clúster de Kubernetes usando Minikube o kubeadm.
- Crear y gestionar Pods en Kubernetes.
- Configurar servicios y políticas de red para la interacción entre Pods.
- Comprender la estructura de un clúster y la administración de sus recursos.

## Actividades visuales (Diagramas y esquemas recomendados):
En esta sección se sugiere crear representaciones visuales para ayudar a los estudiantes a comprender el proceso. Se recomienda mostrar un diagrama que ilustre la arquitectura de un clúster Kubernetes, la distribución de Pods y la configuración de servicios y redes.

(Espacio para insertar un diagrama que represente el flujo de implementación en Kubernetes)

## Duración aproximada:
- **60 minutos**.

## Información útil para la práctica:

| **Elemento** | **Descripción** |
|--------------|-----------------|
| **Versión de Kubernetes** | Asegúrese de usar la versión estable más reciente de Kubernetes (1.25 o superior). |
| **Versión de Minikube** | Recomendado: Minikube 1.23 o superior. Verifique la compatibilidad con el driver de virtualización. |
| **Versión de kubectl** | Asegúrese de usar la misma versión que su clúster de Kubernetes. |
| **Redes y Puertos** | Los Pods estarán expuestos a través del puerto 30007 para los servicios tipo NodePort. |
| **Credenciales necesarias** | Tenga acceso a un terminal con privilegios de administrador en su máquina para configurar el clúster. |
| **Comandos clave** | Uso de `kubectl` para gestionar el clúster y los recursos. |

## Instrucciones detalladas:

### Tarea 1: Crear un clúster de Kubernetes

**Paso 1:** Iniciar el clúster con Minikube:
- Comando para iniciar Minikube:
  ```bash
  minikube start --driver=virtualbox
  ```
  Esto creará un clúster de Kubernetes local utilizando Minikube.

**Paso 2:** Verificar que el clúster se ha iniciado correctamente:
  ```bash
  kubectl get nodes
  ```
  Este comando lista los nodos activos en el clúster.

**Paso 3:** Alternativamente, si usas kubeadm:
- Inicializa el clúster en el nodo maestro:
  ```bash
  sudo kubeadm init --pod-network-cidr=10.244.0.0/16
  ```
- Configura kubectl para el usuario no root:
  ```bash
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  ```

### Tarea 2: Unir nodos de trabajo al clúster

**Paso 1:** Ejecutar el siguiente comando en el nodo de trabajo:
  ```bash
  sudo kubeadm join <master-ip>:<master-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>
  ```

**Paso 2:** Verifique que los nodos se han unido correctamente ejecutando:
  ```bash
  kubectl get nodes
  ```

### Tarea 3: Desplegar un contenedor en un Pod

**Paso 1:** Crear el manifiesto YAML para el despliegue de un contenedor NGINX:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
```

**Paso 2:** Aplicar el manifiesto para crear el despliegue:
  ```bash
  kubectl apply -f nginx-deployment.yaml
  ```

### Tarea 4: Configurar un servicio NodePort

**Paso 1:** Crear el servicio NodePort para exponer el despliegue de NGINX:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30007
```

**Paso 2:** Aplicar el manifiesto para crear el servicio:
  ```bash
  kubectl apply -f nginx-service.yaml
  ```

**Paso 3:** Acceder al servicio desde el navegador utilizando la IP del nodo y el puerto asignado:
  ```http
  http://<node-ip>:30007
  ```

### Tarea 5: Aplicar políticas de red básicas

**Paso 1:** Crear una política de red para permitir el tráfico entre Pods seleccionados:
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-nginx
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: nginx
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: nginx
    ports:
    - protocol: TCP
      port: 80
```

**Paso 2:** Aplicar la política de red:
  ```bash
  kubectl apply -f network-policy.yaml
  ```

## Resultado esperado:
Al finalizar la práctica, los estudiantes habrán completado lo siguiente:

1. Creado y configurado un clúster de Kubernetes.
2. Desplegado contenedores dentro de Pods.
3. Configurado servicios para exponer las aplicaciones en contenedores.
4. Aplicado políticas de red para gestionar el tráfico entre Pods.

(Espacio para insertar imagen final del despliegue o interacción con el clúster)
