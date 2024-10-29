pragma solidity ^0.8.22;

import "forge-std/Script.sol";
import "../../src/COFT.sol";
import { OptionsBuilder } from "@layerzerolabs/oapp-evm/contracts/oapp/libs/OptionsBuilder.sol";

contract SetOptionsScript is Script {
    using OptionsBuilder for bytes;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address baseOFTAddress = vm.envAddress("BASE_OFT_ADDRESS");
        address polygonOFTAddress = vm.envAddress("POLYGON_OFT_ADDRESS");

        ClusterFiOFT baseOFT = ClusterFiOFT(baseOFTAddress);
        ClusterFiOFT polygonOFT = ClusterFiOFT(polygonOFTAddress);

        bytes memory options = OptionsBuilder.newOptions().addExecutorLzReceiveOption(200000, 0);

        baseOFT.setEnforcedOptions(options);
        polygonOFT.setEnforcedOptions(options);

        vm.stopBroadcast();
    }
}