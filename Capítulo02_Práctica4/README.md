# Práctica 4. Instalación del plano de control

## Objetivo de la práctica:

Al finalizar la práctica, serás capaz de:

- Instalar el nodo plano de control de Kubernetes.
- Configurar los servicios necesarios para el funcionamiento del clúster.
- Validar la correcta operación de los componentes del nodo maestro.

## Actividades a realizar:

A continuación, se presenta una guía esquemática de las actividades principales:

- Preparación del entorno.
  - Validación de la instalación de Docker.
  - Optimización de Ubuntu para Kubernetes.
- Instalación y configuración de Kubernetes.
  - Descarga e instalación de kubeadm, kubelet y kubectl.
  - Inicialización del nodo maestro.
- Verificación del estado del clúster.
  - Inspección de nodos y pods.

## Duración aproximada:

- 90 minutos.

## Guía de referencia rápida:

| Elemento                  | Descripción                                                                                                      |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| Docker                    | Sistema de contenedores utilizado para ejecutar servicios de Kubernetes.                                         |
| kubeadm, kubelet, kubectl | Herramientas esenciales para la administración y configuración del clúster Kubernetes.                           |
| Comandos importantes      | Lista de comandos proporcionados en esta práctica para guiar el proceso de instalación y validación.             |
| Recursos adicionales      | Documentación oficial de Docker y Kubernetes para ampliación: https://docs.docker.com/ y https://kubernetes.io/. |

## Instrucción:

### Tarea 1. Validar la instalación de Docker y los contenedores o mini-servidores.

Paso 1. Instala Docker y herramientas relacionadas:
   
   ```bash
   sudo apt install -y docker.io docker-compose-v2 ifupdown cgroupfs-mount debootstrap docker-doc cgroup-lite docker-buildx rinse zfsutils
   ```

Paso 2. Habilita y arranca el servicio Docker:
   
   ```bash
   sudo systemctl enable docker
   sudo systemctl start docker
   ```

Paso 3. Prueba la instalación con un contenedor de prueba:
   
   ```bash
   sudo docker run --name contenedor hello-world
   sudo docker rm -f contenedor
   sudo docker rmi hello-world
   ```

## Resultado esperado:

Podrás observar el mensaje: **"Hello from Docker!"**, lo que confirma que Docker está instalado y funcionando correctamente.

---

### Tarea 2. Optimizar Ubuntu para instalar Kubernetes

Paso 1. Cambia al entorno multiusuario:
   
   ```bash
   sudo systemctl set-default multi-user.target
   ```

Paso 2. Desactiva los servicios innecesarios en ubuntu:
   
   ```bash
   sudo systemctl disable sddm.service
   sudo systemctl stop bluetooth.service
   sudo systemctl disable bluetooth.service
   sudo systemctl disable cups.service
   sudo systemctl stop cups.service
   ```

Paso 3. Desactiva el uso de swap:
   
   ```bash
   sudo swapoff -a
   sudo sed -i 's/^.*swap.*$/#&/' /etc/fstab
   ```

Paso 4. Configura el kernel para Kubernetes:
   
   ```bash
   sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="[^"]*/& cgroup_enable=memory swapaccount=1"/' /etc/default/grub
   sudo update-grub
   ```

---

### Tarea 3. Instalar Kubernetes.

Paso 1. Instala las herramientas esenciales:
   
   ```bash
   sudo apt install -y apt-transport-https curl
   sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
   echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
   sudo apt update
   sudo apt install -y kubelet kubeadm kubectl
   sudo apt-mark hold kubelet kubeadm kubectl
   ```

Paso 2. Verifica las versiones instaladas:
   
   ```bash
   kubelet --version
   kubeadm version
   kubectl version --client
   ```

---

### Tarea 4. Inicializar el nodo maestro.

Paso 1. Ejecuta la inicialización del nodo maestro:
   
   ```bash
   sudo kubeadm init --pod-network-cidr=10.244.0.0/16
   ```

Paso 2. Copia y guarda el comando de unión que genera kubeadm.

---

### Paso 5. Verificar el estado del clúster.

Paso 1. Lista los nodos del clúster:
   
   ```bash
   kubectl get nodes
   ```

Paso 2. Inspecciona los pods:
   
   ```bash
   kubectl get pods --all-namespaces
   ```

## Resultado esperado:

- Nodo maestro inicializado correctamente.
- Listado de nodos y pods reflejando el estado operativo del clúster.
