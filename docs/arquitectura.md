# Arquitectura del sistema ContaMax-CR

## 1. Visión general

ContaMax-CR es una solución contable integral orientada al mercado costarricense. Está diseñada para cubrir la gestión financiera bajo los lineamientos del NIFF, contemplando facturación electrónica, contabilidad general, análisis financiero y control de movimientos y pagos.

## 2. Objetivos estratégicos

- Soportar varios usuarios y varias empresas en una misma instalación.
- Separar el entorno administrativo y la información contable por empresa.
- Centralizar control del sistema con una base de datos maestra.
- Generar estados financieros con notas y ratios.
- Ejecutar depreciaciones automáticas y reportes periódicos.
- Soportar monedas nacionales y extranjeras.
- Preparar la infraestructura para cumplimiento fiscal y facturación electrónica.

## 3. Arquitectura sugerida

### 3.1 Capas

- Capa de presentación: WPF/WinForms o cliente web
- Capa de negocio: servicios contables, reglas NIFF, validaciones
- Capa de persistencia: Entity Framework Core + SQL Server
- Capa de seguridad: autenticación y autorización por roles
- Capa de integración: facturación electrónica, reportes, exportación

### 3.2 Base de datos maestra

La base maestra almacena:

- empresas
- usuarios
- roles
- permisos
- configuración global
- parámetros del sistema

### 3.3 Base de datos por empresa

Cada empresa tiene una base de datos separada con:

- plan de cuentas
- asientos contables
- facturas de compra/venta
- cuentas por cobrar/pagar
- activos fijos y depreciaciones
- parámetros fiscales y contables
- periodos contables

## 4. Entidades principales

- Empresa
- Usuario
- Rol
- Permiso
- CuentaContable
- AsientoContable
- DetalleAsiento
- FacturaVenta
- FacturaCompra
- ProveedorCliente
- CuentaPorCobrar
- CuentaPorPagar
- Pago
- Cobro
- ActivoFijo
- Depreciacion
- NotaEstadoFinanciero
- RatioFinanciero
- PeriodoContable

## 5. Consideraciones de NIFF

El sistema debe permitir:

- estructura del plan de cuentas por nivel
- categorías de cuentas financieras
- cierre contable por periodo
- determinación de resultados
- totalización por rubros
- generación de notas a los estados financieros

## 6. Mecanismos de seguridad

- autenticación por usuario y contraseña
- encriptación de credenciales
- auditoría por eventos
- bitácora de movimientos y errores
- control por empresa y por usuario

## 7. Instalación en Windows

La solución está preparada para ejecutarse en Windows Server o Windows 10/11. Se recomienda:

- SQL Server Express o Developer
- .NET 8 Runtime
- configuración de permisos de red en la base maestra
- uso de un Instalador con WiX o paquete NSIS para despliegue amigable

## 8. Roadmap del proyecto

### Fase 1

- configuración multiempresa
- usuarios y permisos
- plan de cuentas
- asientos básicos
- estados financieros básicos

### Fase 2

- facturación de ventas y compras
- cuentas por cobrar/pagar
- pagos y cobros
- integración contable

### Fase 3

- depreciaciones
- ratios
- notas a EEFF
- cierre contable
- reportes fiscales

### Fase 4

- integración Hacienda CR
- comprobantes electrónicos
- mejoras de auditoría y seguridad

## 9. Recomendación aplicada en este repositorio

Se ofrece una base sólida en .NET 8 con modelos, contexto de datos y API REST que servirán como núcleo para construir la solución final de escritorio o web. La estructura está lista para crecer sin romper la arquitectura general.
