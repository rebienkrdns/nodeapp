# Node App with Docker Compose

## Prerequisites
- Docker
- Docker Compose

## App Helper Script (`app.sh`)
This project includes a helper script `app.sh` to manage the application lifecycle easily using Docker Compose profiles.
It automatically handles user permissions and cleanup relative to your environment.

### Setup
Ensure the script is executable:
```bash
chmod +x app.sh
```

### Usage
```bash
./app.sh [command] [profile]
```
- **profile**: Optional. Defaults to `run`. Available profiles: `run` (production-like), `dev` (development).

### Commands

| Command | Description |
|---------|-------------|
| `./app.sh install` | **Install**: Installs `node_modules` locally using a container. Run this first! |
| `./app.sh build` | **Build**: Compiles the application into the `build` directory. |
| `./app.sh up [profile]` | **Start**: Starts the application in detached mode. |
| `./app.sh logs [profile]` | **Logs**: Follows the application logs. Press `Ctrl+C` to exit. |
| `./app.sh stop [profile]` | **Stop**: Stops the running containers for the profile. |
| `./app.sh restart [profile]` | **Restart**: Restarts the running containers. |
| `./app.sh down` | **Remove**: Stops and removes ALL containers and networks (cleans up everything). |
| `./app.sh reset [profile]` | **Reset**: Performs a full reset (Down -> Up -> Logs). |
| `./app.sh clean` | **Deep Clean**: Removes all containers and deletes `node_modules`. |

### Usage Examples

**1. First Time Setup**
Install dependencies and build the project:
```bash
./app.sh install
./app.sh build
```

**2. Run in Production Mode (Default)**
Starts the compiled application (requires build first):
```bash
./app.sh up
# View logs
./app.sh logs
```

**3. Run in Development Mode**
Starts with hot-reload (HMR) enabled. No build required:
```bash
./app.sh up dev
# Or flexible ordering:
./app.sh dev up
```

**4. Reset Environment**
If something goes wrong or ports are conflicting:
```bash
./app.sh reset     # Resets run profile
./app.sh reset dev # Resets dev profile
```

**5. Clean Start**
Wipe `node_modules` and start over:
```bash
./app.sh clean
./app.sh install
```

## Manual Usage
Under the hood, this script uses Docker Compose profiles.
All files are created with your host user permissions (`UID:GID`).
- **Install**: `docker compose --profile install up`
- **Dev**: `docker compose --profile dev up`
- **Run**: `docker compose --profile run up`
