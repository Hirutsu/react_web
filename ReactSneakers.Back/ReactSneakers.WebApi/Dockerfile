#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["ReactSneakers.WebApi/ReactSneakers.WebApi.csproj", "ReactSneakers.WebApi/"]
COPY ["ReactSneakers.Helper/ReactSneakers.Helper.csproj", "ReactSneakers.Helper/"]
COPY ["ReactSneakers.Repositories/ReactSneakers.Repositories.csproj", "ReactSneakers.Repositories/"]
COPY ["ReactSneakers.Entities/ReactSneakers.Entities.csproj", "ReactSneakers.Entities/"]
COPY ["ReactSneakers.Services/ReactSneakers.Services.csproj", "ReactSneakers.Services/"]
RUN dotnet restore "ReactSneakers.WebApi/ReactSneakers.WebApi.csproj"
COPY . .
WORKDIR "/src/ReactSneakers.WebApi"
RUN dotnet build "ReactSneakers.WebApi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ReactSneakers.WebApi.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ReactSneakers.WebApi.dll"]