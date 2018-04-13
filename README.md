# ETHexporter
A lightweight server to record Ethereum address balances for your Prometheus database.

## Watch Addresses
The `addresses.txt` file holds all the addresses to fetch balances for. Use the format `name:address` on each new line.
```
etherdelta:0x8d12A197cB00D4747a1fe03395095ce2A5CC6819
bittrex:0xFBb1b73C4f0BDa4f67dcA266ce6Ef42f520fBB98
```

## Build Docker Image
Clone this repo and then follow the simple steps below!

##### Build Docker Image
`docker build -t hunterlong/ethexporter:latest .`

##### Run ethexporter
You'll need access to an ethereum Geth server to fetch balances. You can use [Infura.io](https://infura.io/setup) to quickly get an API key for a geth server.
`docker run -d -p 9015:9015 -e GETH https://mainnet.infura.io/****KEYHERE hunterlong/ethexporter:latest`

## Pull from Dockerhub
Create a `addresses.txt` file with the correct format mentioned above.
```
docker run -d -v addresses.txt:/app/addresses.txt \
   -p 9015:9015 \
   -e GETH https://mainnet.infura.io/****KEYHERE \
   hunterlong/ethexporter:latest
```
The Docker image should be running with the default addresses.

## Prometheus Response
```
eth_balance{name="etherdelta",address="0x8d12A197cB00D4747a1fe03395095ce2A5CC6819"} 29695.20556
eth_balance{name="bittrex",address="0xFBb1b73C4f0BDa4f67dcA266ce6Ef42f520fBB98"} 734415.3192
eth_balance{name="poloniex",address="0x32Be343B94f860124dC4fEe278FDCBD38C102D88"} 17271.03228
eth_balance{name="kraken",address="0x267be1c1d684f78cb4f6a176c4911b741e4ffdc0"} 272114.1214
```