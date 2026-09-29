using ContaMaxCR.Core.Models;
using ContaMaxCR.Infrastructure;
using Microsoft.EntityFrameworkCore;

namespace ContaMaxCR.Core.Services;

public class ContabilidadService
{
    private readonly ContaMaxCRDbContext _context;

    public ContabilidadService(ContaMaxCRDbContext context)
    {
        _context = context;
    }

    public async Task<List<CuentaContable>> ObtenerCuentasAsync(Guid empresaId)
    {
        return await _context.Cuentas
            .Where(c => c.EmpresaId == empresaId)
            .OrderBy(c => c.Codigo)
            .ToListAsync();
    }

    public async Task<AsientoContable> CrearAsientoAsync(
        Guid empresaId,
        Guid cuentaDebitoId,
        Guid cuentaCreditoId,
        decimal monto,
        string descripcion,
        MonedaTipo moneda)
    {
        var asiento = new AsientoContable
        {
            EmpresaId = empresaId,
            NumeroAsiento = $"AS-{DateTime.UtcNow:yyyyMMddHHmmss}",
            Fecha = DateTime.UtcNow,
            Descripcion = descripcion,
            Moneda = moneda,
            Estado = "Registrado"
        };

        asiento.Detalles.Add(new DetalleAsientoContable
        {
            CuentaId = cuentaDebitoId,
            TipoMovimiento = TipoMovimientoContable.Debito,
            Monto = monto,
            Referencia = "Cargo"
        });

        asiento.Detalles.Add(new DetalleAsientoContable
        {
            CuentaId = cuentaCreditoId,
            TipoMovimiento = TipoMovimientoContable.Credito,
            Monto = monto,
            Referencia = "Abono"
        });

        _context.Asientos.Add(asiento);
        await _context.SaveChangesAsync();

        return asiento;
    }

    public async Task<CicloContableResumen> GenerarCicloContableAsync(Guid empresaId, DateTime periodo)
    {
        var cuentas = await _context.Cuentas
            .Where(c => c.EmpresaId == empresaId)
            .ToListAsync();

        var totalActivos = cuentas
            .Where(c => c.TipoCuenta == TipoCuentaContable.Activo)
            .Count();

        var totalPasivos = cuentas
            .Where(c => c.TipoCuenta == TipoCuentaContable.Pasivo)
            .Count();

        var totalIngresos = cuentas
            .Where(c => c.TipoCuenta == TipoCuentaContable.Ingreso)
            .Count();

        var totalGastos = cuentas
            .Where(c => c.TipoCuenta == TipoCuentaContable.Gasto)
            .Count();

        return new CicloContableResumen
        {
            EmpresaId = empresaId,
            Periodo = periodo,
            TotalCuentas = cuentas.Count,
            TotalActivos = totalActivos,
            TotalPasivos = totalPasivos,
            TotalIngresos = totalIngresos,
            TotalGastos = totalGastos,
            Estado = "Generado",
            Observaciones = "Ciclo contable preparado de acuerdo con el NIFF y la configuración de la empresa."
        };
    }

    public async Task<List<NotaEstadoFinanciero>> GenerarNotasEstadoFinancieroAsync(Guid empresaId, string periodo)
    {
        var notas = new List<NotaEstadoFinanciero>
        {
            new()
            {
                EmpresaId = empresaId,
                Periodo = periodo,
                Titulo = "Notas sobre políticas contables",
                Descripcion = "Las políticas contables se basan en el NIFF y se aplican de forma uniforme. Las partidas se registran por empresa, por moneda y por período contable."
            },
            new()
            {
                EmpresaId = empresaId,
                Periodo = periodo,
                Titulo = "Notas sobre activos y depreciación",
                Descripcion = "Los activos fijos se registran con su costo histórico y se depreciarán según la vida útil definida por el cliente y las políticas contables aplicables."
            },
            new()
            {
                EmpresaId = empresaId,
                Periodo = periodo,
                Titulo = "Notas sobre cuentas por cobrar y pagar",
                Descripcion = "Se mantienen saldos por documento con sus fechas de vencimiento y condiciones de cobro o pago para permitir análisis de ley, antigüedad y control de flujos."
            }
        };

        await _context.NotasEstadoFinanciero.AddRangeAsync(notas);
        await _context.SaveChangesAsync();

        return notas;
    }
}

public class CicloContableResumen
{
    public Guid EmpresaId { get; set; }
    public DateTime Periodo { get; set; }
    public int TotalCuentas { get; set; }
    public int TotalActivos { get; set; }
    public int TotalPasivos { get; set; }
    public int TotalIngresos { get; set; }
    public int TotalGastos { get; set; }
    public string Estado { get; set; } = string.Empty;
    public string Observaciones { get; set; } = string.Empty;
}
