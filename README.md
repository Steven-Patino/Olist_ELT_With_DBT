# 🛒 Olist ELT con dbt

![Python](https://img.shields.io/badge/Python-3.13+-3776AB?style=for-the-badge&logo=python&logoColor=white)
![dbt](https://img.shields.io/badge/dbt-Core-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Marts%20Ready-2EA44F?style=for-the-badge)

Este proyecto implementa un pipeline de Extracción, Carga y Transformación (ELT) para el dataset de e-commerce brasileño **Olist**, utilizando **dbt (data build tool)** para la orquestación y transformación de datos dentro del almacén. El objetivo principal es transformar los datos crudos en un modelo de datos analítico (Modelo Estrella) optimizado para Business Intelligence y análisis avanzado.

## 🎯 Origen y Hoja de Ruta
Este proyecto parte de solucionar las problemáticas planteadas en el siguiente desafío técnico: [Gist de Janner-GP](https://gist.github.com/Janner-GP/f8bb21bbcbce766bf27b084dcf0b2f40).

La ruta de desarrollo seguida es:

### 🔥 Parte 9 — Desafío adicional

**🚀 Nivel intermedio**
Construye nuevas tablas analíticas que permitan:
*   📅 Analizar ventas mensuales.
*   📈 Identificar crecimiento.
*   📉 Detectar tendencias.

**🚀 Nivel avanzado**
Construye tableros (**POWER BI**) que permitan:
*   🏆 Identificar mejores clientes por categoría.
*   🧠 Analizar comportamiento de compra.
*   📊 Comparar rendimiento entre productos.

---

## 📌 Estado Actual del Proyecto

| Fase | Estado | Descripción |
|---|---|---|
| ✅ **Ingesta de Datos (RAW)** | Completada | Carga inicial de archivos CSV a la base de datos PostgreSQL. |
| ✅ **Capa Staging** | Completada | Normalización y limpieza inicial de datos, conversión de tipos. |
| ✅ **Capa Intermediate** | Completada | Unificación y enriquecimiento de datos para construir la base del modelo estrella. |
| ✅ **Capa Marts** | Completada | Creación de tablas de hechos y dimensiones optimizadas para el consumo analítico. |
| ✅ **Pruebas de Calidad (dbt tests)** | Implementadas | Batería de tests automáticos para asegurar la integridad y calidad de los datos. |
| ✅ **Documentación** | En Curso | Documentación detallada de la arquitectura, modelos y procesos. |
| ✅ **Análisis Exploratorio de Datos (EDA)** | Completado | Informes de EDA para cada tabla fuente, identificando problemas y oportunidades. |

## 📊 Volumen de Datos Procesados

El proyecto procesa un volumen significativo de datos transaccionales de Olist. A modo de referencia, la tabla principal de órdenes (`raw.orders`) contiene aproximadamente **99,441 registros**, los cuales son enriquecidos y transformados a lo largo del pipeline.

## 🧰 Requisitos del Sistema

-   **Python 3.13+**: Lenguaje de programación principal.
-   **uv**: Gestor de paquetes de Python (alternativa a `pip`).
-   **PostgreSQL**: Base de datos relacional para almacenar los datos.
-   **dbt Core**: Herramienta de transformación de datos.
-   **dbt-postgres**: Adaptador de dbt para PostgreSQL.
-   **Espacio en disco**: Suficiente para la base de datos PostgreSQL.

Las dependencias de Python se gestionan a través de `pyproject.toml` y se instalan con `uv sync`.

## 📦 Dependencias Clave

Este proyecto utiliza las siguientes librerías de Python para su funcionamiento:

-   `dbt-core>=1.11.9`: El motor principal de dbt para la gestión de transformaciones.
-   `dbt-postgres>=1.10.0`: Conector de dbt para bases de datos PostgreSQL.
-   `pandas>=3.0.3`: Utilizado en el script de carga inicial (`load_raw.py`) para la manipulación de DataFrames.
-   `psycopg2-binary>=2.9.12`: Adaptador de PostgreSQL para Python.
-   `python-dotenv>=1.2.2`: Para la gestión segura de variables de entorno (credenciales de base de datos).
-   `sqlalchemy>=2.0.49`: Toolkit SQL y ORM para Python, utilizado en la conexión a la base de datos.

## 🚀 Instalación y Configuración

### 1. Clonar el Repositorio

```bash
git clone https://github.com/Steven-Patino/olist_etl_with_dbt.git
cd olist_etl_with_dbt
```

### 2. Instalar `uv` (si no está instalado)

**En Windows (PowerShell):**
```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

**En Linux/macOS (Bash):**
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### 3. Instalar Dependencias del Proyecto

```bash
uv sync
```

### 4. Configurar Variables de Entorno

Copia el archivo de ejemplo `.env.example` y renómbralo a `.env`. Luego, edita el archivo `.env` con tus credenciales de base de datos PostgreSQL.

```bash
cp .env.example .env # En Linux/macOS
Copy-Item .env.example .env # En Windows
```

**Contenido de `.env` (ejemplo):**
```env
DB_USER=your_user
DB_PASSWORD=your_password
DB_HOST=localhost
DB_PORT=5432
DB_NAME=olist_db
```

### 5. Cargar Datos Crudos

Asegúrate de que los archivos CSV de Olist estén ubicados en la carpeta `./data/`. Luego, ejecuta el script de carga:

```bash
uv run python load_raw.py
```

### 6. Ejecutar el Pipeline dbt

```bash
dbt debug # Para verificar la conexión a la base de datos
dbt seed # Carga de archivos estáticos o mappings
dbt run # Para ejecutar todos los modelos (staging, intermediate, marts)
dbt test # Para ejecutar todas las pruebas de calidad de datos
dbt docs generate # Para generar la documentación del proyecto dbt
dbt docs serve # Para visualizar la documentación generada en tu navegador
```

## ⚙️ Estructura del Proyecto

```
olist_etl_with_dbt/
├── data/                       # Archivos CSV de datos crudos de Olist
├── eda/                        # Informes de Análisis Exploratorio de Datos (EDA)
│   └── docs/                   # Documentos Markdown de EDA
├── general_docs/               # Documentación centralizada del proyecto (nueva ubicación)
│   ├── data_dictionary.md      # Diccionario de datos
│   ├── data_sources.md         # Fuentes de datos
│   └── intermediate_layer.md   # Estrategia de la capa Intermediate
├── olist_elt/                  # Proyecto dbt
│   ├── models/                 # Modelos dbt (staging, intermediate, marts)
│   │   ├── intermediate/
│   │   ├── marts/
│   │   └── staging/
│   ├── tests/                  # Tests dbt
│   └── dbt_project.yml         # Configuración del proyecto dbt
├── questions to answer/        # Reportes y análisis de negocio
│   └── from_report.md          # Reporte final de análisis de negocio
├── load_raw.py                 # Script para cargar datos CSV a la capa RAW de PostgreSQL
├── pyproject.toml              # Definición de dependencias de Python (uv)
├── README.md                   # Este documento
└── .env.example                # Plantilla para variables de entorno
```

## 📚 Documentación Adicional

La documentación detallada de la arquitectura, los modelos de datos y los hallazgos de EDA se encuentra en las siguientes ubicaciones:

-   **Documentación General:** `general_docs/`
-   **Informes EDA:** `eda/docs/`
-   **Reportes de Negocio:** `questions to answer/`

## 👨‍💻 Autor

**Steven Alexander Patino Arenas**  
Proyecto Final de Análisis de Datos, Mayo 2026.

---
