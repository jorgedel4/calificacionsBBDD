drop database itcs;
create database itcs;
use itcs;

create table if not exists estudiantes(
    matricula char(9) not null,
    nombre varchar(30) not null,
    apellido varchar(20) not null,
    primary key(matricula)
);

insert into estudiantes 
values
    ('A01329173','Oscar', 'Barbosa'),
    ('A01329256','Antonio','Diaz'),
    ('A01328387','Miguel', 'Silva'),
    ('A01551525','Roberto', 'Betancourt'),
    ('A01329098','Diego', 'Perez'),
    ('A01329971','Luis Edgar', 'Flores');

create table if not exists preparatorias(
    id_preparatoria int not null,
    preparatoria char(3) not null,
    primary key(id_preparatoria)
);

insert into preparatorias values
    (1, 'EXT'),
    (2, 'PUE'),
    (3, 'CCV');

create table clases(
    id_clase int not null,
    clase varchar(255) not null,
    primary key(id_clase)
);

insert into clases
values
    (1,	'Estructura de datos'),
    (2,	'Proba'),
    (3,	'Bases de datos'),
    (4,	'Redes'),
    (5,	'Sistemas operativos'),
    (6,	'Análisis'),
    (7,	'Métodos');

create table periodos(
    id_periodo int not null,
    periodo char(4) not null,
    primary key(id_periodo)
);

insert into periodos
values
    (1,	'EM18'),
    (2,	'AD18'),
    (3,	'EM19');

create table maestros(
    id_maestro int not null,
    nombre_m varchar(30) not null,
    apellido_p varchar(20) not null,
    apellido_m varchar(20),
    primary key(id_maestro)
);

insert into maestros
values
    (1,	'Dan',	    'Pérez',    NULL),
    (2,	'Aida',	    'I',        NULL),
    (3,	'Gibran',   'S',        NULL),
    (4,	'Palomares','A',        NULL),
    (5,	'Claudia',	'Verónica',	'Perez'),
    (6,	'Alberto',	'Oliart',	NULL),
    (7,	'Sandra',	'Barajas',	NULL);

create table estudiantes_preparatorias(
    matricula char(9) not null,
    id_preparatoria int not null,
    primary key(matricula),
    foreign key(matricula) references estudiantes(matricula),
    foreign key(id_preparatoria) references preparatorias(id_preparatoria)
);

insert into estudiantes_preparatorias
values
    ('A01329173', 2),
    ('A01329256', 2),
    ('A01328387', 2),
    ('A01551525', 3),
    ('A01329098', 1),
    ('A01329971', 2);

create table grupos(
    id_grupo int not null,
    id_clase int not null,
    id_periodo int not null,
    id_maestro int not null,
    primary key (id_grupo),
    foreign key(id_clase) references clases(id_clase),
    foreign key(id_periodo) references periodos(id_periodo),
    foreign key(id_maestro) references maestros(id_maestro)
);

insert into grupos
values
    (401,	1,	2,	1),
    (402,	2,	1,	2),
    (403,	2,	2,	3),
    (404,	3,	3,	1),
    (405,	4,	1,	5),
    (406,	4,	2,	4),
    (407,	4,	3,	5),
    (408,	5,	1,	6),
    (409,	5,	2,	6),
    (410,	5,	3,	6),
    (411,	6,	3,	6),
    (412,	7,	3,	7);

create table calificaciones(
    matricula char(9) not null,
    id_grupo int not null,
    calificacion int,
    primary key(matricula, id_grupo),
    foreign key(matricula) references estudiantes(matricula),
    foreign key(id_grupo) references grupos(id_grupo)
);

insert into calificaciones
values
    ('A01329173',	401,	90),
    ('A01329256',	401,	92),
    ('A01328387',	401,	95),
    ('A01551525',	401,	99),
    ('A01329098',	401,	80),
    ('A01329971',	401,	85),
    ('A01329173',	402,	94),
    ('A01329256',	402,	99),
    ('A01328387',	403,	92),
    ('A01551525',	402,	94),
    ('A01329098',	403,	95),
    ('A01329971',	403,	92),
    ('A01329173',	404,	NULL),
    ('A01329256',	404,	NULL),
    ('A01328387',	404,	NULL),
    ('A01551525',	404,	NULL),
    ('A01329098',	404,	NULL),
    ('A01329971',	404,	NULL),
    ('A01329173',	407,	NULL),
    ('A01329256',	405,	99),
    ('A01328387',	405,    93),
    ('A01551525',	407,	NULL),
    ('A01329098',	406,	92),
    ('A01329971',	405,	34),
    ('A01329173',	409,	87),
    ('A01329256',	410,	NULL),
    ('A01328387',	408,	73),
    ('A01551525',	409,	89),
    ('A01329098',	409,	91),
    ('A01329971',	410,	NULL),
    ('A01329173',	411,	NULL),
    ('A01329256',	411,	NULL),
    ('A01328387',	411,	NULL),
    ('A01551525',	411,	NULL),
    ('A01329098',	411,	NULL),
    ('A01329971',	411,	NULL),
    ('A01329173',	412,	NULL),
    ('A01329256',	412,	NULL),
    ('A01328387',	412,	NULL),
    ('A01551525',	412,	NULL),
    ('A01329098',	412,	NULL),
    ('A01329971',	412,	NULL);

select distinct matricula,nombre, apellido from calificaciones natural join estudiantes natural join grupos natural join clases where calificacion is not null;
select matricula, nombre, apellido, calificacion from calificaciones natural join estudiantes natural join grupos natural join clases where clase = "Proba";
select matricula, nombre, apellido, calificacion, clase from calificaciones natural join estudiantes natural join grupos natural join clases natural join maestros where calificacion is not null and nombre_m = "Dan" and apellido_p = "Perez";
select calificacion, clase from calificaciones natural join estudiantes natural join grupos natural join clases where nombre="Roberto" and apellido="Betancourt" and calificacion is not null;
select matricula, nombre, apellido from estudiantes natural join estudiantes_preparatorias natural join preparatorias where preparatoria = 'PUE';
