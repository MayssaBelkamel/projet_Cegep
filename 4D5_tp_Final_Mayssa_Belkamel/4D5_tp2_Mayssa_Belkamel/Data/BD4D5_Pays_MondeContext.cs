using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using _4D5_tp2_Mayssa_Belkamel.Models;

namespace _4D5_tp2_Mayssa_Belkamel.Data;

public partial class BD4D5_Pays_MondeContext : DbContext
{
    public BD4D5_Pays_MondeContext()
    {
    }

    public BD4D5_Pays_MondeContext(DbContextOptions<BD4D5_Pays_MondeContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Changelog> Changelogs { get; set; }

    public virtual DbSet<Client> Clients { get; set; }

    public virtual DbSet<Climat> Climats { get; set; }

    public virtual DbSet<ClimatPay> ClimatPays { get; set; }

    public virtual DbSet<Continent> Continents { get; set; }

    public virtual DbSet<Drapeau> Drapeaus { get; set; }

    public virtual DbSet<Langue> Langues { get; set; }

    public virtual DbSet<LanguePay> LanguePays { get; set; }

    public virtual DbSet<Pay> Pays { get; set; }

    public virtual DbSet<PaysFiltreResult> PaysFiltreResults { get; set; }

    public virtual DbSet<Ville> Villes { get; set; }

    public virtual DbSet<VwPaysInfo> VwPaysInfos { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=BD4D5_Pays_Monde");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Changelog>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__changelo__3213E83F7A759083");

            entity.Property(e => e.InstalledOn).HasDefaultValueSql("(getdate())");
        });

        modelBuilder.Entity<Client>(entity =>
        {
            entity.HasKey(e => e.ClientId).HasName("PK_Client_ClientId");
        });

        modelBuilder.Entity<Climat>(entity =>
        {
            entity.HasKey(e => e.ClimatId).HasName("PK_Climat_ClimatID");
        });

        modelBuilder.Entity<ClimatPay>(entity =>
        {
            entity.HasKey(e => e.ClimatPaysId).HasName("PK_ClimatPays_ClimatPaysID");

            entity.HasOne(d => d.Climat).WithMany(p => p.ClimatPays)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ClimatPays_ClimatID");

            entity.HasOne(d => d.Pays).WithMany(p => p.ClimatPays)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ClimatPays_PaysID");
        });

        modelBuilder.Entity<Continent>(entity =>
        {
            entity.HasKey(e => e.ContinentId).HasName("PK_Continent_ContinentID");
        });

        modelBuilder.Entity<Drapeau>(entity =>
        {
            entity.HasKey(e => e.DrapeauId).HasName("PK_Affiche_DrapeauId");

            entity.Property(e => e.Identifiant).HasDefaultValueSql("(newid())");

            entity.HasOne(d => d.Pays).WithMany(p => p.Drapeaus)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Drapeau_PaysId");
        });

        modelBuilder.Entity<Langue>(entity =>
        {
            entity.HasKey(e => e.LangueId).HasName("PK_Langue_LangueID");
        });

        modelBuilder.Entity<LanguePay>(entity =>
        {
            entity.HasKey(e => e.LanguePaysId).HasName("PK_LanguePays_LanguePaysID");

            entity.HasOne(d => d.Langue).WithMany(p => p.LanguePays)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_LanguePays_LangueID");

            entity.HasOne(d => d.Pays).WithMany(p => p.LanguePays)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_LanguePays_PaysID");
        });

        modelBuilder.Entity<Pay>(entity =>
        {
            entity.HasKey(e => e.PaysId).HasName("PK_Pays_PaysID");

            entity.HasOne(d => d.Continent).WithMany(p => p.Pays)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Pays_ContinentID");
        });

        modelBuilder.Entity<PaysFiltreResult>(entity =>
        {
            entity.HasKey(e => e.PaysId).HasName("PK_PaysFiltreResult_PaysID");
        });

        modelBuilder.Entity<Ville>(entity =>
        {
            entity.HasKey(e => e.VilleId).HasName("PK_Ville_VilleID");

            entity.HasOne(d => d.Pays).WithMany(p => p.Villes).HasConstraintName("FK_Ville_PaysID");
        });

        modelBuilder.Entity<VwPaysInfo>(entity =>
        {
            entity.ToView("vw_PaysInfo", "Geographie");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
