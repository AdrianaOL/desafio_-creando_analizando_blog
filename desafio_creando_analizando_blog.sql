---------- Creación BD ---------
CREATE DATABASE blog_db;
------ creación Tablas ----
CREATE TABLE usuarios(
    id SERIAL PRIMARY KEY,
    email VARCHAR(256) NOT NULL
);

CREATE TABLE posts(
    id SERIAL PRIMARY KEY,
    usuarios_fk INT,
    titulo VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (usuarios_fk) REFERENCES usuarios(id)
);

CREATE TABLE comentarios(
    id SERIAL PRIMARY KEY,
    posts_fk INT,
    usuarios_fk INT,
    texto VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (posts_fk) REFERENCES posts(id),
    FOREIGN KEY (usuarios_fk) REFERENCES usuarios(id)

);


----- INSERTANDO DATOS  TABLA USUARIO---------
\copy usuarios FROM 'C:\Users\SSI\Desktop\usuarios.csv' csv header;
------ INSERTANDO  DATOS TABLA POSTS ------------------
\copy posts FROM 'C:\Users\SSI\Desktop\posts.csv' csv header;
---------- INSERTANDO DATOS TABLA COMENTARIOS----------
\copy comentarios FROM 'C:\Users\SSI\Desktop\comentarios.csv' csv header;

--- Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
SELECT usuarios.id, email, titulo 
FROM usuarios 
INNER JOIN posts ON usuarios.id = posts.usuarios_fk 
WHERE usuarios.id = 5;
--- Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com.
SELECT email, usuarios.id, texto 
FROM comentarios
LEFT JOIN usuarios ON comentarios.usuarios_fk = usuarios.id
WHERE usuarios.email != 'usuario06@hotmail.com';
--- Listar los usuarios que no han publicado ningún post.
SELECT *
FROM usuarios
FULL OUTER JOIN posts on
usuarios.id = posts.usuarios_fk
WHERE usuarios.id is null or posts.usuarios_fk is null;

--- Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios).
SELECT titulo, texto
FROM posts 
FULL OUTER JOIN comentarios ON posts.id = comentarios.posts_fk;

---- Listar todos los usuarios que hayan publicado un post en Junio.
SELECT *
FROM usuarios 
INNER JOIN posts ON usuarios.id = posts.usuarios_fk 
WHERE  posts.fecha BETWEEN '2020-06-01' AND '2020-06-30';









