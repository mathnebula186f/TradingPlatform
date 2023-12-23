import React from 'react';
import { Text, Box,Flex,Grid,GridItem } from '@chakra-ui/layout';
import { Tabs, Tab, TabIndicator, TabList, TabPanel, TabPanels } from '@chakra-ui/react';
import Graph from '../candlegraph/Graph';
// import arr from '../candlegraph/output.mjs';
import Table from '../tables/Table';
import Limit from './Limit';
import Market from './Market';
import { useEffect,useState } from 'react';
import { useWallet } from "@aptos-labs/wallet-adapter-react";
import { Provider, Network } from "aptos";
import Navbar from "../Navbar/Navbar";
import { Layout, Row, Col, Button, Spin, List, Checkbox, Input} from "antd";


interface CryptopageProps {
  name: string; 
}

interface ArrayElement {
  x: string;
  y: number[];
}

interface InputData {
  x: string;
  y: number[];
}

interface OutputData {
  x: string;
  y: number[];
}

interface OutputObject {
  data: OutputData[];
}

export const provider = new Provider(Network.DEVNET);
export const moduleAddress = "0x5ee007992ae8b720030c92f3fa5eb94be806858967a3359f99224e6bca65b7b1";
export const moduleName = "trading_platform";

const Cryptopage: React.FC<CryptopageProps> = (props) => {

  const { account } = useWallet();
  const wallet = (window as any).aptos;
  const [userRegistered, setUserRegistered] = useState<boolean>(false);
  const [txnHistory, setTxnHistory] = useState<any[]>([]); 
  const [arr, setArr] = useState<ArrayElement[]>([]);
  const [transactionInProgress, setTransactionInProgress] = useState<boolean>(false);

  //FETCH HERE
//   const fetchTxnInfo = async () => {
// 		if (!account) return [];
// 		try {
// 			const UserResource = await provider.getAccountResource(
// 				account.address,
// 				`${moduleAddress}::${moduleName}::UserResource`
// 			);
// 			console.log(UserResource)
// 			// setUserRegistered(true);
// 		} catch (e: any) {
// 			console.log("[fetchUserInfo]: ", e)
// 			// setUserRegistered(false);
// 		}
// 	};

//     useEffect(() => {
// 		fetchTxnInfo();
// 	}, [account?.address]);

  
   function transformData(input: InputData[]): OutputObject {
  const outputData: OutputData[] = input.map((item) => {
    const date = new Date(item.x);
    const formattedDate = new Date(
      date.getUTCFullYear(),
      date.getUTCMonth(),
      date.getUTCDate(),
      date.getUTCHours(),
      date.getUTCMinutes(),
      date.getUTCSeconds(),
      date.getUTCMilliseconds()
    ).toISOString();

    return {
      x: formattedDate,
      y: item.y,
    };
  });

  return {
    data: outputData,
  };
}

  const fetchUserInfo = async () => {
		if (!account) return [];
		try {
			const UserResource = await provider.getAccountResource(
				account.address,
				`${moduleAddress}::${moduleName}::UserResource<0x1::aptos_coin::AptosCoin,${moduleAddress}::coins::${props.name}>`
			);
			console.log("Here is the userinfo=",UserResource)
			setUserRegistered(true);
		} catch (e: any) {
			console.log("[fetchUserInfo]: Error", e)
			setUserRegistered(false);
		}
	};

	const fetchTxnInfo = async () => {
		if (!account) return [];
		try {
			const UserResource = await provider.getAccountResource(
				moduleAddress,
				`${moduleAddress}::${moduleName}::Market<0x1::aptos_coin::AptosCoin,${moduleAddress}::coins::${props.name}>`
			);
			console.log("Here is the txn info in cryptopage=",UserResource)
            const data: {
                transactions?: { price: string; timestamp: string }[];
            } = UserResource?.data || {};
            const transactionsData = data?.transactions || [];

            console.log("Txn History in cryptopage:",transactionsData);
            // setBuyOrders(buyOrdersData);
            // setSellOrders(sellOrdersData)
           
            setTxnHistory(transactionsData);

// 			const input = [
//   { timestamp: 1702316485, price: 97.14 },
//   { timestamp: 1702316710, price: 78.43 },
//   { timestamp: 1702316745, price: 99.72 },
//   { timestamp: 1702316868, price: 85.85 },
//   { timestamp: 1702316722, price: 85.18 },
//   { timestamp: 1702317045, price: 50.77 },
//   { timestamp: 1702316580, price: 54.62 },
//   { timestamp: 1702316526, price: 72.83 },
//   { timestamp: 1702316483, price: 85.44 },
//   { timestamp: 1702316977, price: 79.21 },
//   { timestamp: 1702316739, price: 55.71 },
//   { timestamp: 1702316791, price: 53.29 },
//   { timestamp: 1702316895, price: 79.72 },
//   { timestamp: 1702316868, price: 93.17 },
//   { timestamp: 1702316890, price: 84.39 },
//   { timestamp: 1702316544, price: 71.01 },
//   { timestamp: 1702316822, price: 52.78 },
//   { timestamp: 1702316506, price: 59.47 },
//   { timestamp: 1702316615, price: 83.56 },
//   { timestamp: 1702316828, price: 59.04 },
// ];
	const input :any[]=transactionsData;
	console.log("We have the input=",input)

// Assuming input is your array of objects
input.sort((a, b) => a.timestamp - b.timestamp);

let data1 = [];
let interval = 5 * 60; // 5 minutes in seconds
let currentInterval = Math.floor(((input[0].timestamp)/1000000) / interval) * interval;
let currentIntervalData: { timestamp: number; price: number }[] = [];

for (let i = 0; i < input.length; i++) {
  let item = input[i];
  let itemInterval = Math.floor(((item.timestamp)/1000000) / interval) * interval;

  if (itemInterval === currentInterval) {
    currentIntervalData.push(item);
  } else {
    // Calculate open, high, low, close prices
    let open = currentIntervalData[0].price;
    let high = Math.max(...currentIntervalData.map((item) => item.price));
    let low = Math.min(...currentIntervalData.map((item) => item.price));
    let close = currentIntervalData[currentIntervalData.length - 1].price;

    data1.push({
      x: new Date(currentInterval).toISOString(),
      y: [open, high, low, close],
    });

    // Start a new interval
    currentInterval = itemInterval;
    currentIntervalData = [item];
  }
}
  
// Add the last interval
let open = currentIntervalData[0].price;
let high = Math.max(...currentIntervalData.map((item) => item.price));
let low = Math.min(...currentIntervalData.map((item) => item.price));
let close = currentIntervalData[currentIntervalData.length - 1].price;

data1.push({
  x: new Date(currentInterval).toISOString(),
  y: [open, high, low, close],
});
console.log("Here is my data1=",data1);
		setArr(data1);
			// setUserRegistered(true);
		} catch (e: any) {
			console.log("[fetchTxnInfo] Error and Interval: ", e)
			// setUserRegistered(false);
		}
	};

    useEffect(() => {
		fetchTxnInfo();
	}, [account?.address]);


	const register = async () => {
		if (!account) return [];
		setTransactionInProgress(true);
		// build a transaction payload to be submited
		const payload = {
			type: "entry_function_payload",
			function: `${moduleAddress}::${moduleName}::register`,
			type_arguments: [`0x1::aptos_coin::AptosCoin`, `${moduleAddress}::coins::${props.name}`],
			arguments: [],
		};
		try {
			const response = await wallet.signAndSubmitTransaction(payload);
			await provider.waitForTransaction(response.hash);
			setUserRegistered(true);
			// (window as any).history.push('/home')
		} catch (error: any) {
			console.log("Here is the error for register",error)
			setUserRegistered(false);
		} finally {
			setTransactionInProgress(false)
		}
	};

	useEffect(() => {
		fetchUserInfo();
	}, [account?.address]);




  return (
    <>
      <Box bg="green.100" minH="100vh">
      <Navbar/>
      <Spin spinning={transactionInProgress}>
      {!userRegistered ? (
					<Row gutter={[0, 32]} style={{ marginTop: "2rem" }}>
						<Col span={8} offset={8}>
							<Button onClick={register} block type="primary" className='bg-green-300 font-bold text-white'>
								Register
							</Button>
						</Col>
					</Row>
				) : (
      <div>
      <Flex direction="column" align="center" justify="center">
      <Box w="98%" bg="white" p="4" mt="4" borderRadius="lg" borderWidth="1px" boxShadow="lg">
      <Text fontSize='6xl' fontWeight="bold" textAlign="center">{props.name}/APT</Text>
      <Graph data={arr}/>
      </Box>
      <Grid templateColumns="4fr 1fr" gap={1} mt={8}>
      <GridItem >
      <Box bg="white" w="100%" p={4} borderRadius="lg" borderWidth="1px" boxShadow="lg"  >
      <Table name={props.name}/>
      </Box>
      </GridItem>
      <GridItem >
      <Box bg="white" w="100%" p={4} borderRadius="lg" borderWidth="1px" boxShadow="lg" >
        <Tabs colorScheme="blue">
          <TabList>
            <Tab width="50%">Limit</Tab>
            <Tab width="50%">Market</Tab>
          </TabList>
          <TabPanels>
            <TabPanel><Limit name={props.name} /></TabPanel>
            <TabPanel><Market name={props.name} /></TabPanel>
          </TabPanels>
        </Tabs>
      </Box>
      </GridItem>
      </Grid>
      </Flex>
      </div>
        )}
      </Spin>
      </Box>
    </>
  );
};

export default Cryptopage;
