# Práctica 10. Implementación de volúmenes persistentes

## Objetivo de la práctica:

Al finalizar la práctica, serás capaz de:

- Configurar PersistentVolumes y PersistentVolumeClaims en Kubernetes.
- Desplegar Pods que usen almacenamiento persistente.
- Utilizar ConfigMaps para gestionar configuraciones en Kubernetes.

## Objetivo visual:

A continuación, se muestra un resumen textual y estructurado de las actividades a realizar:

1. **Crear y aplicar un PersistentVolume (PV):**
   
   - Definir un archivo YAML para describir el PV.
   - Aplicar el archivo YAML usando `kubectl`.

2. **Crear y aplicar un PersistentVolumeClaim (PVC):**
   
   - Definir un archivo YAML para describir el PVC.
   - Vincular el PVC con el PV mediante configuraciones compatibles.

3. **Desplegar un Pod que utilice almacenamiento persistente:**
   
   - Configurar un Pod en YAML, especificando el PVC como volumen.
   - Verificar el correcto funcionamiento del Pod.

4. **Modificar el Pod para utilizar un ConfigMap:**
   
   - Crear un ConfigMap y asignarlo al Pod.
   - Verificar el acceso a las configuraciones desde el contenedor.

## Duración estimada:

- 60 minutos.

## Tabla de ayuda:

| Elemento                              | Detalle                                                                                                 |
| ------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| **Herramienta de línea de comandos**  | `kubectl`                                                                                               |
| **Requisitos previos**                | Acceso a un clúster Kubernetes funcional. Conocimiento básico de YAML.                                  |
| **Directorio de trabajo recomendado** | Utilizar `/mnt/data` para PV. Asegúrate de que exista y sea accesible en el nodo donde se creará el PV. |
| **Conceptos básicos**                 | - **PersistentVolume (PV):** Almacenamiento configurado por el administrador del clúster.               |
|                                       | - **PersistentVolumeClaim (PVC):** Solicitud de almacenamiento realizada por el usuario.                |
|                                       | - **ConfigMap:** Método para inyectar configuraciones en aplicaciones contenidas en Pods.               |

---

## Instrucciones:

### **Tarea 1. Configurar un PersistentVolume (PV).**

Paso 1. Crea un archivo llamado `persistent-volume.yaml` con el siguiente contenido:
   
   ```yaml
   apiVersion: v1
   kind: PersistentVolume
   metadata:
     name: pv0001
   spec:
     capacity:
       storage: 5Gi
     accessModes:
       - ReadWriteOnce
     persistentVolumeReclaimPolicy: Retain
     storageClassName: manual
     hostPath:
       path: "/mnt/data"
   ```

Paso 2. Aplica el archivo con el comando:
   
   ```bash
   kubectl apply -f persistent-volume.yaml
   ```

Paso 3. Verifica que el PV se haya creado correctamente:
   
   ```bash
   kubectl get pv
   ```

### **Tarea 2. Configurar un PersistentVolumeClaim (PVC)**.

Paso 1. Crea un archivo llamado `persistent-volume-claim.yaml` con el siguiente contenido:
   
   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: pvc0001
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 5Gi
     storageClassName: manual
   ```

Paso 2. Aplica el archivo con el comando:
   
   ```bash
   kubectl apply -f persistent-volume-claim.yaml
   ```

Paso 3. Verifica que el PVC se haya vinculado al PV:
   
   ```bash
   kubectl get pvc
   ```

### **Tarea 3. Desplegar un Pod que utilice almacenamiento persistente**

Paso 1. Crea un archivo llamado `nginx-pod-pvc.yaml` con el siguiente contenido:
   
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: nginx-pod
   spec:
     containers:
     - name: nginx
       image: nginx:latest
       volumeMounts:
       - mountPath: "/usr/share/nginx/html"
         name: storage
     volumes:
     - name: storage
       persistentVolumeClaim:
         claimName: pvc0001
   ```

Paso 2. Aplica el archivo con el comando:
   
   ```bash
   kubectl apply -f nginx-pod-pvc.yaml
   ```

Paso 3. Verifica que el Pod esté en ejecución:
   
   ```bash
   kubectl get pods
   ```

Paso 4. Accede al Pod y verifica el montaje del volumen:
   
   ```bash
   kubectl exec -it nginx-pod -- /bin/sh
   ```
   
Paso 5. Dentro del shell del contenedor, navega al directorio `/usr/share/nginx/html` y lista los archivos:
   
   ```bash
   cd /usr/share/nginx/html
   ls -l
   ```

### **Tarea 4. Incorporar un ConfigMap al Pod**.

Paso 1. Crea un ConfigMap que contenga configuraciones específicas:
   
   ```bash
   kubectl create configmap nginx-config --from-literal=index.html="<h1>¡Hola, Kubernetes!</h1>"
   ```

Paso 2. Modifica el archivo del Pod para incluir el ConfigMap como un volumen adicional. Guarda el archivo como `nginx-pod-pvc-configmap.yaml`:
   
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: nginx-pod
   spec:
     containers:
     - name: nginx
       image: nginx:latest
       volumeMounts:
       - mountPath: "/usr/share/nginx/html"
         name: storage
       - mountPath: "/etc/nginx/conf.d"
         name: config-volume
         subPath: index.html
     volumes:
     - name: storage
       persistentVolumeClaim:
         claimName: pvc0001
     - name: config-volume
       configMap:
         name: nginx-config
   ```

Paso 3. Aplica el archivo actualizado:
   
   ```bash
   kubectl apply -f nginx-pod-pvc-configmap.yaml
   ```

Paso 4. Verifica que el ConfigMap se haya aplicado correctamente:
   
   ```bash
   kubectl exec -it nginx-pod -- /bin/sh
   ```
   
Paso 5. Revisa el contenido del directorio de configuraciones:
   
   ```bash
   ls /etc/nginx/conf.d
   ```

---

## Resultado esperado:

- El Pod debería estar configurado para usar almacenamiento persistente desde el PVC.
- La configuración del ConfigMap debería ser accesible dentro del contenedor.
- Los estudiantes comprenderán cómo vincular PersistentVolumes, PersistentVolumeClaims y ConfigMaps en Kubernetes para gestionar datos y configuraciones de manera eficiente.
