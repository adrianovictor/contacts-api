FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["contacts-api/contacts-api.csproj", "contacts-api/"]
RUN dotnet restore "contacts-api/contacts-api.csproj"
COPY . .
WORKDIR "/src/contacts-api"
RUN dotnet build "contacts-api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "contacts-api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "contacts-api.dll", "--environment=Development"]