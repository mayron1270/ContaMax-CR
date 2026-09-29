# Requisitos funcionales de ContaMax-CR

## 1. Módulo de administración

- registro y gestión de empresas
- administración de usuarios y roles
- configuración general de la empresa
- configuración de moneda base y tipos de cambio
- parametrización de periodos contables

## 2. Módulo contable

- creación del plan de cuentas por NIFF
- niveles y clasificación contable
- asientos de diario por partidas
- balance general y estado de resultados
- cierre de periodo contable
- cuentas por cobrar y pagar
- manejo de notas a los estados financieros

## 3. Módulo de facturación

- facturas de compra
- facturas de venta
- gastos y servicios
- comprobantes con IVA e impuestos costarricenses
- facturación electrónica en formato Hacienda CR
- generación de notas de crédito y débito

## 4. Módulo de pagos y cobros

- registro de pagos a proveedores
- registro de cobros de clientes
- conciliación por documentos
- control de vencimientos
- estados de antigüedad de saldos

## 5. Módulo de activos fijos

- registro de activos
- categorías y vida útil
- depreciación por línea recta o fórmula configurable
- historial de depreciaciones
- baja de activos

## 6. Módulo de análisis financiero

- ratios de liquidez
- solvencia
- eficiencia operativa
- rentabilidad
- estructura financiera

## 7. Módulo de informes

- balance general
- estado de resultados
- flujo de efectivo
- libro mayor
- libro diario
- antigüedad de cuentas por cobrar/pagar
- notas a los estados financieros

## 8. Requisitos de diseño

- interfaz en español
- compatible con Windows 10/11 y Windows Server
- soporte de varias empresas por instalación
- base de datos por empresa
- soporte multiusuario con permisos
- uso de colones y dólares
- seguridad y trazabilidad

## 9. Reglas de negocio sugeridas

- el saldo de un asiento debe balancear
- no se permite cuenta sin tipo de cuenta
- el periodo contable no puede estar cerrado si hay movimientos no validados
- cada comprobante debe estar asociado a una empresa
- cada factura debe estar vinculada a un cliente o proveedor
- la depreciación debe calcularse según la vida útil del activo
