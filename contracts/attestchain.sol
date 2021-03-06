pragma solidity ^0.4.13;
contract AttestChain {

    struct Revocation {
        bytes32 hash;
        byte[130] signature;
    }
    
    struct Compromisation {
         bytes32 comp_priv_key;
         byte[64] new_pub_key;
    }


    struct MerkleRoot {
         bytes32 merkle_root;
         byte[130] signature;
    }

    Revocation[] public revocations;
    Compromisation[] public compromisations;
    MerkleRoot[] public merkleroots;

    function AttestChain() public {
        
    }

    function revoke(bytes32 hash, byte[130] signature) public {
        revocations.push(Revocation(hash, signature));
    }

    function compromise(bytes32 comp_priv_key, byte[64] new_pub_key) public {
        compromisations.push(Compromisation(comp_priv_key, new_pub_key));
    }

    function submit_root(bytes32 root, byte[130] signature) public {
        merkleroots.push(MerkleRoot(root, signature));
    }

    function get_revocation_list() public constant returns (bytes32[], byte[130][]) {
        bytes32[] memory hashArr = new bytes32[](revocations.length);
        byte[130][] memory sigArr = new byte[130][](revocations.length);

        for (uint i = 0; i < revocations.length; i++) {
             hashArr[i] = revocations[i].hash;
             sigArr[i] = revocations[i].signature;
        }

        return (hashArr, sigArr);
    }

    function get_compromisation_list() public constant returns (bytes32[], byte[64][]) {
        bytes32[] memory privKeyArr = new bytes32[](compromisations.length);
        byte[64][] memory pubKeyArr = new byte[64][](compromisations.length);

        for (uint i = 0; i < compromisations.length; i++) {
             privKeyArr[i] = compromisations[i].comp_priv_key;
             pubKeyArr[i] = compromisations[i].new_pub_key;
        }

        return (privKeyArr, pubKeyArr);
    }

    function get_merkleroots_list() public constant returns (bytes32[], byte[130][]) {
        bytes32[] memory rootArr = new bytes32[](merkleroots.length);
        byte[130][] memory sigArr = new byte[130][](merkleroots.length);

        for (uint i = 0; i < merkleroots.length; i++) {
             rootArr[i] = merkleroots[i].merkle_root;
             sigArr[i] = merkleroots[i].signature;
        }

        return (rootArr, sigArr);
    }
}
