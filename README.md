# ![Logo](images/neteclogo.png) 

# Curso: Kubernetes Administration and Troubleshooting

## Descripción del curso: 

En este curso, aprenderá sobre la instalación de un clúster de Kubernetes de varios nodos con kubeadm, cómo hacer crecer un clúster, cómo elegir e implementar redes de clúster y varios métodos de administración del ciclo de vida de las aplicaciones, incluidos el escalado, las actualizaciones y las reversiones. El curso también cubre la configuración de la seguridad tanto para el clúster como para los contenedores, la administración del almacenamiento disponible para los contenedores, la supervisión, el registro y la resolución de problemas de los contenedores y el clúster, la configuración de la programación y la afinidad de las implementaciones de contenedores, el uso de Helm y Charts para automatizar la implementación de aplicaciones y la comprensión de la federación para la tolerancia a fallas y una mayor disponibilidad.


## Índice:

- [Práctica 1. Explorando Kubernetes.](./Capítulo01_Práctica1/README.md)
  - **Descripción**: Conocer el sitio oficial de Kubernetes.
  - ⏱️ **Duración estimada**: 25 minutos.
<br/>

- [Práctica 2. Repositorio oficial de Kubernetes.](./Capítulo1/README_1.2.md)
  - **Descripción**: Conocer el repositorio Git oficial de Kubernetes.
  - ⏱️ **Duración estimada**: 5 minutos.
<br/>

- [Práctica 3. Introducción y Configuración de Minikube para la Gestión de Clústeres Kubernetes Locales.](./Capítulo02_Práctica3/README.md)
  - **Descripción**: Conocer los aspectos generales de la instalación y utilización de Minikube.
  - ⏱️ **Duración estimada**: 27 minutos.
<br/>
 
- [Práctica 4. Instalación del plano de control.](./Capítulo02_Práctica4/README.md)
  - **Descripción**:  Instalar el nodo plano de control de Kubernetes.
  - ⏱️ **Duración estimada**: 5 minutos.
<br/>
  
- [Práctica 5. Implementación y gestión de un Pod en Kubernetes.](./Capítulo03/README.md)
  - **Descripción**:  Implementar y gestionar un Pod en Kubernetes desde la creación del clúster hasta la configuración de servicios y políticas de red.
  - ⏱️ **Duración estimada**: 25 minutos.
<br/>
 
- [Práctica 6. Configuración y gestión de Pod en Kubernetes.](./Capítulo04/README.md)
  - **Descripción**:  Aprender a interactuar con el clúster de Kubernetes utilizando herramientas como kubectl, creando y manipulando Pods, accediendo a sus logs y utilizando Annotations para agregar metadatos relevantes. 
 - ⏱️ **Duración estimada**: 42 minutos.
<br/>
 
- [Práctica 7. Crear y configurar recursos API.](./Capítulo05/README.md)
  - **Descripción**:  Implementar y gestionar recursos API básicos en un clúster de Kubernetes para comprender su estructura y funcionalidad, asegurando la correcta aplicación de políticas RBAC.
  - ⏱️ **Duración estimada**: 40 minutos.
<br/>
  
- [Práctica 8. Implementación de DaemonSets y uso de etiquetas.](./Capítulo06/README.md)
  - **Descripción**:  Aprender a implementar DaemonSets y utilizar etiquetas en Kubernetes para organizar y administrar Pods de manera eficiente.
  - ⏱️ **Duración estimada**: 40 minutos.
<br/>
 
- [Práctica 9. Implementación de una aplicación utilizando Helm.](./Capítulo07/README.md)
  - **Descripción**:  Implementar una aplicación utilizando Helm, incluyendo la creación, personalización y despliegue de un Chart para entender cómo Helm optimiza la gestión de aplicaciones en Kubernetes.
  - ⏱️ **Duración estimada**: 40 minutos.
<br/>
  
- [Práctica 10. Implementación de volúmenes persistentes.](./Capítulo08/README.md)
  - **Descripción**:  Configurar, desplegar y verificar el uso de diferentes tipos de volúmenes (hostPath, emptyDir, Persiolumes y ConfigMaps) en un clúster de Kubernetes.
  - ⏱️ **Duración estimada**: 70 minutos.
<br/>
  
- [Práctica 11. Configuración y acceso a servicios en Kubernetes.](./Capítulo09/README.md)
   - **Descripción**:  Configurar y acceder a diferentes tipos de servicios en Kubernetes, incluyendo Cluster IP, NodePort y LoadBalancer, con el fin de comprender cómo cada tipo de servicio se utiliza para distintos propósitos de acceso dentro y fuera del clúster.
   - ⏱️ **Duración estimada**: 130 minutos.
<br/>
  
- [Práctica 12. Configurar Ingress Controller y reglas de Ingress en Kubernetes.](./Capítulo10/README.md)
   - **Descripción**:  Configurar un Ingress Controller y definir reglas de Ingress en Kubernetes para gestionar el acceso externo a servicios dentro del clúster y entender como enrutar solicitudes a servicios blackend.
   - ⏱️ **Duración estimada**:  43 minutos.
<br/>
  
- [Práctica 13. Configuración y Gestión del Scheduler en Kubernetes.](./Capítulo11/README.md)
   - **Descripción**:  Configurar el Scheduler, especificar Pods, aplicar reglas de afinidad y gestionar taints y tolerations en un clúster de Kubernetes para optimizar la asignación de Pods y mantener la salud del clúster.
   - ⏱️ **Duración estimada**: 37 minutos.
<br/>

- [Práctica 14. Implementación de monitoreo y logging.](./Capítulo12/README.md)
   - **Descripción**:  Configurar herramientas de monitore y logging en un clúster de Kubernetes, implementando Prometheus, Grafana y Fluentd, verificando su correctar integración y funcionamiento.
   - ⏱️ **Duración estimada**: 41 minutos.
<br/>
  
- [Práctica 15. Implementando CRDs y Aggregated APIs.](./Capítulo13/README.md)
   - **Descripción**:  Implementar Custom Resourse Definitions (CRDs) y Aggregated APIs en un clúster de Kubernetes, extendiendo la funcionalidad del clúster con nuevos tipos de recursos y servicios.
   - ⏱️ **Duración estimada**: 33 minutos.
<br/>
  
- [Práctica 16. Implementación de seguridad en Kubernetes.](./Capítulo14/README.md)
   - **Descripción**:  Configurar medidas de seguridad en un clúster de Kubernetes, incluyendo acceso seguro a la API, autenticación y autorización, uso de Admission Controllers y políticas de red.
   - ⏱️ **Duración estimada**:  37 minutos.
<br/>
  
- [Práctica 17. Implementación de alta disponibilidad en Kubernetes](./Capítulo15/README.md)
   - **Descripción**:  Configurar y probar soluciones de alta disponibilidad en un clúster de Kubernetes.
   - ⏱️ **Duración estimada**:  146 minutos.
