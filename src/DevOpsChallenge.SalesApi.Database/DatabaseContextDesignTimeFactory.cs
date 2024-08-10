using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using System;

namespace DevOpsChallenge.SalesApi.Database
{
    /// <summary>
    /// Design time factory for the database context.
    /// </summary>
    public class DatabaseContextDesignTimeFactory : IDesignTimeDbContextFactory<DatabaseContext>
    {
        /// <inheritdoc />
        public DatabaseContext CreateDbContext(string[] args)
        {
            string connectionString = Environment.GetEnvironmentVariable("CONNECTIONSTRINGS__DATABASE") ?? @"Server=db,1433\mssqllocaldb;Database=DevOpsChallenge.SalesApi;Trusted_Connection=True;ConnectRetryCount=0;User=sa;Password=YourStrong!Passw0rd";

            DbContextOptionsBuilder<DatabaseContext> optionsBuilder = new DbContextOptionsBuilder<DatabaseContext>()
                .UseSqlServer(connectionString);

            return new DatabaseContext(optionsBuilder.Options);
        }
    }
}
