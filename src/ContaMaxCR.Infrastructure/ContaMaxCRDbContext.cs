using ContaMaxCR.Core.Models;
using Microsoft.EntityFrameworkCore;

namespace ContaMaxCR.Infrastructure;

public class ContaMaxCRDbContext : DbContext
{
    public ContaMaxCRDbContext(DbContextOptions<ContaMaxCRDbContext> options) : base(options)
    {
    }

    public DbSet<Empresa> Empresas => Set<Empresa>();
    public DbSet<UsuarioSistema> Usuarios => Set<UsuarioSistema>();
    public DbSet<CuentaContable> Cuentas => Set<CuentaContable>();
    public DbSet<AsientoContable> Asientos => Set<AsientoContable>();
    public DbSet<DetalleAsientoContable> DetallesAsiento => Set<DetalleAsientoContable>();
    public DbSet<ClienteProveedor> ClientesProveedores => Set<ClienteProveedor>();
    public DbSet<Factura> Facturas => Set<Factura>();
    public DbSet<DetalleFactura> DetallesFactura => Set<DetalleFactura>();
    public DbSet<Pago> Pagos => Set<Pago>();
    public DbSet<Cobro> Cobros => Set<Cobro>();
    public DbSet<ActivoFijo> ActivosFijos => Set<ActivoFijo>();
    public DbSet<Depreciacion> Depreciaciones => Set<Depreciacion>();
    public DbSet<NotaEstadoFinanciero> NotasEstadoFinanciero => Set<NotaEstadoFinanciero>();
    public DbSet<PeriodoContable> PeriodosContables => Set<PeriodoContable>();
    public DbSet<ParametroEmpresa> ParametrosEmpresa => Set<ParametroEmpresa>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Empresa>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Nombre).HasMaxLength(200).IsRequired();
            entity.Property(e => e.NombreLegal).HasMaxLength(250);
            entity.Property(e => e.CedulaJuridica).HasMaxLength(30);
        });

        modelBuilder.Entity<CuentaContable>(entity =>
        {
            entity.HasKey(c => c.Id);
            entity.Property(c => c.Codigo).HasMaxLength(40).IsRequired();
            entity.Property(c => c.Nombre).HasMaxLength(200).IsRequired();
            entity.HasIndex(c => new { c.EmpresaId, c.Codigo }).IsUnique();
        });

        modelBuilder.Entity<AsientoContable>(entity =>
        {
            entity.HasKey(a => a.Id);
            entity.HasMany(a => a.Detalles)
                .WithOne()
                .HasForeignKey(d => d.AsientoId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<Factura>(entity =>
        {
            entity.HasKey(f => f.Id);
            entity.Property(f => f.Numero).HasMaxLength(80).IsRequired();
            entity.HasMany(f => f.Detalles)
                .WithOne()
                .HasForeignKey(d => d.FacturaId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<DetalleAsientoContable>(entity =>
        {
            entity.HasKey(x => x.Id);
            entity.Property(x => x.Monto).HasColumnType("decimal(18,2)");
        });

        modelBuilder.Entity<DetalleFactura>(entity =>
        {
            entity.HasKey(x => x.Id);
            entity.Property(x => x.Cantidad).HasColumnType("decimal(18,2)");
            entity.Property(x => x.PrecioUnitario).HasColumnType("decimal(18,2)");
            entity.Property(x => x.Monto).HasColumnType("decimal(18,2)");
        });

        modelBuilder.Entity<ActivoFijo>(entity =>
        {
            entity.Property(x => x.Costo).HasColumnType("decimal(18,2)");
            entity.Property(x => x.DepreciacionAnual).HasColumnType("decimal(18,2)");
        });

        modelBuilder.Entity<Depreciacion>(entity =>
        {
            entity.Property(x => x.Monto).HasColumnType("decimal(18,2)");
        });
    }
}
