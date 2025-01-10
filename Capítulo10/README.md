# Práctica 12. Configurar Ingress Controller y reglas de Ingress en Kubernetes

## Objetivo de la práctica:

Al finalizar esta práctica, serás capaz de:

- Configurar un Ingress Controller en Kubernetes.
- Definir reglas de Ingress para enrutar solicitudes a servicios backend.
- Gestionar el acceso externo a servicios dentro de un clúster Kubernetes.

## Explicación:

1. Instalar el Ingress Controller utilizando el manifiesto proporcionado.
2. Verificar la instalación del controlador con comandos `kubectl`.
3. Crear un despliegue y servicio de ejemplo.
4. Definir y aplicar un recurso Ingress con reglas específicas para enrutar el tráfico.
5. Configurar el archivo `hosts` local para pruebas.
6. Verificar el acceso al Ingress desde un navegador.

## Duración estimada

- 60 minutos.

## Tabla de ayuda:

| Elemento                 | Descripción                                                                                     |
| ------------------------ | ----------------------------------------------------------------------------------------------- |
| **Namespace Ingress**    | `ingress-nginx` (creado automáticamente durante la instalación).                                |
| **Recurso Ingress YAML** | El archivo debe llamarse `example-ingress.yaml`.                                                |
| **Archivo hosts local**  | Ubicación en Linux/Mac: `/etc/hosts`. En Windows: `C:\\Windows\\System32\\drivers\\etc\\hosts`. |
| **URL de prueba**        | `http://example.local`.                                                                         |

---

## Instrucciones:

### Tarea 1. Instalación del Ingress Controller.

Paso 1. Descarga e instala el controlador NGINX:
   
   ```shell
   kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
   ```

Paso 2. Verifica que los pods del controlador están en ejecución:
   
   ```shell
   kubectl get pods -n ingress-nginx --watch
   ```

### Tarea 2. Crear un servicio y despliegue de ejemplo.

Paso 1. Crear el archivo `example-deployment.yaml` con el siguiente contenido:
   
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: example-deployment
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: example
     template:
       metadata:
         labels:
           app: example
       spec:
         containers:
         - name: example
           image: nginx
           ports:
           - containerPort: 80
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: example-service
   spec:
     selector:
       app: example
     ports:
     - protocol: TCP
       port: 80
       targetPort: 80
   ```
Paso 2. Aplica el manifiesto al clúster:
   
   ```shell
   kubectl apply -f example-deployment.yaml
   ```

### Tarea 3. Crear y aplicar un recurso Ingress.

Paso 1. Crear el archivo *`example-ingress.yaml`* con el siguiente contenido:
   
   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: example-ingress
     annotations:
       nginx.ingress.kubernetes.io/rewrite-target: /
   spec:
     rules:
     - host: example.local
       http:
         paths:
         - path: /
           pathType: Prefix
           backend:
             service:
               name: example-service
               port:
                 number: 80
   ```
Paso 2. Aplica el recurso Ingress:
   
   ```shell
   kubectl apply -f example-ingress.yaml
   ```

### Tarea 4. Configurar el archivo hosts local.

Paso 1. Abre el archivo `hosts` en tu sistema operativo:**
   - En Linux/Mac: `/etc/hosts`.
   - En Windows: `C:\Windows\System32\drivers\etc\hosts`.
     
Paso 2. Agregar la siguiente entrada:
   
   ```
   127.0.0.1 example.local
   ```

### Tarea 5. Verificar el acceso.

Paso 1. Abrir un navegador web.

Paso 2. Navegar a `http://example.local`.

Paso 3. Confirmar que se muestra la página predeterminada de NGINX.

---

## Resultado esperado:

Al finalizar la práctica, deberías haber logrado:

- Configurar un Ingress Controller.
- Implementar reglas de Ingress para enrutar el tráfico.
- Acceder exitosamente al servicio backend a través de la URL `http://example.local`.

### Visualización esperada:

- La página predeterminada de NGINX debería mostrarse en el navegador tras completar los pasos correctamente.
1. **Ingress Controller:** Es un componente que gestiona el acceso externo a los servicios de Kubernetes basándose en reglas definidas en recursos Ingress.
2. **Reglas de Ingress:** Permiten enrutar el tráfico a servicios específicos dentro del clúster según el host o la URL.
3. **Archivo hosts:** Utilizado localmente para mapear nombres de dominio a direcciones IP, esencial en pruebas locales sin DNS.
4. **NGINX como controlador de Ingress:** Una de las implementaciones más populares, conocida por su flexibilidad y rendimiento.


