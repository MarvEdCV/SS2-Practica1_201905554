use ss2_practica1

create table ciudad
(
    id_ciudad int identity
        constraint PK_ciudad
            primary key,
    nombre    varchar(150)
)


create table cliente
(
    id_cliente int identity
        constraint cliente_pk
            primary key,
    nombre     varchar(150),
    direccion  varchar(150)
)


create table empleado
(
    id_empleado int identity
        constraint empleado_pk
            primary key,
    nombre      varchar(150),
    puesto      varchar(150)
)


create table entregas_estado
(
    id_entregas_estado int identity
        constraint entregas_estado_pk
            primary key,
    nombre             varchar(150) not null
)


create table producto
(
    id_producto int identity
        constraint producto_pk
            primary key,
    nombre      varchar(150),
    descripcion varchar(150),
    peso        decimal(10,2),
    precio      decimal(10,2)
)


create table tiempo
(
    id_tiempo int identity
        constraint tiempo_pk
            primary key,
    dia       varchar(30),
    mes       varchar(30),
    anio      int
)

create table entregas
(
    id                 int identity
        constraint entregas_pk
            primary key,
    entrega_id         int not null,
    tiempo_entrega     int,
    costo              decimal(10,2),
    id_ciudad          int
        constraint entregas_ciudad_null_fk
            references ciudad,
    id_cliente         int
        constraint entregas_cliente_null_fk
            references cliente,
    id_empleado        int
        constraint entregas_empleado_null_fk
            references empleado,
    id_entregas_estado int
        constraint entregas_entregas_estado_null_fk
            references entregas_estado,
    id_producto        int
        constraint entregas_producto_null_fk
            references producto,
    id_tiempo          int
        constraint entregas_tiempo_null_fk
            references tiempo
)

create table temporal
(
    id_entrega              int,
    dia                     varchar(50),
    mes                     varchar(50),
    anio                    int,
    nombre_cliente          varchar(150),
    direccion               varchar(150),
    nombre_empleado_entrega varchar(150),
    puesto_empleado_entrega varchar(150),
    ciudad_entrega          varchar(70),
    nombre_producto         varchar(50),
    descripcion             varchar(150),
    peso                    decimal(10,2),
    tiempo_entrega          int,
    estado_entrega          varchar(150),
    costo_envio             decimal(10,2),
    precio_producto         decimal(10,2)
)