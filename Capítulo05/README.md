# Práctica 7: Crear y configurar recursos API

## Objetivo de la práctica
Al finalizar esta práctica, serás capaz de:

- Implementar recursos API básicos en un clúster de Kubernetes.
- Configurar un Pod, un Servicio y políticas RBAC (Control de Acceso Basado en Roles).
- Verificar la correcta aplicación y funcionalidad de los recursos creados.

---

## Representación de las actividades

En esta sección se presenta un esquema textual que ilustra las actividades a realizar durante la práctica:

1. **Creación del Pod:**
   - Definir el manifiesto YAML para el Pod.
   - Aplicar el manifiesto para desplegar el Pod en Kubernetes.

2. **Exposición del Pod mediante un Servicio:**
   - Configurar un Servicio en YAML para exponer el Pod.
   - Aplicar el manifiesto del Servicio.

3. **Asignación de permisos RBAC:**
   - Crear un Role que otorgue permisos específicos.
   - Asignar el Role a un usuario mediante un RoleBinding.

4. **Verificación:**
   - Confirmar que los recursos se crearon y funcionan correctamente.
   - Validar permisos y accesos restringidos mediante comandos `kubectl`.

---

## Duración aproximada

- **60 minutos.**

---

## Guía de consulta para la práctica

Información clave para completar las tareas:

| Elemento            | Descripción                                                                                        |
|---------------------|----------------------------------------------------------------------------------------------------|
| **Clúster Kubernetes** | Asegúrate de tener acceso al clúster. Puedes usar Minikube, Kind u otro clúster disponible.       |
| **kubectl**         | La herramienta de línea de comandos para interactuar con Kubernetes. Confirma que está configurada.|
| **Manifiestos YAML** | Utiliza los ejemplos proporcionados para crear los recursos necesarios.                           |
| **Usuario "jane"**  | Usuario creado para la práctica. Asignaremos permisos RBAC específicos para este usuario.          |

---

## Instrucciones

### Tarea 1. Crear un Pod

1. Define un manifiesto YAML llamado `nginx-pod.yaml` con el siguiente contenido:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx-pod
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
    ```

2. Aplica el manifiesto YAML para crear el Pod en Kubernetes:

    ```bash
    kubectl apply -f nginx-pod.yaml
    ```

### Tarea 2. Crear un Servicio para exponer el Pod

1. Define un manifiesto YAML llamado `nginx-service.yaml` con el siguiente contenido:

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

2. Aplica el manifiesto YAML para crear el Servicio:

    ```bash
    kubectl apply -f nginx-service.yaml
    ```

### Tarea 3. Configurar permisos RBAC

1. Define un Role en un archivo YAML llamado `read-pods-role.yaml` con el siguiente contenido:

    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      namespace: default
      name: read-pods
    rules:
    - apiGroups: [""]
      resources: ["pods"]
      verbs: ["get", "watch", "list"]
    ```

2. Define un RoleBinding en un archivo YAML llamado `read-pods-rolebinding.yaml` con el siguiente contenido:

    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: read-pods-binding
      namespace: default
    subjects:
    - kind: User
      name: jane
      apiGroup: rbac.authorization.k8s.io
    roleRef:
      kind: Role
      name: read-pods
      apiGroup: rbac.authorization.k8s.io
    ```

3. Aplica los manifiestos YAML para crear el Role y el RoleBinding:

    ```bash
    kubectl apply -f read-pods-role.yaml
    kubectl apply -f read-pods-rolebinding.yaml
    ```

### Tarea 4. Verificación de la configuración

1. Verifica que el Pod y el Servicio estén configurados correctamente:

    ```bash
    kubectl get pods
    kubectl get svc
    ```

2. Valida los permisos del usuario `jane`:

    ```bash
    kubectl auth can-i get pods --as=jane
    ```

---

## Resultado esperado

Al finalizar esta práctica, deberás haber:

1. Desplegado un Pod llamado `nginx-pod` en Kubernetes.
2. Configurado un Servicio llamado `nginx-service` para exponer el Pod mediante un puerto NodePort.
3. Creado y aplicado permisos RBAC específicos para limitar el acceso al usuario `jane`.
4. Verificado que los recursos funcionan y los permisos están correctamente aplicados.

