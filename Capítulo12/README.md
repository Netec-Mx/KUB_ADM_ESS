# Práctica 14. Implementación de monitoreo y logging

## Objetivo de la práctica:

Al finalizar la práctica, serás capaz de:

- Configurar herramientas de monitoreo en un clúster de Kubernetes utilizando Prometheus y Grafana.
- Implementar Fluentd para la captura y distribución de logs en Kubernetes.
- Verificar la integración de Prometheus, Grafana y Fluentd, asegurando que funcionen correctamente.

## Explicación:

Para la comprensión del proceso de implementación y monitoreo, se crea el siguiente diagrama detallado que resuma las actividades:

1. Instalación de Prometheus y Grafana.
2. Configuración de Prometheus y sus alertas.
3. Creación de dashboards en Grafana.
4. Instalación y configuración de Fluentd.
5. Verificación de la integración entre las herramientas.

## Duración aproximada:

- 60 minutos.

## Tabla de ayuda:

| Elemento             | Descripción                                                                                                                                                                     |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Software**         | Helm, Prometheus, Grafana, Fluentd                                                                                                                                              |
| **IP del servidor**  | `192.168.1.100` (modificar según sea necesario)                                                                                                                                 |
| **Credenciales**     | Usuario: `admin`, Contraseña: `admin123` (modificar según sea necesario)                                                                                                        |
| **Repositorio Helm** | Para instalar Prometheus, Grafana y Fluentd, asegúrate de tener configurado el repositorio de Helm. Puedes agregarlo con: `helm repo add stable https://charts.helm.sh/stable`. |

## Instrucciones:

### Tarea 1. Instalación de Prometheus y Grafana.

Paso 1. **Instala Prometheus**: Ejecuta el siguiente comando para instalar Prometheus en tu clúster de Kubernetes (validarlo frente a la web oficial de prometheus en vista que el comando o la instalación puede cambiar):
   
   ```bash
   helm install prometheus stable/prometheus
   ```

Paso 2. **Instalar Grafana**: Ejecuta el siguiente comando para instalar Grafana en tu clúster de Kubernetes:
   
   ```bash
   helm install grafana stable/grafana
   ```

### Tarea 2. Configuración de Prometheus.

Paso 1. **Configurar Targets y Endpoints**:
   
1. Accede al archivo `prometheus.yml` en el directorio de configuración de Prometheus.
2. Define los targets y endpoints que Prometheus utilizará para recolectar métricas. Asegúrate de que los endpoints sean accesibles desde el clúster de Kubernetes.

Paso 2. **Configurar Alertas**:
   
1. Accede al archivo `alertmanager.yml` para definir las alertas que Prometheus debe manejar. Configura las condiciones de alerta según los valores de las métricas recolectadas.

### Tarea 3. Crear Dashboards en Grafana.

Paso 1. **Acceder al Panel de Grafana**:
   
1. Una vez que Grafana esté instalado, accede a su panel de administración usando la URL proporcionada por Helm o la IP del clúster.
2. Inicia sesión con el usuario y contraseña configurados durante la instalación de Grafana (por defecto: `admin` / `admin`).

Paso 2. **Crear y Personalizar Dashboards**:
   
1. En el panel de Grafana, selecciona "Crear un nuevo Dashboard".
2. Agrega paneles para visualizar las métricas de Prometheus, como uso de CPU, memoria y almacenamiento.

Paso 3. **Configurar Alertas en Grafana**:

1. Configura las alertas dentro de los dashboards para notificar sobre umbrales críticos.

### Tarea 4. Instalación y Configuración de Fluentd

Paso 1. **Instalar Fluentd**:

1. Ejecuta el siguiente comando para instalar Fluentd en el clúster de Kubernetes:
   
   ```bash
   helm install fluentd stable/fluentd
   ```

Paso 2. **Configurar Inputs**:
   
1. Modifica el archivo `fluent.conf` para definir los inputs que Fluentd utilizará para recolectar logs desde los nodos de Kubernetes.

Paso 3. **Configurar Outputs a Elasticsearch**:
   
1. Configura los outputs para enviar los logs recolectados a un servidor Elasticsearch. Asegúrate de que Elasticsearch esté correctamente instalado y accesible desde Fluentd.

### Tarea 5. Verificación de la Integración.

Paso 1. **Verificar Métricas en Prometheus**:
   
1. Asegúrate de que Prometheus esté recolectando métricas correctamente ejecutando el comando:
     
```bash
kubectl port-forward svc/prometheus-server 9090:80
```
     
2. Accede a `http://localhost:9090` y verifica que las métricas de los servicios estén siendo recolectadas.

Paso 2. **Confirmar Dashboards de Grafana**:
   
1. Accede a Grafana y confirma que los dashboards muestren datos precisos sobre el estado de los servicios monitorizados.

Paso 3. **Verificar Logs en Fluentd**:

1. Accede a Elasticsearch para confirmar que Fluentd está enviando correctamente los logs. Puedes usar Kibana si está configurado para visualizar los logs.

## Resultado esperado:

Al finalizar la práctica, los estudiantes habrán instalado y configurado las herramientas de monitoreo y logging en un clúster de Kubernetes. Los resultados esperados incluyen:

1. **Prometheus** recolectando métricas del clúster de Kubernetes.
2. **Grafana** mostrando dashboards personalizados con las métricas recolectadas.
3. **Fluentd** recolectando y enviando logs a Elasticsearch para su posterior análisis.
