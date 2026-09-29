using System.ComponentModel.DataAnnotations;

namespace ContaMaxCR.Core.Models;

public enum TipoCuentaContable
{
    Activo,
    Pasivo,
    Patrimonio,
    Ingreso,
    Gasto,
    Costo,
    Resultado,
    Otros
}

public enum TipoMovimientoContable
{
    Debito,
    Credito
}

public enum MonedaTipo
{
    CRC,
    USD
}

public class Empresa
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public string Nombre { get; set; } = string.Empty;
    public string NombreLegal { get; set; } = string.Empty;
    public string CedulaJuridica { get; set; } = string.Empty;
    public bool Activa { get; set; } = true;
    public MonedaTipo MonedaBase { get; set; } = MonedaTipo.CRC;
    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;
    public DateTime FechaActualizacion { get; set; } = DateTime.UtcNow;
}

public class UsuarioSistema
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid? EmpresaId { get; set; }
    public string NombreUsuario { get; set; } = string.Empty;
    public string NombreCompleto { get; set; } = string.Empty;
    public string Correo { get; set; } = string.Empty;
    public string Rol { get; set; } = "Administrador";
    public bool Activo { get; set; } = true;
    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;
}

public class CuentaContable
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid EmpresaId { get; set; }
    public string Codigo { get; set; } = string.Empty;
    public string Nombre { get; set; } = string.Empty;
    public TipoCuentaContable TipoCuenta { get; set; }
    public int Nivel { get; set; }
    public bool Activa { get; set; } = true;
    public string? CodigoPadre { get; set; }
    public bool EsMovimiento { get; set; } = true;
    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;
}

public class AsientoContable
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid EmpresaId { get; set; }
    public string NumeroAsiento { get; set; } = string.Empty;
    public DateTime Fecha { get; set; } = DateTime.UtcNow;
    public string Descripcion { get; set; } = string.Empty;
    public MonedaTipo Moneda { get; set; } = MonedaTipo.CRC;
    public string Estado { get; set; } = "Borrador";
    public List<DetalleAsientoContable> Detalles { get; set; } = new();
    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;
}

public class DetalleAsientoContable
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid AsientoId { get; set; }
    public Guid CuentaId { get; set; }
    public TipoMovimientoContable TipoMovimiento { get; set; }
    public decimal Monto { get; set; }
    public string? Referencia { get; set; }
}

public class ClienteProveedor
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid EmpresaId { get; set; }
    public string Tipo { get; set; } = "Cliente";
    public string Nombre { get; set; } = string.Empty;
    public string Identificacion { get; set; } = string.Empty;
    public string Correo { get; set; } = string.Empty;
    public string Telefono { get; set; } = string.Empty;
    public bool Activo { get; set; } = true;
}

public class Factura
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid EmpresaId { get; set; }
    public string Tipo { get; set; } = "Venta";
    public string Numero { get; set; } = string.Empty;
    public Guid ClienteProveedorId { get; set; }
    public DateTime FechaEmision { get; set; } = DateTime.UtcNow;
    public DateTime? FechaVencimiento { get; set; }
    public MonedaTipo Moneda { get; set; } = MonedaTipo.CRC;
    public decimal SubTotal { get; set; }
    public decimal Impuesto { get; set; }
    public decimal Total { get; set; }
    public string Estado { get; set; } = "Emitida";
    public bool EsElectronica { get; set; }
    public string? NumeroDocumentoHacienda { get; set; }
    public List<DetalleFactura> Detalles { get; set; } = new();
}

public class DetalleFactura
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid FacturaId { get; set; }
    public string Concepto { get; set; } = string.Empty;
    public decimal Cantidad { get; set; } = 1;
    public decimal PrecioUnitario { get; set; }
    public decimal Monto { get; set; }
}

public class Pago
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid EmpresaId { get; set; }
    public string Tipo { get; set; } = "Compra";
    public Guid? FacturaId { get; set; }
    public decimal Monto { get; set; }
    public MonedaTipo Moneda { get; set; } = MonedaTipo.CRC;
    public DateTime Fecha { get; set; } = DateTime.UtcNow;
    public string? Metodo { get; set; }
    public string? Referencia { get; set; }
}

public class Cobro
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid EmpresaId { get; set; }
    public string Tipo { get; set; } = "Venta";
    public Guid? FacturaId { get; set; }
    public decimal Monto { get; set; }
    public MonedaTipo Moneda { get; set; } = MonedaTipo.CRC;
    public DateTime Fecha { get; set; } = DateTime.UtcNow;
    public string? Metodo { get; set; }
    public string? Referencia { get; set; }
}

public class ActivoFijo
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid EmpresaId { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public string Categoria { get; set; } = string.Empty;
    public DateTime FechaAdquisicion { get; set; }
    public decimal Costo { get; set; }
    public int VidaUtil { get; set; }
    public decimal DepreciacionAnual { get; set; }
    public string Metodo { get; set; } = "LineaRecta";
}

public class Depreciacion
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid EmpresaId { get; set; }
    public Guid ActivoFijoId { get; set; }
    public string Periodo { get; set; } = string.Empty;
    public decimal Monto { get; set; }
    public DateTime FechaGeneracion { get; set; } = DateTime.UtcNow;
}

public class NotaEstadoFinanciero
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid EmpresaId { get; set; }
    public string Periodo { get; set; } = string.Empty;
    public string Titulo { get; set; } = string.Empty;
    public string Descripcion { get; set; } = string.Empty;
    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;
}

public class PeriodoContable
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid EmpresaId { get; set; }
    public int Anio { get; set; }
    public int Mes { get; set; }
    public string Estado { get; set; } = "Abierto";
    public DateTime FechaInicio { get; set; }
    public DateTime FechaFin { get; set; }
}

public class ParametroEmpresa
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid EmpresaId { get; set; }
    public string Clave { get; set; } = string.Empty;
    public string Valor { get; set; } = string.Empty;
    public DateTime FechaActualizacion { get; set; } = DateTime.UtcNow;
}
