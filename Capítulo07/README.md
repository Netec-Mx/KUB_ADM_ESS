# Práctica 9. Implementación de una aplicación utilizando Helm

## Objetivo de la práctica:

Al finalizar esta práctica, serás capaz de:

- Implementar una aplicación utilizando Helm.
- Crear y personalizar un Chart para despliegue en Kubernetes.
- Optimizar la gestión de aplicaciones con Helm.

## Explicación:

Para visualizar y comprender mejor las actividades, se presentan los siguientes elementos descriptivos:

- Crear un **Chart de Helm** básico que implemente un contenedor **Nginx**.
- Personalizar valores en `values.yaml` para gestionar el despliegue.
- Realizar pruebas del despliegue y escalar la aplicación.

## Duración estimada:

- 55 minutos.

## Tabla de ayuda:

| Concepto       | Descripción                                                                            |
| -------------- | -------------------------------------------------------------------------------------- |
| Helm           | Herramienta de Kubernetes para gestionar paquetes de aplicaciones (Charts).            |
| Chart          | Paquete Helm que contiene todos los recursos necesarios para desplegar una aplicación. |
| Comando `helm` | Herramienta de línea de comandos para gestionar Charts.                                |
| `values.yaml`  | Archivo de configuración donde se definen los valores por defecto para un Chart.       |
| Clúster        | Conjunto de nodos que ejecutan aplicaciones en Kubernetes.                             |

## Instrucciones:

### Tarea 1. Crear un Chart de Helm básico.

Paso 1. Crea un nuevo Chart llamado `nginx-chart`:

```bash
helm create nginx-chart
```

Paso 2. Explora el contenido generado:

- `Chart.yaml`: Contiene la información del Chart.
- `values.yaml`: Permite configurar los valores por defecto.
- `templates/`: Contiene los manifiestos YAML para los recursos.

Paso 3. Modifica el archivo `values.yaml` para personalizar la imagen:

```yaml
image:
  repository: nginx
  tag: latest
  pullPolicy: IfNotPresent
```

### Tarea 2. Desplegar la aplicación con Helm.

Paso 1. Instala el Chart en el clúster:

```bash
helm install nginx-release ./nginx-chart
```

Paso 2. Verifica los recursos desplegados:

```bash
kubectl get all
```

Paso 3. Accede a la aplicación:

1. Obtén el servicio creado:
  
  ```bash
  kubectl get svc
  ```

2. Accede a través del puerto asignado.

### Tarea 3. Personalizar y escalar la aplicación.

Paso 1. Edita el archivo `values.yaml` para cambiar el número de réplicas:

```yaml
replicaCount: 3
```

Paso 2. Actualiza el despliegue:

```bash
helm upgrade nginx-release ./nginx-chart
```

Paso 3. Verifica los Pods creados:

```bash
kubectl get pods -o wide
```

## Resultado esperado:

Al finalizar esta práctica, deberías haber:

- Implementado una aplicación utilizando Helm con un Chart básico.
- Personalizado los valores del Chart para adaptar el despliegue a tus necesidades.
- Escalado la aplicación de manera efectiva.

## Resumen de los pasos

1. **Creación del Chart**:
   - Generar la estructura básica del Chart con `helm create`.
   - Configurar valores en `values.yaml`.
2. **Despliegue y personalización**:
   - Instalar el Chart con `helm install`.
   - Acceder y verificar la aplicación desplegada.
3. **Escalabilidad**:
   - Editar valores y actualizar el despliegue con `helm upgrade`.

---

Nota: Se recomienda para mayores habilidades y capacidades resolutivas, consulta la documentación oficial de Kubernetes o Helm.
