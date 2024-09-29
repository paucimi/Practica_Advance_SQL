# Práctica Advanced SQL: Análisis de Datos de Keepcoding

## Descripción del Proyecto

El objetivo de este proyecto es desarrollar un sistema de gestión de datos para Keepcoding, una plataforma de educación en línea. El proyecto se centra en el análisis de datos de llamadas de atención al cliente, utilizando técnicas avanzadas de SQL para extraer insights valiosos de los datos.

## Instalación

### Requisitos
- PostgreSQL como gestor de base de datos.
- Un entorno de desarrollo integrado (IDE) como pgAdmin o DBeaver.
- Los archivos de datos proporcionados (ivr_calls, ivr_modules, ivr_steps).

### Guía de Uso

1. **Crear la base de datos**:
   - Ejecuta el script de creación de la base de datos (`create_database.sql`) en tu gestor de base de datos.
   - Importa los archivos de datos proporcionados en la base de datos creada.

2. **Crear la tabla `ivr_detail`**:
   - Ejecuta el script de creación de la tabla `ivr_detail` (`create_ivr_detail.sql`) en tu gestor de base de datos.
   - Verifica que la tabla se haya creado correctamente y contiene los campos solicitados.

3. **Generar campos adicionales**:
   - Ejecuta los scripts de generación de campos adicionales (`generate_vdn_aggregation.sql`, `generate_document_type.sql`, etc.) en tu gestor de base de datos.
   - Verifica que los campos se hayan generado correctamente y se encuentren en la tabla `ivr_detail`.

4. **Crear la tabla `ivr_summary`**:
   - Ejecuta el script de creación de la tabla `ivr_summary` (`create_ivr_summary.sql`) en tu gestor de base de datos.
   - Verifica que la tabla se haya creado correctamente y contiene los campos solicitados.

5. **Uso de la función de limpieza de enteros**:
   - Ejecuta el script de creación de la función de limpieza de enteros (`create_clean_integer_function.sql`) en tu gestor de base de datos.
   - Utiliza la función en tus consultas para limpiar valores nulos y reemplazarlos por `-999999`.

## Guía de Contribución

### Código de Conducta
- Utiliza un estilo de código claro y conciso.
- Comenta tu código para que sea fácil de entender.
- Utiliza nombres de variables y funciones descriptivos.

### Reportar Bugs
1. Abre un issue en este repositorio con una descripción detallada del bug.
2. Proporciona un ejemplo de código que reproduzca el bug.

### Contribuir con Código
1. Haz un fork de este repositorio.
2. Realiza tus cambios en una rama separada.
3. Haz un pull request con tus cambios.

## Recursos Adicionales
- [Documentación de PostgreSQL](https://www.postgresql.org/docs/)
- [Documentación de SQL](https://www.w3schools.com/sql/)
