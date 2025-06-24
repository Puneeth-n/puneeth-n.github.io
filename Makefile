# Makefile for local development server

.PHONY: start stop restart status docker-build docker-up docker-down docker-clean

# Default port for the server
PORT := 8000

# Start the local development server
start:
	@echo "Starting local server on port $(PORT)..."
	@echo "Server will be available at: http://localhost:$(PORT)"
	@echo "Press Ctrl+C to stop the server"
	@python3 -m http.server $(PORT)

# Stop the local development server
stop:
	@echo "Stopping local server..."
	@pkill -f "python3 -m http.server $(PORT)" || echo "No server running on port $(PORT)"

# Restart the local development server
restart: stop
	@echo "Restarting local server..."
	@$(MAKE) start

# Check if server is running
status:
	@if pgrep -f "python3 -m http.server $(PORT)" > /dev/null; then \
		echo "✅ Server is running on port $(PORT)"; \
		echo "Visit: http://localhost:$(PORT)"; \
	else \
		echo "❌ Server is not running on port $(PORT)"; \
		echo "Run 'make start' to start the server"; \
	fi

# Open the website in default browser
open:
	@echo "Opening website in default browser..."
	@open http://localhost:$(PORT)

# Help command
help:
	@echo "Available commands:"
	@echo "  make start        - Start the local development server (Python)"
	@echo "  make stop         - Stop the local development server (Python)"
	@echo "  make restart      - Restart the local development server (Python)"
	@echo "  make status       - Check if server is running (Python)"
	@echo "  make open         - Open website in default browser"
	@echo "  make docker-up    - Start the Docker container (Python server)"
	@echo "  make docker-down  - Stop the Docker container"
	@echo "  make docker-clean - Remove Docker resources for this project"
	@echo "  make help         - Show this help message"

# Docker targets

docker-up:
	@echo "Starting Docker container..."
	docker compose up -d


docker-down:
	@echo "Stopping Docker container..."
	docker compose down


docker-clean:
	@echo "Removing Docker resources..."
	docker compose down --rmi all --volumes --remove-orphans 