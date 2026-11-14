using _4D5_tp2_Mayssa_Belkamel.Data;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();

builder.Services.AddDbContext<BD4D5_Pays_MondeContext>(
    options=>options.UseSqlServer(builder.Configuration.GetConnectionString("BD4D5_Pays_Monde"))
    );

// Add Authentication
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme).AddCookie(options =>
{
    options.LoginPath = "/Clients/Connexion";
    options.LogoutPath = "/Clients/Deconnexion";
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
}
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllerRoute(
    name:"default",
    pattern: "{controller=Pays}/{action=Index}"
    );

app.MapRazorPages();

app.Run();
