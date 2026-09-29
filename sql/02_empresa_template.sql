USE master;
GO

DECLARE @databaseName NVARCHAR(200) = N'ContaMaxCR_Empresa_Template';

IF DB_ID(@databaseName) IS NULL
BEGIN
    EXEC('CREATE DATABASE [' + @databaseName + ']');
END
GO

USE [ContaMaxCR_Empresa_Template];
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Cuentas')
BEGIN
    CREATE TABLE Cuentas (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        EmpresaId UNIQUEIDENTIFIER NOT NULL,
        Codigo NVARCHAR(40) NOT NULL,
        Nombre NVARCHAR(200) NOT NULL,
        TipoCuenta NVARCHAR(80) NOT NULL,
        Nivel INT NOT NULL,
        Activa BIT NOT NULL DEFAULT 1,
        CodigoPadre NVARCHAR(40) NULL,
        EsMovimiento BIT NOT NULL DEFAULT 1,
        FechaCreacion DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Asientos')
BEGIN
    CREATE TABLE Asientos (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        EmpresaId UNIQUEIDENTIFIER NOT NULL,
        NumeroAsiento NVARCHAR(60) NOT NULL,
        Fecha DATETIME2 NOT NULL,
        Descripcion NVARCHAR(400) NOT NULL,
        Moneda NVARCHAR(10) NOT NULL DEFAULT 'CRC',
        Estado NVARCHAR(50) NOT NULL DEFAULT 'Borrador',
        FechaCreacion DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'DetalleAsientos')
BEGIN
    CREATE TABLE DetalleAsientos (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        AsientoId UNIQUEIDENTIFIER NOT NULL,
        CuentaId UNIQUEIDENTIFIER NOT NULL,
        TipoMovimiento NVARCHAR(20) NOT NULL,
        Monto DECIMAL(18,2) NOT NULL,
        Referencia NVARCHAR(200) NULL,
        CONSTRAINT FK_DetalleAsientos_Asientos FOREIGN KEY (AsientoId) REFERENCES Asientos(Id)
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'ClientesProveedores')
BEGIN
    CREATE TABLE ClientesProveedores (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        EmpresaId UNIQUEIDENTIFIER NOT NULL,
        Tipo NVARCHAR(20) NOT NULL,
        Nombre NVARCHAR(250) NOT NULL,
        Identificacion NVARCHAR(50) NOT NULL,
        Correo NVARCHAR(200) NULL,
        Telefono NVARCHAR(50) NULL,
        Activo BIT NOT NULL DEFAULT 1
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Facturas')
BEGIN
    CREATE TABLE Facturas (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        EmpresaId UNIQUEIDENTIFIER NOT NULL,
        Tipo NVARCHAR(20) NOT NULL,
        Numero NVARCHAR(80) NOT NULL,
        ClienteProveedorId UNIQUEIDENTIFIER NOT NULL,
        FechaEmision DATETIME2 NOT NULL,
        FechaVencimiento DATETIME2 NULL,
        Moneda NVARCHAR(10) NOT NULL DEFAULT 'CRC',
        SubTotal DECIMAL(18,2) NOT NULL DEFAULT 0,
        Impuesto DECIMAL(18,2) NOT NULL DEFAULT 0,
        Total DECIMAL(18,2) NOT NULL DEFAULT 0,
        Estado NVARCHAR(50) NOT NULL DEFAULT 'Emitida',
        EsElectronica BIT NOT NULL DEFAULT 0,
        NumeroDocumentoHacienda NVARCHAR(120) NULL
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'DetalleFacturas')
BEGIN
    CREATE TABLE DetalleFacturas (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        FacturaId UNIQUEIDENTIFIER NOT NULL,
        Concepto NVARCHAR(250) NOT NULL,
        Cantidad DECIMAL(18,2) NOT NULL DEFAULT 1,
        PrecioUnitario DECIMAL(18,2) NOT NULL,
        Monto DECIMAL(18,2) NOT NULL,
        CONSTRAINT FK_DetalleFacturas_Facturas FOREIGN KEY (FacturaId) REFERENCES Facturas(Id)
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Pagos')
BEGIN
    CREATE TABLE Pagos (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        EmpresaId UNIQUEIDENTIFIER NOT NULL,
        Tipo NVARCHAR(30) NOT NULL,
        FacturaId UNIQUEIDENTIFIER NULL,
        Monto DECIMAL(18,2) NOT NULL,
        Moneda NVARCHAR(10) NOT NULL DEFAULT 'CRC',
        Fecha DATETIME2 NOT NULL,
        Metodo NVARCHAR(80) NULL,
        Referencia NVARCHAR(200) NULL
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Cobros')
BEGIN
    CREATE TABLE Cobros (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        EmpresaId UNIQUEIDENTIFIER NOT NULL,
        Tipo NVARCHAR(30) NOT NULL,
        FacturaId UNIQUEIDENTIFIER NULL,
        Monto DECIMAL(18,2) NOT NULL,
        Moneda NVARCHAR(10) NOT NULL DEFAULT 'CRC',
        Fecha DATETIME2 NOT NULL,
        Metodo NVARCHAR(80) NULL,
        Referencia NVARCHAR(200) NULL
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'ActivosFijos')
BEGIN
    CREATE TABLE ActivosFijos (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        EmpresaId UNIQUEIDENTIFIER NOT NULL,
        Nombre NVARCHAR(200) NOT NULL,
        Categoria NVARCHAR(120) NOT NULL,
        FechaAdquisicion DATETIME2 NOT NULL,
        Costo DECIMAL(18,2) NOT NULL,
        VidaUtil INT NOT NULL,
        DepreciacionAnual DECIMAL(18,2) NOT NULL,
        Metodo NVARCHAR(50) NOT NULL DEFAULT 'LineaRecta'
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Depreciaciones')
BEGIN
    CREATE TABLE Depreciaciones (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        EmpresaId UNIQUEIDENTIFIER NOT NULL,
        ActivoFijoId UNIQUEIDENTIFIER NOT NULL,
        Periodo NVARCHAR(20) NOT NULL,
        Monto DECIMAL(18,2) NOT NULL,
        FechaGeneracion DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'NotasEstadoFinanciero')
BEGIN
    CREATE TABLE NotasEstadoFinanciero (
        Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
        EmpresaId UNIQUEIDENTIFIER NOT NULL,
        Periodo NVARCHAR(20) NOT NULL,
        Titulo NVARCHAR(200) NOT NULL,
        Descripcion NVARCHAR(2000) NOT NULL,
        FechaCreacion DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
    );
END
GO
