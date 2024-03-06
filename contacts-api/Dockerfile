FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["contacts-api/ContactsApi.csproj", "API/"]
RUN dotnet restore "API/ContactsApi.csproj"
COPY . .
WORKDIR "/src/API"
RUN dotnet build "ContactsApi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ContactsApi.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ContactsApi.dll", "--environment=Development"]