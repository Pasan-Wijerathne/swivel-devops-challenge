FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src

COPY DevOpsChallenge.SalesApi.sln .
COPY src/DevOpsChallenge.SalesApi/DevOpsChallenge.SalesApi.csproj src/DevOpsChallenge.SalesApi/
COPY src/DevOpsChallenge.SalesApi.Business/DevOpsChallenge.SalesApi.Business.csproj src/DevOpsChallenge.SalesApi.Business/
COPY src/DevOpsChallenge.SalesApi.Database/DevOpsChallenge.SalesApi.Database.csproj src/DevOpsChallenge.SalesApi.Database/
COPY tests/DevOpsChallenge.SalesApi.Business.UnitTests/DevOpsChallenge.SalesApi.Business.UnitTests.csproj tests/DevOpsChallenge.SalesApi.Business.UnitTests/
COPY tests/DevOpsChallenge.SalesApi.IntegrationTests/DevOpsChallenge.SalesApi.IntegrationTests.csproj tests/DevOpsChallenge.SalesApi.IntegrationTests/

RUN dotnet restore

COPY . .

RUN dotnet build -c Release -o /app/build
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime

WORKDIR /app

COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:80
ENV ASPNETCORE_ENVIRONMENT=Development

EXPOSE 80

ENTRYPOINT ["dotnet", "DevOpsChallenge.SalesApi.dll"]