// a declaration of the version of the Solidity compiler this code should use
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    // declare our event here
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;  // equal to 10^dnaDigits

    struct Zombie {
        string name;
        uint dna;  // value of dna must be non-negative
    }

    Zombie[] public zombies;  // dynamic Array, we can keep adding to it
    // other contracts would be able to read from, but not write to this array

    function _createZombie(string memory _name, uint _dna) private {  // it's convention to start function parameter variable names with an underscore(_) in order to differentiate them from global variables
        // this means only other functions within our contract will be able to call this function and add to the zombies array
        zombies.push(Zombie(_name, _dna));  // array.push() adds something to the end of the array
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {  // we use the keyword private after the function name
    // as with function parameters, it's convention to start private function names with an underscore(_)
        uint rand = uint(keccak256(abi.encodePacked(_str))); // keccak256 : a hash function that maps an input into a random 256-bit hexadecimal number
        return rand % dnaModulus;  // In Solidity, the function declaration contains the type of the return value(in this case uint)
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
