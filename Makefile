BIN_NAME=tic
INSTALL_DIR=/usr/local/bin
SOURCE=./tic.sh

.PHONY: all install uninstall help

all: help

install:
	@echo "🔧 Installing $(BIN_NAME) to $(INSTALL_DIR)..."
	install -m 755 $(SOURCE) $(INSTALL_DIR)/$(BIN_NAME)
	@echo "✅ Installed: $(INSTALL_DIR)/$(BIN_NAME)"

uninstall:
	@echo "🧹 Uninstalling $(BIN_NAME)..."
	rm -f $(INSTALL_DIR)/$(BIN_NAME)
	@echo "✅ Uninstalled"

help:
	@echo "Dotfiles Bootstrap CLI Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make install     # Install CLI to /usr/local/bin"
	@echo "  make uninstall   # Remove CLI from system"
	@echo "  make help        # Show this help"
