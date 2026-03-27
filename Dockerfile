# 1. Use the SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# 2. Copy the project file and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# 3. Copy everything else and publish the app
COPY . ./
RUN dotnet publish -c Release -o out

# 4. Build the final runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# 5. Start the API
ENTRYPOINT ["dotnet", "YourProjectName.dll"]