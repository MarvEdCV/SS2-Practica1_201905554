import pyodbc

# Configuración de la conexión a la base de datos
server = 'localhost'
database = 'ss2_practica1'
username = 'root'
password = 'admin'
conn_str = f'DRIVER=ODBC Driver 17 for SQL Server;SERVER={server};DATABASE={database};UID={username};PWD={password};CHARSET=UTF-8'

# Definir funciones para las operaciones

def borrar_modelo(cursor, conn):
    # Código SQL para borrar las tablas (excepto la tabla temporal)
    tables_to_delete = ["entregas", "ciudad", "cliente", "empleado", "entregas_estado", "producto", "tiempo", "temporal"]
    for table in tables_to_delete:
        cursor.execute(f"DROP TABLE IF EXISTS {table}")
    conn.commit()
    print("Modelo borrado exitosamente.")

def crear_modelo(cursor, conn):
    # Cargar el script SQL desde un archivo y ejecutarlo
    with open('creacion_modelo.sql', 'r') as file:
        sql_script = file.read()

    cursor.execute(sql_script)
    conn.commit()
    print("Modelo creado exitosamente.")

def extraer_informacion(cursor, conn, ruta_archivo):
    # Realizar una inserción masiva de datos desde un archivo CSV
    bulk_insert_query = f"""
    BULK INSERT temporal
    FROM '{ruta_archivo}'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ';',
        ROWTERMINATOR = '\\n',
        CODEPAGE = '65001' -- UTF-8
    )
    """

    cursor.execute(bulk_insert_query)
    conn.commit()
    print("Información extraída exitosamente.")

def cargar_informacion(cursor, conn):
    # Cargar información desde un archivo SQL y ejecutarlo
    with open('cargar_informacion.sql', 'r') as file:
        sql_script = file.read()
    cursor.execute(sql_script)
    conn.commit()
    print("Información cargada exitosamente.")

def realizar_consultas(cursor, conn):
    # Leer consultas desde un archivo y ejecutarlas
    with open('querys.sql', 'r') as file:
        queries = file.read().split(';')

    results = []

    for query in queries:
        if query.strip():  # Ignorar líneas vacías
            cursor.execute(query)
            result = cursor.fetchall()
            results.append(result)

    # Escribir resultados en un archivo de texto
    with open('resultados_consultas.txt', 'w', encoding='utf-8') as output_file:
        for i, result in enumerate(results):
            output_file.write(f"Consulta {i + 1}:\n")
            for row in result:
                row_str = ', '.join(map(str, row))
                output_file.write(row_str.encode('utf-8').decode('utf-8') + '\n')
            output_file.write('\n')

    print("Consultas realizadas y resultados guardados en resultados_consultas.txt.")

def main():
    # Establecer una conexión a la base de datos
    conn = pyodbc.connect(conn_str)
    cursor = conn.cursor()

    while True:
        # Menú de opciones
        print("Seleccione una opción:")
        print("a) Borrar modelo")
        print("b) Crear modelo")
        print("c) Extraer información")
        print("d) Cargar información")
        print("e) Realizar consultas")
        print("q) Salir")

        opcion = input("Opción: ")

        if opcion == 'a':
            borrar_modelo(cursor, conn)
        elif opcion == 'b':
            crear_modelo(cursor, conn)
        elif opcion == 'c':
            ruta_archivo = input("Ingrese la ruta del archivo CSV: ")
            extraer_informacion(cursor, conn, ruta_archivo)
        elif opcion == 'd':
            cargar_informacion(cursor, conn)
        elif opcion == 'e':
            realizar_consultas(cursor, conn)
        elif opcion == 'q':
            break
        else:
            print("Opción inválida.")

    # Cerrar la conexión
    cursor.close()
    conn.close()

if __name__ == "__main__":
    main()
