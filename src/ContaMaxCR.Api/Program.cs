using ContaMaxCR.Core.Models;
using ContaMaxCR.Core.Services;
using ContaMaxCR.Infrastructure;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ??
    "Server=(localdb)\\MSSQLLocalDB;Database=ContaMaxCR;Trusted_Connection=True;TrustServerCertificate=True;";

builder.Services.AddDbContext<ContaMaxCRDbContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddScoped<ContabilidadService>();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<ContaMaxCRDbContext>();
    db.Database.EnsureCreated();
}

app.MapGet("/", () => new
{
    mensaje = "ContaMax-CR API",
    version = "1.0.0",
    pais = "Costa Rica",
    descripcion = "Sistema contable NIFF orientado a multiempresa y multiusuario"
});

app.Run();
