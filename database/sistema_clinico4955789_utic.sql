CREATE DATABASE sistema_clinico_v2;
USE sistema_clinico_v2;

-- ==========================================
-- 1. MÓDULO DE PERSONAS Y ACCESO (Azul)
-- ==========================================
CREATE TABLE roles (
    rolesID INT AUTO_INCREMENT PRIMARY KEY,
    nombreRoles VARCHAR(50) NOT NULL
);

CREATE TABLE usuarios (
    usuariosID INT AUTO_INCREMENT PRIMARY KEY,
    aliasUsuarios VARCHAR(50) NOT NULL,
    contraseñaUsuarios VARCHAR(255) NOT NULL,
    rolesID INT NOT NULL,
    CONSTRAINT fk_usuarios_roles FOREIGN KEY (rolesID) REFERENCES roles(rolesID)
);

CREATE TABLE seguros_medicos (
    seguroID INT AUTO_INCREMENT PRIMARY KEY,
    aseguradoraSeguros VARCHAR(100) NOT NULL,
    contactoSeguros VARCHAR(100),
    porcentSeguros INT NOT NULL
);

CREATE TABLE pacientes (
    pacientesID INT AUTO_INCREMENT PRIMARY KEY,
    nombrePacientes VARCHAR(100) NOT NULL,
    ciPacientes VARCHAR(20) NOT NULL UNIQUE,
    apellidoPacientes VARCHAR(100) NOT NULL,
    nacimientoPacientes DATE NOT NULL,
    celPacientes VARCHAR(20),
    correoPacientes VARCHAR(100),
    seguroID INT NULL,
    rucPacientes VARCHAR(20),
    CONSTRAINT fk_pacientes_seguro FOREIGN KEY (seguroID) REFERENCES seguros_medicos(seguroID)
);

CREATE TABLE medicos (
    medicoID INT AUTO_INCREMENT PRIMARY KEY,
    nombreMedicos VARCHAR(100) NOT NULL,
    apellidoMedico VARCHAR(100) NOT NULL,
    especialidadMedico VARCHAR(100) NOT NULL,
    registroMedico INT NOT NULL,
    usuariosID INT NOT NULL,
    CONSTRAINT fk_medicos_usuarios FOREIGN KEY (usuariosID) REFERENCES usuarios(usuariosID)
);

-- ==========================================
-- 2. MÓDULO DE AGENDAMIENTO (Naranja)
-- ==========================================
CREATE TABLE agendas_config (
    agendasID INT AUTO_INCREMENT PRIMARY KEY,
    diasemanaAgenda VARCHAR(20) NOT NULL,
    horainicioAgenda TIME NOT NULL,
    horafinAgenda TIME NOT NULL,
    duracionAgenda TIME NOT NULL,
    medicoID INT NOT NULL,
    CONSTRAINT fk_agendas_medico FOREIGN KEY (medicoID) REFERENCES medicos(medicoID)
);

CREATE TABLE citas (
    citaID INT AUTO_INCREMENT PRIMARY KEY,
    fechaCita DATE NOT NULL,
    motivoCita VARCHAR(255) NOT NULL,
    horaCita TIME NOT NULL,
    estadoCita VARCHAR(50) NOT NULL,
    pacientesID INT NOT NULL,
    medicoID INT NOT NULL,
    usuariosID INT NOT NULL,
    CONSTRAINT fk_citas_paciente FOREIGN KEY (pacientesID) REFERENCES pacientes(pacientesID),
    CONSTRAINT fk_citas_medico FOREIGN KEY (medicoID) REFERENCES medicos(medicoID),
    CONSTRAINT fk_citas_usuarios FOREIGN KEY (usuariosID) REFERENCES usuarios(usuariosID)
);

CREATE TABLE recordatorios (
    recordatorioID INT AUTO_INCREMENT PRIMARY KEY,
    citaID INT NOT NULL,
    enviadoRecordatorio DATETIME NOT NULL,
    tipocanalRecordatorio VARCHAR(50) NOT NULL,
    mensajeRecordatorio TEXT NOT NULL,
    estadoRecordatorio VARCHAR(50) NOT NULL,
    CONSTRAINT fk_recordatorios_cita FOREIGN KEY (citaID) REFERENCES citas(citaID)
);

-- ==========================================
-- 3. MÓDULO DE CONSULTORIO (Verde)
-- ==========================================
CREATE TABLE consultas (
    consultaID INT AUTO_INCREMENT PRIMARY KEY,
    consulinicioConsulta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    consulfinConsulta TIMESTAMP NULL,
    motivoConsulta TEXT NOT NULL,
    diagnosticoConsulta TEXT,
    observaConsulta TEXT,
    pacientesID INT NOT NULL,
    citaID INT NOT NULL,
    CONSTRAINT fk_consultas_paciente FOREIGN KEY (pacientesID) REFERENCES pacientes(pacientesID),
    CONSTRAINT fk_consultas_cita FOREIGN KEY (citaID) REFERENCES citas(citaID)
);

CREATE TABLE justificativo (
    justificativoID INT AUTO_INCREMENT PRIMARY KEY,
    desdereposoJustificado DATE NOT NULL,
    hastareposoJustificado DATE NOT NULL,
    motivolegalReposo VARCHAR(255) NOT NULL,
    consultaID INT NOT NULL,
    CONSTRAINT fk_justificativo_consulta FOREIGN KEY (consultaID) REFERENCES consultas(consultaID)
);

CREATE TABLE recetas_indicaciones (
    recetasID INT AUTO_INCREMENT PRIMARY KEY,
    medicamentosRecetas TEXT NOT NULL,
    instruccionesRecetas TEXT NOT NULL,
    consultaID INT NOT NULL,
    CONSTRAINT fk_recetas_consulta FOREIGN KEY (consultaID) REFERENCES consultas(consultaID)
);

CREATE TABLE ordenes_analisis (
    ordenID INT AUTO_INCREMENT PRIMARY KEY,
    tipoestudioOrden VARCHAR(255) NOT NULL,
    prioridadOrden VARCHAR(50) NOT NULL,
    consultaID INT NOT NULL,
    CONSTRAINT fk_ordenes_consulta FOREIGN KEY (consultaID) REFERENCES consultas(consultaID)
);

CREATE TABLE procedimientos_realizados (
    procedimientoID INT AUTO_INCREMENT PRIMARY KEY,
    descriProcedimiento VARCHAR(255) NOT NULL,
    duracionProcedimiento TIMESTAMP NULL,
    consultaID INT NOT NULL,
    CONSTRAINT fk_procedimientos_consulta FOREIGN KEY (consultaID) REFERENCES consultas(consultaID)
);

CREATE TABLE documentos_paciente (
    documentosID INT AUTO_INCREMENT PRIMARY KEY,
    tipoDocumento VARCHAR(100) NOT NULL,
    urlarchivoDocumento VARCHAR(255) NOT NULL,
    subidaDocumento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    consultaID INT NOT NULL,
    CONSTRAINT fk_documentos_consulta FOREIGN KEY (consultaID) REFERENCES consultas(consultaID)
);

-- Insumos (Amarillo pero lógica de Consultorio)
CREATE TABLE insumos (
    insumosID INT AUTO_INCREMENT PRIMARY KEY,
    nombreInsumos VARCHAR(100) NOT NULL,
    costounitarioInsumos DECIMAL(15,2) NOT NULL,
    stockanualInsumos INT NOT NULL
);

CREATE TABLE consulta_insumos (
    consultainsumoid INT AUTO_INCREMENT PRIMARY KEY,
    consultaID INT NOT NULL,
    usadoConsultainsumos INT NOT NULL,
    insumosID INT NOT NULL,
    CONSTRAINT fk_ci_consulta FOREIGN KEY (consultaID) REFERENCES consultas(consultaID),
    CONSTRAINT fk_ci_insumos FOREIGN KEY (insumosID) REFERENCES insumos(insumosID)
);

-- ==========================================
-- 4. MÓDULO DE COBROS Y SEGUROS (Amarillo)
-- ==========================================
CREATE TABLE impuestos (
    impuestoID INT AUTO_INCREMENT PRIMARY KEY,
    nombreImpuesto VARCHAR(50) NOT NULL,
    porcentajeImpuesto DECIMAL(5,2) NOT NULL
);

CREATE TABLE facturas_cabecera (
    cabeceraID INT AUTO_INCREMENT PRIMARY KEY,
    expedicionCabecera INT NOT NULL,
    establecimientoCabecera INT NOT NULL,
    numeroCabecera INT NOT NULL,
    emisionCabecera DATE NOT NULL,
    pacientesID INT NOT NULL,
    totalCabecera DECIMAL(15,2) NOT NULL,
    iva5Cabecera DECIMAL(15,2) DEFAULT 0,
    iva10Cabecera DECIMAL(15,2) DEFAULT 0,
    exentaCabecera DECIMAL(15,2) DEFAULT 0,
    estadoCabecera VARCHAR(50) NOT NULL,
    consultaID INT NOT NULL,
    seguroID INT NULL,
    impuestoID INT NOT NULL,
    CONSTRAINT fk_factura_paciente FOREIGN KEY (pacientesID) REFERENCES pacientes(pacientesID),
    CONSTRAINT fk_factura_consulta FOREIGN KEY (consultaID) REFERENCES consultas(consultaID),
    CONSTRAINT fk_factura_seguro FOREIGN KEY (seguroID) REFERENCES seguros_medicos(seguroID),
    CONSTRAINT fk_factura_impuesto FOREIGN KEY (impuestoID) REFERENCES impuestos(impuestoID)
);

CREATE TABLE facturas_detalle (
    detalleID INT AUTO_INCREMENT PRIMARY KEY,
    cabeceraID INT NOT NULL,
    impuestoID INT NOT NULL,
    descriDetalle VARCHAR(255) NOT NULL,
    cantidadDetalle INT NOT NULL,
    costouniDetalle DECIMAL(15,2) NOT NULL,
    iva5Detalle DECIMAL(15,2) DEFAULT 0,
    iva10Detalle DECIMAL(15,2) DEFAULT 0,
    exentaDetalle DECIMAL(15,2) DEFAULT 0,
    CONSTRAINT fk_detalle_cabecera FOREIGN KEY (cabeceraID) REFERENCES facturas_cabecera(cabeceraID),
    CONSTRAINT fk_detalle_impuesto FOREIGN KEY (impuestoID) REFERENCES impuestos(impuestoID)
);

CREATE TABLE pagos (
    pagoID INT AUTO_INCREMENT PRIMARY KEY,
    metodoPago VARCHAR(50) NOT NULL,
    montoPago DECIMAL(15,2) NOT NULL,
    fechaPago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    referenciaPago VARCHAR(100),
    cabeceraID INT NOT NULL,
    impuestoID INT NOT NULL,
    CONSTRAINT fk_pagos_factura FOREIGN KEY (cabeceraID) REFERENCES facturas_cabecera(cabeceraID),
    CONSTRAINT fk_pagos_impuesto FOREIGN KEY (impuestoID) REFERENCES impuestos(impuestoID)
);