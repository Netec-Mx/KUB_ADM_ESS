# Práctica 17. Implementación de alta disponibilidad en Kubernetes

## Objetivo de la práctica:

Al finalizar la práctica, serás capaz de:

- Configurar y probar soluciones de alta disponibilidad en un clúster de Kubernetes.
- Implementar una base de datos apilada (Stacked Database) y una base de datos externa (External Database) en Kubernetes.
- Verificar la conectividad y realizar pruebas de rendimiento, fallo y recuperación en el sistema.

## Duración aproximada:

- 120 minutos.

## Tabla de ayuda:

| Elemento                   | Descripción                                                                                                                                                                        |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **IP de nodos**            | Direcciones IP de los nodos del clúster donde se realizarán las configuraciones. Es importante asegurarse de que las IPs sean correctas para las conexiones entre los componentes. |
| **Versión de etcd**        | Asegúrate de utilizar la versión correcta de etcd que sea compatible con la versión de Kubernetes que estés utilizando.                                                            |
| **Credenciales de acceso** | Si se requiere autenticación para acceder a los nodos o bases de datos, ten a la mano las credenciales correspondientes.                                                           |
| **Configuración de red**   | Verifica que las configuraciones de red, como puertos y reglas de firewall, sean correctas para permitir la comunicación entre los nodos y los componentes de Kubernetes.          |

---

## Instrucciones:

### Tarea 1. Configuración de Stacked Database.

Paso 1. Instala etcd en los mismos nodos que otros componentes de Kubernetes.

- Descarga e instala etcd en los nodos seleccionados del clúster.

Paso 2. Configura el archivo de configuración de etcd para los nodos del clúster.

```bash
etcd --name infra0 --data-dir /var/lib/etcd --initial-advertise-peer-urls http://<ip-0>:2380 \
--listen-peer-urls http://<ip-0>:2380 --listen-client-urls http://<ip-0>:2379 \
--advertise-client-urls http://<ip-0>:2379 --initial-cluster-token etcd-cluster-1 \
--initial-cluster infra0=http://<ip-0>:2380,infra1=http://<ip-1>:2380,infra2=http://<ip-2>:2380 \
--initial-cluster-state new
```

**Explicación**: Este comando configura un etcd de ejemplo en un nodo específico, definiendo sus puertos de comunicación con otros nodos en el clúster. Es fundamental asegurar que las IPs de los nodos sean correctas y validar los parametros del comando de acuerdo a tu entorno y la versión de k8s.

Paso 3. Verifica que la configuración sea exitosa.

```bash
etcdctl cluster-health
```

---

### Tarea 2. Implementación de External Database.

Paso 1. Despliega etcd en nodos dedicados fuera del clúster principal.

- Utiliza nodos dedicados que no forman parte de los nodos principales del clúster de Kubernetes para instalar etcd.

Paso 2. Configura la conectividad entre los nodos y la red para asegurar la comunicación entre etcd y los componentes de Kubernetes.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: etcd-config
data:
  etcd.conf: |
    name: infra0
    data-dir: /var/lib/etcd
    listen-peer-urls: http://<external-ip-0>:2380
    listen-client-urls: http://<external-ip-0>:2379
    initial-advertise-peer-urls: http://<external-ip-0>:2380
    advertise-client-urls: http://<external-ip-0>:2379
    initial-cluster: infra0=http://<external-ip-0>:2380,infra1=http://<external-ip-1>:2380,infra2=http://<external-ip-2>:2380
    initial-cluster-state: new
```

**Explicación**: En este caso, los nodos etcd están fuera del clúster principal de Kubernetes. Asegúrate de que las IPs externas sean accesibles y configuradas correctamente.

Paso 3. Verifica la conectividad y configuración de los nodos etcd.

```bash
etcdctl cluster-health
```

---

### Verificación y pruebas:

- **Verificar la conectividad**: Asegúrate de que todos los componentes de Kubernetes (API Server, Controller Manager, Scheduler) puedan conectarse correctamente con etcd.
- **Pruebas de incidencias y recuperación**: Simula un fallo en uno de los nodos etcd y verifica que el sistema sea capaz de recuperarse automáticamente y mantener la alta disponibilidad.
- **Monitorear el estado**: Usa herramientas como `etcdctl` o dashboards de Kubernetes para monitorear el estado de la base de datos y hacer ajustes si es necesario.

---

### Resultado esperado:

Al finalizar la práctica, habrás configurado una Stacked Database y una External Database en Kubernetes, logrando que el sistema mantenga alta disponibilidad y un rendimiento óptimo en diferentes escenarios.

---

**Aclaraciones adicionales**:

- **etcd**: Es un sistema de almacenamiento clave-valor distribuido que Kubernetes utiliza para almacenar su configuración y estado. Una configuración adecuada y un monitoreo constante de etcd es clave para mantener la disponibilidad de tu clúster.
- **Clúster de Kubernetes**: Asegúrate de que todos los nodos en el clúster tengan la conectividad adecuada entre ellos para una operación eficiente. El rendimiento y la disponibilidad de Kubernetes dependen directamente de la configuración de su base de datos etcd.
