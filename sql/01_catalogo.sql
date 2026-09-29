USE master;
GO

IF DB_ID(N'ContaMaxCR_Central') IS NULL
BEGIN
    CREATE DATABASE [ContaMaxCR_Central];
END
GO

USE [ContaMaxCR_Central];
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Empresas')
BEGIN
    CREATE TABLE Empresas (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        Nombre NVARCHAR(200) NOT NULL,
        NombreLegal NVARCHAR(250) NULL,
        CedulaJuridica NVARCHAR(30) NULL,
        Activa BIT NOT NULL DEFAULT 1,
        MonedaBase NVARCHAR(10) NOT NULL DEFAULT 'CRC',
        FechaCreacion DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        FechaActualizacion DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Usuarios')
BEGIN
    CREATE TABLE Usuarios (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        EmpresaId UNIQUEIDENTIFIER NULL,
        NombreUsuario NVARCHAR(80) NOT NULL,
        NombreCompleto NVARCHAR(200) NOT NULL,
        Correo NVARCHAR(200) NULL,
        Rol NVARCHAR(80) NOT NULL DEFAULT 'Administrador',
        Activo BIT NOT NULL DEFAULT 1,
        FechaCreacion DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT FK_Usuarios_Empresas FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'ConfiguracionSistema')
BEGIN
    CREATE TABLE ConfiguracionSistema (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        Clave NVARCHAR(120) NOT NULL,
        Valor NVARCHAR(500) NOT NULL,
        EmpresaId UNIQUEIDENTIFIER NULL,
        FechaActualizacion DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT FK_ConfiguracionSistema_Empresas FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'BitacoraEventos')
BEGIN
    CREATE TABLE BitacoraEventos (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        EmpresaId UNIQUEIDENTIFIER NULL,
        UsuarioId UNIQUEIDENTIFIER NULL,
        TipoEvento NVARCHAR(120) NOT NULL,
        Descripcion NVARCHAR(1000) NOT NULL,
        Fecha DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'PeriodosContables')
BEGIN
    CREATE TABLE PeriodosContables (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        EmpresaId UNIQUEIDENTIFIER NOT NULL,
        Anio INT NOT NULL,
        Mes INT NOT NULL,
        Estado NVARCHAR(50) NOT NULL DEFAULT 'Abierto',
        FechaInicio DATETIME2 NOT NULL,
        FechaFin DATETIME2 NOT NULL,
        CONSTRAINT FK_PeriodosContables_Empresas FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
    );
END
GO
