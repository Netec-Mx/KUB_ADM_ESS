#!/bin/bash

# Paso 1: Revisar la solicitud
echo "Revisando la solicitud de cambios..."
# Comando para obtener la lista de ramas remotas y las solicitudes de extracción (pull requests)
git fetch origin
echo "Ramas disponibles:"
git branch -r

# Paso 2: Verificar los comentarios (esto es manual, se debe hacer en GitHub directamente)
echo "Verifica los comentarios de la solicitud en GitHub antes de continuar."
read -p "Presiona Enter para continuar después de revisar los comentarios..."

# Paso 3: Probar los cambios
echo "Cambiando a la rama 'cap1' para probar los cambios..."
git checkout cap1
git pull origin cap1  # Obtener los cambios más recientes de la rama cap1

echo "Probando los cambios locales... (Asegúrate de probar tu aplicación aquí)"
# Aquí puedes ejecutar tus pruebas, por ejemplo:
# ./run_tests.sh
# Si necesitas ejecutar alguna prueba automática, agrégala aquí.

# Paso 4: Comentar y sugerir cambios (opcional)
echo "Si necesitas comentar o sugerir cambios adicionales, puedes hacerlo ahora."
echo "Para agregar comentarios en el código, realiza un commit si es necesario."

# Paso 5: Aceptar o rechazar la solicitud
read -p "¿Estás listo para fusionar la solicitud de cambios? (y/n): " answer
if [[ "$answer" == "y" ]]; then
    echo "Fusionando los cambios de 'cap1'..."
    git checkout main  # Asegúrate de estar en la rama principal
    git pull origin main  # Trae los últimos cambios de la rama principal
    git merge cap1  # Fusiona los cambios de cap1 en la rama principal

    echo "Pushing los cambios a GitHub..."
    git push origin main  # Empuja los cambios fusionados al repositorio remoto

    echo "Solicitud de cambios fusionada con éxito."
else
    echo "La solicitud de cambios no se ha fusionado. Revisa los cambios manualmente."
fi

# Fin del script
echo "Proceso completado. Revisa el estado de tu repositorio."
