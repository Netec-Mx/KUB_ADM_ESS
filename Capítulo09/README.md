# Práctica 11. Configuración y acceso a servicios en Kubernetes

## Objetivo de la práctica:

Al finalizar la práctica, serás capaz de:

- Configurar servicios en Kubernetes para diferentes niveles de acceso.
- Comprender el propósito de los servicios ClusterIP, NodePort y LoadBalancer.
- Validar la conectividad y funcionalidad de los servicios configurados.

## Explicación:

A continuación, se presenta una representación textual del flujo de actividades:

- **Inicio:** Configuración inicial de un servicio ClusterIP.
  - Identificar el archivo YAML necesario.
  - Aplicar el archivo de configuración.
- **Intermedio:** Exposición de servicio NodePort.
  - Modificar el tipo de servicio en el YAML.
  - Asignar un puerto específico para acceso externo.
- **Final:** Configuración del servicio LoadBalancer.
  - Integrar el balanceador de carga en el clúster.
  - Validar accesos internos y externos.

| Actividad principal        | Paso clave             | Resultado esperado               |
| -------------------------- | ---------------------- | -------------------------------- |
| Configuración ClusterIP    | Aplicar YAML inicial   | Acceso interno funcional         |
| Exposición NodePort        | Asignar puerto externo | Acceso desde IP del nodo         |
| Configuración LoadBalancer | Integrar balanceador   | Acceso desde IP externa asignada |

## Duración estimada:

- 60 minutos.

## Tabla de ayuda:

Esta sección proporciona información adicional que será útil durante el laboratorio:

| Concepto clave             | Detalle                                                                |
| -------------------------- | ---------------------------------------------------------------------- |
| Direcciones IP disponibles | Verifica las IPs asignadas por tu entorno (Minikube, EKS, GKE, etc.).  |
| Herramientas necesarias    | `kubectl`, acceso al clúster, permisos administrativos.                |
| Credenciales necesarias    | Acceso como administrador al clúster para aplicar configuraciones.     |
| Configuración previa       | Asegúrate de que tu clúster tiene nodos listos y recursos suficientes. |

## Instrucciones:

### Tarea 1. Configurar un servicio ClusterIP.

Paso 1. Crear el archivo YAML con la siguiente configuración:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: MyApp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9376
```

Paso 2. Aplicar el archivo YAML:
   
   ```bash
   kubectl apply -f my-service-clusterip.yaml
   ```
Paso 3. Verificar la creación del servicio:
   
   ```bash
   kubectl get services
   ```

### Tarea 2. Exponer el servicio como NodePort.

Paso 1. Modificar el archivo YAML para incluir el tipo `NodePort`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: NodePort
  selector:
    app: MyApp
  ports:
    - port: 80
      targetPort: 9376
      nodePort: 30007
```

Paso 2. Aplicar el archivo YAML:
   
   ```bash
   kubectl apply -f my-service-nodeport.yaml
   ```
Paso 3. Probar el acceso desde la IP de un nodo:
   
   ```bash
   curl http://<node-ip>:30007
   ```

### Tarea 3. Configurar un servicio LoadBalancer.

Paso 1. Modificar el archivo YAML para incluir el tipo `LoadBalancer`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: LoadBalancer
  selector:
    app: MyApp
  ports:
    - port: 80
      targetPort: 9376
```

Paso 2. Aplicar el archivo YAML:
   
   ```bash
   kubectl apply -f my-service-loadbalancer.yaml
   ```
Paso 3. Verificar la IP asignada al balanceador de carga:
   
   ```bash
   kubectl get services
   ```
Paso 4. Probar el acceso desde la IP externa asignada:
   
   ```bash
   curl http://<external-ip>
   ```

### Resultado esperado:

Al finalizar la práctica, debes haber logrado:

- Configurar y validar un servicio ClusterIP, accesible dentro del clúster.
- Configurar y validar un servicio NodePort, accesible desde la IP del nodo y puerto especificado.
- Configurar y validar un servicio LoadBalancer, accesible desde una IP externa asignada.

## Notas adicionales:

- Asegúrate de eliminar los servicios creados después de la práctica si ya no son necesarios:
  
  ```bash
  kubectl delete service my-service
  ```
- Consulta la documentación oficial de Kubernetes para detalles adicionales: [https://kubernetes.io/docs/concepts/services-networking/service/](https://kubernetes.io/docs/concepts/services-networking/service/).
