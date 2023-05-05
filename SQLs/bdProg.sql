use bdProg;
-- 
CREATE TABLE productos (
    id INT,
    descripcion VARCHAR(50),
    precio INT,
    CONSTRAINT pk_productos PRIMARY KEY (id)
);