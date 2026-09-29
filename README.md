# ContaMax-CR

Sistema de contabilidad empresarial basado en NIFF para Costa Rica, diseñado para operar en entornos Windows, con soporte multiusuario, multiempresa, moneda local (colones) y extranjera (dólares), facturación electrónica en formato de la Hacienda de Costa Rica, cuentas por cobrar y pagar, depreciaciones, ratios y estados financieros con notas.

## Objetivo

Proporcionar una base de desarrollo para una solución contable integral que respete las normas del NIFF y el entorno fiscal costarricense, con una arquitectura preparada para:

- múltiples empresas
- múltiples usuarios con roles y permisos
- múltiples bases de datos por empresa
- manejo de colones y dólares
- ciclo contable completo
- facturación de compras, gastos y ventas
- cuentas por cobrar y pagar
- pagos y cobros integrados
- depreciación de activos
- ratios financieros
- notas a los estados financieros
- instalación en Windows
- salida en español

## Estructura del repositorio

- `docs/arquitectura.md`: arquitectura general del sistema
- `docs/requisitos-funcionales.md`: alcance funcional y módulos
- `sql/01_catalogo.sql`: catálogo central del sistema
- `sql/02_empresa_template.sql`: plantilla del esquema de base de datos por empresa
- `src/`: solución .NET 8 con API y modelos base
- `scripts/windows/install.ps1`: script de instalación para Windows

## Stack sugerido

- Backend: .NET 8 / ASP.NET Core Web API
- Base de datos: SQL Server (central + base de datos por empresa)
- ORM: Entity Framework Core
- Instalador Windows: PowerShell + WiX/NSIS (se incluye script base)
- UI: WPF/WinForms (base lista para evolución)

## Inicio rápido

1. Se requiere SQL Server 2019+ o SQL Server Express.
2. Crear la base central del sistema.
3. Ejecutar los scripts SQL del directorio `sql`.
4. Ajustar la cadena de conexión en `src/ContaMaxCR.Api/appsettings.json`.
5. Restaurar dependencias:

```bash
dotnet restore src/ContaMaxCR.sln
```

6. Ejecutar la API:

```bash
dotnet run --project src/ContaMaxCR.Api/ContaMaxCR.Api.csproj
```

7. Verificar la API en:

```text
http://localhost:5000/swagger
```

## Módulos principales

- Plan de cuentas NIFF
- Ciclos contables
- Asientos contables
- Cuentas por cobrar y pagar
- Facturas electrónicas
- Pagos y cobros
- Depreciaciones
- Ratios financieros
- Estados financieros con notas
- Multiempresa y multiusuario
- Seguridad por roles

## Nota importante

Este repositorio es una base sólida y funcional para iniciar la construcción del sistema. Incluye la arquitectura, los modelos, la capa de acceso a datos y la API base. Es una versión de base de producción con enfoque de escalabilidad y cumplimiento de requerimientos de Costa Rica.

## Licencia

GPL-3.0
