USE sistema_clinico_v2;

/* ROLES
INSERT INTO `sistema_clinico_v2`.`roles` (`nombreRoles`) VALUES ('Admin');
INSERT INTO `sistema_clinico_v2`.`roles` (`nombreRoles`) VALUES ('Médico');
INSERT INTO `sistema_clinico_v2`.`roles` (`nombreRoles`) VALUES ('Secretaria');*/

/*USUARIOS
INSERT INTO `sistema_clinico_v2`.`usuarios` (`aliasUsuarios`, `contraseñaUsuarios`, `rolesID`) VALUES ('admin', SHA2('admin', 256),1);
INSERT INTO `sistema_clinico_v2`.`usuarios` (`aliasUsuarios`, `contraseñaUsuarios`, `rolesID`) VALUES ('mreyes', SHA2('123', 256),2);
INSERT INTO `sistema_clinico_v2`.`usuarios` (`aliasUsuarios`, `contraseñaUsuarios`, `rolesID`) VALUES ('aorué', SHA2('123', 256),3);*/

/*MEDICOS
INSERT INTO `sistema_clinico_v2`.`medicos` (`nombreMedicos`, `apellidoMedico`, `especialidadMedico`, `registroMedico`, `usuariosID`) VALUES ('Martín', 'Reyes', 'Cardiólogo', '252565', 4);
INSERT INTO `sistema_clinico_v2`.`medicos` (`nombreMedicos`, `apellidoMedico`, `especialidadMedico`, `registroMedico`, `usuariosID`) VALUES ('Ariel', 'Orué', 'Fisioterapia', '452893', 4);
INSERT INTO `sistema_clinico_v2`.`medicos` (`nombreMedicos`, `apellidoMedico`, `especialidadMedico`, `registroMedico`, `usuariosID`) VALUES ('Cesar', 'Florentín', 'Fisiatra', '415288', 4);
INSERT INTO `sistema_clinico_v2`.`medicos` (`nombreMedicos`, `apellidoMedico`, `especialidadMedico`, `registroMedico`, `usuariosID`) VALUES ('Emanuel', 'Pavón', 'Urologo', '255828', 4);
INSERT INTO `sistema_clinico_v2`.`medicos` (`nombreMedicos`, `apellidoMedico`, `especialidadMedico`, `registroMedico`, `usuariosID`) VALUES ('Héctor', 'Medina', 'Psicólogo', '558825', 4);
INSERT INTO `sistema_clinico_v2`.`medicos` (`nombreMedicos`, `apellidoMedico`, `especialidadMedico`, `registroMedico`, `usuariosID`) VALUES ('Manuel', 'Pita', 'Cirugano', '474788', 4);
INSERT INTO `sistema_clinico_v2`.`medicos` (`nombreMedicos`, `apellidoMedico`, `especialidadMedico`, `registroMedico`, `usuariosID`) VALUES ('Patricia', 'Olmedo', 'Pediatra', '662252', 4);
INSERT INTO `sistema_clinico_v2`.`medicos` (`nombreMedicos`, `apellidoMedico`, `especialidadMedico`, `registroMedico`, `usuariosID`) VALUES ('Valeria', 'Agüero', 'Nutricionista', '526262', 4);*/

/*SEGURO MEDICO
INSERT INTO `sistema_clinico_v2`.`seguros_medicos` (`aseguradoraSeguros`, `contactoSeguros`, `porcentSeguros`) VALUES ('Asismed', '0216181000', '20');
INSERT INTO `sistema_clinico_v2`.`seguros_medicos` (`aseguradoraSeguros`, `contactoSeguros`, `porcentSeguros`) VALUES ('MeyerLab', '0216255000', '25');
INSERT INTO `sistema_clinico_v2`.`seguros_medicos` (`aseguradoraSeguros`, `contactoSeguros`, `porcentSeguros`) VALUES ('AsuSeguros', '0215186252', '40');
INSERT INTO `sistema_clinico_v2`.`seguros_medicos` (`aseguradoraSeguros`, `contactoSeguros`, `porcentSeguros`) VALUES ('SysPY', '0215958522', '50');*/

/*PACIENTES
INSERT INTO `sistema_clinico_v2`.`pacientes` (`nombrePacientes`, `ciPacientes`, `apellidoPacientes`, `nacimientoPacientes`, `celPacientes`, `correoPacientes`, `seguroID`) VALUES ('Tania', '4446422', 'Vera', '99-04-25', '0982440003', 'prueba@email.com', '1');
INSERT INTO `sistema_clinico_v2`.`pacientes` (`nombrePacientes`, `ciPacientes`, `apellidoPacientes`, `nacimientoPacientes`, `celPacientes`, `correoPacientes`, `seguroID`, `rucPacientes`) VALUES ('Martín', '4955789', 'Reyes', '00-01-17', '0972380722', 'prueba@email.com', '1', '4955789-0');*/

/*INSUMOS
INSERT INTO `sistema_clinico_v2`.`insumos` (`nombreInsumos`, `costounitarioInsumos`, `stockanualInsumos`) VALUES ('Guante de Látex', '1000', '100');

