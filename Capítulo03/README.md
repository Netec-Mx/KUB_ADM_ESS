# Práctica 5: Implementación y Gestión de un Pod en Kubernetes

## Objetivo de la práctica

Al finalizar esta práctica, serás capaz de:

- Crear un clúster de Kubernetes utilizando Minikube o kubeadm.
- Implementar y gestionar Pods en Kubernetes.
- Configurar servicios y aplicar políticas de red básicas.

## Esquema Estructurado de Actividades

A continuación, se muestra un esquema textual que describe de manera estructurada las actividades:

```
Inicio
 |
 ├── Crear clúster de Kubernetes
 |     ├── Usar Minikube o kubeadm
 |     └── Verificar estado del clúster
 |
 ├── Añadir nodos al clúster
 |     └── Configurar kubeadm join en nodos de trabajo
 |
 ├── Desplegar aplicación
 |     ├── Crear manifiesto de despliegue
 |     └── Aplicar manifiesto con kubectl
 |
 ├── Configurar servicio
 |     ├── Crear y aplicar manifiesto de servicio NodePort
 |     └── Acceder al servicio desde navegador
 |
 └── Aplicar políticas de red
       ├── Crear manifiesto de política de red
       └── Aplicar manifiesto con kubectl
Fin
```

## Duración aproximada

- 60 a 120 minutos.

## Recursos útiles para la práctica

Esta sección contiene información relevante que puede ser de ayuda durante la práctica:

| Elemento                | Detalles                                                                        |
| ----------------------- | ------------------------------------------------------------------------------- |
| Rango de red de Pods    | 10.244.0.0/16                                                                   |
| Comandos frecuentes     | `minikube start`, `kubectl get nodes`                                           |
| Ejemplo de URL servicio | `http://<node-ip>:30007`                                                        |
| Salidas de CLI          | Tener presente leer y traducir cualquier salida de comando durante la ejecución |

## Instrucciones

### Tarea 1: Crear un clúster de Kubernetes

1. **Usar Minikube:**
   
   - Verifica que Minikube y docker esté instalado correctamente.
   
   - Inicia Minikube con el comando:
     
     ```bash
     minikube start
     ```
   
   - Comprueba los nodos del clúster:
     
     ```bash
     kubectl get nodes
     ```

2. **Usar kubeadm:**
   
   - Inicializa el clúster en el nodo maestro con el siguiente comando:
     
     ```bash
     sudo kubeadm init --pod-network-cidr=10.244.0.0/16
     ```
   
   - Configura `kubectl` para el usuario no root:
     
     ```bash
     mkdir -p $HOME/.kube
     sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
     sudo chown $(id -u):$(id -g) $HOME/.kube/config
     ```

### Tarea 2: Añadir nodos al clúster

1. En cada nodo de trabajo, ejecuta el comando de unión proporcionado al inicializar el clúster con kubeadm:
   
   ```bash
   sudo kubeadm join <master-ip>:<master-port> --token <token> \
     --discovery-token-ca-cert-hash sha256:<hash>
   ```

### Tarea 3: Desplegar una aplicación en Kubernetes

1. **Crear un manifiesto de despliegue:**
   
   - Utiliza el siguiente manifiesto YAML para desplegar una aplicación NGINX:
     
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

2. **Aplicar el manifiesto:**
   
   ```bash
   kubectl apply -f nginx-deployment.yaml
   ```

### Tarea 4: Configurar un servicio para acceder a la aplicación

1. **Crear el manifiesto del servicio:**
   
   - Usa el siguiente manifiesto YAML para configurar un servicio NodePort:
     
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

2. **Aplicar el manifiesto:**
   
   ```bash
   kubectl apply -f nginx-service.yaml
   ```

3. Accede al servicio desde el navegador usando la IP del nodo y el puerto 30007.

### Tarea 5: Aplicar políticas de red básicas

1. **Crear el manifiesto de la política de red:**
   
   - Usa el siguiente manifiesto YAML:
     
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

2. **Aplicar el manifiesto:**
   
   ```bash
   kubectl apply -f network-policy.yaml
   ```

## Resultado esperado

Al finalizar esta práctica, los estudiantes habrán:

- Creado y configurado un clúster de Kubernetes.
- Desplegado aplicaciones en contenedores utilizando manifiestos YAML.
- Configurado servicios NodePort para exponer las aplicaciones.
- Implementado políticas de red para gestionar el tráfico entre Pods.

Esto permitirá comprender los conceptos fundamentales de la arquitectura de Kubernetes y su administración básica. Es importante aclararles que todos estos conceptos serán abordados en mayor profundidad a lo largo de cada hito del curso 🚀
