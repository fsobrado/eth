# NFT Marketplace
Este proyecto es un contrato inteligente que implementa un marketplace para la compra y venta de NFTs (Tokens No Fungibles). Se utiliza el estándar ERC721 de OpenZeppelin, que nos permite crear y gestionar NFTs de forma sencilla.

## ¿Qué hace este contrato?
Este contrato permite a los usuarios crear, comprar y vender NFTs dentro de un marketplace. A continuación, explico cada parte importante del contrato:

1. Crear un NFT
Cuando un usuario quiere crear (o mintear) un nuevo NFT, llama a la función createNFT, que genera un token con un precio determinado. Este token se añade al marketplace y queda disponible para la venta.

2. Comprar un NFT
Los usuarios pueden comprar NFTs que estén a la venta usando la función buyNFT. Aquí se valida que el NFT esté disponible y que el comprador tenga fondos suficientes para pagarlo. Una vez comprados, el propietario del NFT cambia al comprador.

3. Poner a la venta un NFT
Si un usuario tiene un NFT y lo quiere revender, puede hacerlo llamando a la función addNFTForSale. Esto permite poner nuevamente el NFT en el marketplace con un nuevo precio.

4. Cancelar la venta
El propietario de un NFT también tiene la opción de cancelar la venta, usando la función cancelNFTSale, si decide no venderlo más.

## Creadores
-Federico Sobrado
-Manuel Jimenez
-Oscar Alvarado

## Links
https://sepolia.etherscan.io/address/0x9A53D8A697A44734D760739e0de674DeaF6f9d96#code
