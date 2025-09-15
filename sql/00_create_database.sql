# Desarrollo de un Sistema de Gestión de Proyectos con CRUD, Funciones y Auditoría mediante Triggers en MySQL.

## 1. Procedimientos Almacenados (CRUD)  
Estos procedimientos almacenados fueron creados con el objetivo de realizar de forma controlada las operaciones de inserción, actualización, eliminación y consulta sobre las tablas principales de la base de datos.  

### 1.1. Procedimientos para la tabla DOCENTE  
En la tabla docente se implementaron cuatro procedimientos que permiten realizar las operaciones básicas de un CRUD (crear, leer, actualizar y eliminar).

- **InsertarDocente:** nos permitió registrar un nuevo docente en el sistema, almacenando su documento, nombres, título, años de experiencia, dirección y tipo de docente.  
- **ActualizarDocente:** nos permitió modificar los datos de un docente existente a partir de su identificador único `docente_id`.  
- **EliminarDocente:** con esta eliminamos definitivamente un docente de la base de datos.  
- **ListarDocentes:** devuelve todos los registros de docentes almacenados en la tabla.  

### 1.2. Procedimientos para la tabla PROYECTO  
En la tabla proyecto, relacionada con la de docentes, también se implementaron los cuatro procedimientos CRUD.

- **InsertarProyecto:** nos permitió insertar un nuevo proyecto, registrando su nombre, descripción, fechas de inicio y fin, presupuesto, horas estimadas y el docente jefe asignado.  
- **ActualizarProyecto:** Este nos permite modificar los datos de un proyecto a partir de su identificador `proyecto_id`.  
- **EliminarProyecto:** elimina de manera definitiva un proyecto de la base de datos.  
- **ListarProyectos:** recupera y muestra todos los proyectos registrados en la tabla.  

---

## 2. Función Definida por el Usuario  
Se implementó la función **PromedioExperienciaDocentes()**, cuyo propósito es calcular el promedio de años de experiencia de todos los docentes registrados en la base de datos.  

- Retorna un valor decimal con dos decimales de precisión.  
- Si no existen registros de experiencia, devuelve el valor 0.  
- Este cálculo es útil como indicador general del nivel de experiencia del cuerpo docente.  
De esta forma, la función ayuda a obtener rápidamente indicadores financieros sobre los recursos asignados a cada docente.
---

## 3. Disparadores (Triggers)  
Además de los procedimientos y la función, se crearon triggers que cumplen el papel de auditar los cambios en la tabla de docentes y tabla de proyecto,
para garantizar la trazabilidad de los datos y mantener un registro automático de todas las actualizaciones y eliminaciones realizadas en las tablas principales.  

### 3.1. Disparadores en la tabla DOCENTE  
- **tr_actualiza_docente:** se ejecuta después de cada actualización. Registra en la tabla de auditoría `copia_actualizados_tablauu` el estado anterior y el nuevo estado del docente en formato JSON.  
- **tr_elimina_docente:** se ejecuta antes de cada eliminación. Inserta en la tabla `copia_eliminados_tabladd` la información completa del docente eliminado.  

### 3.2. Disparadores en la tabla PROYECTO  
- **tr_actualiza_proyecto:** se ejecuta después de una actualización de un proyecto. Registra en la tabla `copia_actualizados_tablauu` los datos antiguos y los nuevos.  
- **tr_elimina_proyecto:** se ejecuta antes de una eliminación de proyecto. Inserta en la tabla `copia_eliminados_tabladd` los datos del proyecto eliminado.  

---

## 4. Tablas de Auditoría  
Se diseñaron dos tablas complementarias que almacenan la información histórica de las operaciones realizadas:  

- **copia_actualizados_tablauu:** guarda los registros de operaciones `UPDATE`, indicando la tabla de origen, el tipo de operación, la fecha y hora, así como los datos antiguos y los nuevos en formato JSON.  
- **copia_eliminados_tabladd:** almacena los registros eliminados mediante operaciones `DELETE`, preservando toda la información del dato eliminado.  

---

## 5. Restricciones e Integridad de Datos  
- Las tablas `docente` y `proyecto` cuentan con llaves primarias autoincrementales para asegurar la unicidad de sus registros.  
- En la tabla `docente`, el campo `numero_documento` fue definido como único, evitando duplicidades.  
- La tabla `proyecto` incluye la llave foránea `docente_id_jefe`, que garantiza que cada proyecto esté vinculado a un docente válido.  

---

## 6. Datos de Prueba  
Se insertaron registros de ejemplo para verificar el correcto funcionamiento de los procedimientos, funciones y triggers:  

- En la tabla **docente** se registraron varios docentes con diferentes títulos y años de experiencia.  
- En la tabla **proyecto** se insertaron proyectos con fechas, presupuestos y docentes responsables.  
- En las tablas de auditoría se evidencian operaciones de actualización y eliminación, confirmando que los disparadores funcionan correctamente y guardan los cambios en formato JSON.  

---

## Conclusión  
La base de datos `gestion_proyectos` se diseñó para administrar docentes y proyectos de manera eficiente mediante procedimientos almacenados (CRUD), una función para análisis estadístico y disparadores que permiten auditar automáticamente las operaciones realizadas. Esto garantiza integridad, trazabilidad y control sobre la información, proporcionando un sistema robusto y confiable.  

