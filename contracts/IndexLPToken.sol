// SPDX-License-Identifier: UNLICENSED

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";

contract IndexLPToken is ERC20PresetMinterPauser {
    constructor()
        ERC20PresetMinterPauser(
            "Index LP Token",
            "IndexLPToken",
            0x3182239686581a07407ad59eAA06c87342B26532
        )
    {}
}
