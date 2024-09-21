// SPDX-License-Identifier: MIT

pragma solidity 0.8.22;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTMarketplace is ERC721 {
    // Cada vez que se crea un nft, incrementatamos el _nextTokenId
    uint256 private _nextTokenId = 1;
    
    // Este struct va a representar el item(nft)
    struct NFTItem {
        uint256 tokenId;
        address owner;
        uint256 price;
        bool isForSale;
    }
    
    // Listamos los nft que ya han sido creados y esta disponibles para la venta
    mapping(uint256 => NFTItem) public nftItems;
    
    // Eventos para cada accion
    event NFTCreated(uint256 indexed tokenId, address owner, uint256 price);
    event NFTBought(uint256 indexed tokenId, address buyer, uint256 price);
    
    constructor() ERC721("MyNFT", "MNFT") {}

    // Funcion que crea los nuevos nft, los mintea
    function createNFT(uint256 price) public returns (uint256) {
        require(price > 0, "Precio debe de ser mayor a cero");

        ///Aca solo referenciamos la variable tipo contador _nextTokenId, para dar un id al nuevo nft
        uint256 newItemId = _nextTokenId;

        // Minteo
        _mint(msg.sender, newItemId);

        // Agregamos el nuevo nft al lista del marketplace
        nftItems[newItemId] = NFTItem({
            tokenId: newItemId,
            owner: msg.sender,
            price: price,
            isForSale: true
        });

        emit NFTCreated(newItemId, msg.sender, price);

        // Seteamos la variable que lleva el control de los ids a +1
        _nextTokenId++;

        return newItemId;
    }

    // Comprar un nft del marketplace
    function buyNFT(uint256 tokenId) public payable {
        NFTItem storage item = nftItems[tokenId];
        require(item.isForSale, "Este NFT no esta a la venta");
        require(msg.value >= item.price, "Fondos insuficientes para la compra");

        //Aca lo que hacemos es pasar el ownership del creador del nft al comprador
        address previousOwner = item.owner;
        address newOwner = msg.sender;

        // Llamado a ejecutar el paso de ownership
        _transfer(previousOwner, newOwner, tokenId);

        // Le decimos al item (nft) que su dueño es el comprador y la bandera que indicaba que estaba a la venta de pone en false
        item.owner = newOwner;
        item.isForSale = false;

        // Finalmenete pagamos el creador del nft
        payable(previousOwner).transfer(msg.value);

        emit NFTBought(tokenId, newOwner, item.price);
    }

    // Agregar o rehabilitar un nft en particular, por ejemplo si yo compre un nft y luego lo quiero revender llamo este metodo,
    // ya que el nft con su id original siempre va a estar aqui de forma inmutable
    function addNFTForSale(uint256 tokenId, uint256 price) public {
        require(ownerOf(tokenId) == msg.sender, "Solamenete el dueno puede poner a la venta este nft");
        require(price > 0, "Precio debe de ser mayor a cero");

        NFTItem storage item = nftItems[tokenId];
        item.isForSale = true;
        item.price = price;
    }

    // Cancelamos la venta del nft
    function cancelNFTSale(uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "Solamenete el dueno puede cancelar la venta de este nft");

        NFTItem storage item = nftItems[tokenId];
        item.isForSale = false;
    }
}
