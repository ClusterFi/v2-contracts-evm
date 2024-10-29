# Makefile for ClusterFi OFT Deployment

# Environment variables
BASE_SEPOLIA_RPC_URL=https://sepolia.base.org
POLYGON_AMOY_RPC_URL=https://rpc-amoy.polygon.technology/

PRIVATE_KEY=

# Contract Addresses
BASE_OFT_ADDRESS ?= 
POLYGON_OFT_ADDRESS ?= 

POLYGON_BYTES32_ADDR ?= 
BASE_BYTES32_ADDR ?= 

# Default goal
.DEFAULT_GOAL := help

# Help command
help:
	@echo "Available commands:"
	@echo " make setup-peers     - Set up peers for all contracts"
	@echo " make check-peers     - Check if peers are set correctly"
	@echo " make set-options     - Set enforced options for all contracts"
	@echo " make get-quote-base  - Get send quote on Base"
	@echo " make get-quote-polygon - Get send quote on Polygon"

# Set up peers for all contracts
setup-peers:
	@echo "Setting up peers for all contracts..."
	@forge script script/SetupPeers.s.sol:SetupPeersScript \
		--rpc-url $(BASE_SEPOLIA_RPC_URL) \
		--broadcast -vvvv \
		--sig "run(address,address)" \
		$(BASE_OFT_ADDRESS) $(POLYGON_OFT_ADDRESS)
	@forge script script/SetupPeers.s.sol:SetupPeersScript \
		--rpc-url $(POLYGON_AMOY_RPC_URL) \
		--broadcast -vvvv \
		--sig "run(address,address)" \
		$(BASE_OFT_ADDRESS) $(POLYGON_OFT_ADDRESS)
	@echo "Peer setup complete."


# Check if peers are set correctly
check-peers:
	@echo "Checking peers..."
	cast call $(BASE_OFT_ADDRESS) "isPeer(uint32,bytes32)(bool)" 40267 $(POLYGON_BYTES32_ADDR) --rpc-url $(BASE_SEPOLIA_RPC_URL)
	cast call $(POLYGON_OFT_ADDRESS) "isPeer(uint32,bytes32)(bool)" 40245 $(BASE_BYTES32_ADDR) --rpc-url $(POLYGON_AMOY_RPC_URL)
	@echo "Peer check complete."

# Set enforced options
set-options:
	@echo "Setting enforced options..."
	@forge script script/SetOptions.s.sol:SetOptionsScript --rpc-url $(BASE_SEPOLIA_RPC_URL) --broadcast -vvvv
	@forge script script/SetOptions.s.sol:SetOptionsScript --rpc-url $(POLYGON_AMOY_RPC_URL) --broadcast -vvvv
	@echo "Options setup complete."

# Get send quote on Base
get-quote-base:
	cast call $(BASE_OFT_ADDRESS) "quoteSend((uint32,bytes32,uint256,uint256,bytes,bytes,bytes),bool)(uint,uint)" "(40267, $(POLYGON_BYTES32_ADDR),16000000000000,16000000000000,0x0003010011010000000000000000000000000000c350,0x,0x)" false --rpc-url $(BASE_SEPOLIA_RPC_URL)

# Get send quote on Polygon
get-quote-polygon:
	cast call $(POLYGON_OFT_ADDRESS) "quoteSend((uint32,bytes32,uint256,uint256,bytes,bytes,bytes),bool)(uint,uint)" "(40245, $(BASE_BYTES32_ADDR),16000000000000,16000000000000,0x0003010011010000000000000000000000000000c350,0x,0x)" false --rpc-url $(POLYGON_AMOY_RPC_URL)

.PHONY: help deploy-base deploy-polygon setup-peers setup-manual-peers check-peers set-options get-quote-base get-quote-polygon
