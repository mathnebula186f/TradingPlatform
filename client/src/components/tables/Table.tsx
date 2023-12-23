import { useEffect, useState } from 'react';
import { FilterMatchMode, FilterOperator, PrimeReactProvider } from 'primereact/api';
import { DataTable, DataTableFilterMeta } from 'primereact/datatable';
import { Column, ColumnFilterElementTemplateOptions } from 'primereact/column';
import { Dropdown, DropdownChangeEvent } from 'primereact/dropdown';
import { InputNumber, InputNumberChangeEvent } from 'primereact/inputnumber';
import { Tag } from 'primereact/tag';
import { List } from 'antd';
import {
  Box,
  FormControl,
  FormLabel,
  Input,
  Button,
  VStack,
} from '@chakra-ui/react';

// import txns from './data.mjs';
import 'primereact/resources/themes/lara-light-indigo/theme.css';
import 'primeflex/primeflex.css';                                   
import 'primeicons/primeicons.css';
import 'primereact/resources/primereact.css';                       
// import './style.css';
import { useWallet } from "@aptos-labs/wallet-adapter-react";
import { Provider, Network } from "aptos";

interface Transaction {
    sno: number;
    price: number;
    size: number;
    sum: number;
    status: string;
}

// interface MarketData {
//     buyOrders?: {
//         arr: {
//             fixedOrders: string[];
//             flexibleOrders: string[];
//             price: string;
//         }[];
//         type: number;
//     };
//     sellOrders?: {
//         arr: {
//             fixedOrders: string[];
//             flexibleOrders: string[];
//             price: string;
//         }[];
//         type: number;
//     };
// }

const defaultFilters: DataTableFilterMeta = {
  size: {
    operator: FilterOperator.AND,
    constraints: [{ value: null, matchMode: FilterMatchMode.EQUALS }],
  },
  price: {
    operator: FilterOperator.AND,
    constraints: [{ value: null, matchMode: FilterMatchMode.EQUALS }],
  },
  sum: {
    operator: FilterOperator.AND,
    constraints: [{ value: null, matchMode: FilterMatchMode.EQUALS }],
  },
  status: {
    operator: FilterOperator.OR,
    constraints: [{ value: null, matchMode: FilterMatchMode.EQUALS }],
  }
};


export const provider = new Provider(Network.DEVNET);
export const moduleAddress = "0x5ee007992ae8b720030c92f3fa5eb94be806858967a3359f99224e6bca65b7b1";
export const moduleName = "trading_platform";

interface AdvancedFilterDemoProps {
  name: string; 
}

interface UserResourceData {
    orders?: string[];
} 


const AdvancedFilterDemo: React.FC<AdvancedFilterDemoProps> = (props) => {
    const [filters, setFilters] = useState<DataTableFilterMeta>(defaultFilters);
    const [statuses] = useState<string[]>(['Unsold', 'Sold']);
    const [txns, setTxns] = useState([]);
    const [buyOrders, setBuyOrders] = useState<any[]>([]);
    const [sellOrders, setSellOrders] = useState<any[]>([]);
    const [userOrdersIds, setUserOrdersIds] = useState<string[]>([]);
    const [userOrdersInfo, setUserOrdersInfo] = useState<any[]>([]);
    const [txnHistory, setTxnHistory] = useState<any[]>([]);
    const { account } = useWallet();
    const wallet = (window as any).aptos;


    const getSeverity = (status: string) => {
        switch (status) {
            case 'Unsold':
                return 'danger';

            case 'Sold':
                return 'success';
        }
    };
    
    //DO FROM HERE

     const fetchUserInfo = async () => {
		if (!account) return [];
		try {
			const UserResource = await provider.getAccountResource(
				account.address,
				`${moduleAddress}::${moduleName}::UserResource<0x1::aptos_coin::AptosCoin,${moduleAddress}::coins::${props.name}>`
			);
			console.log("Here is the userinfo in table.tsx=",UserResource)
             const userOrdersData = (UserResource?.data as { orders?: string[] })?.orders || [];
            setUserOrdersIds(userOrdersData);
            // console.log("Here are the orders of users=",userOrdersData);
			// setUserRegistered(true);
		} catch (e: any) {
			console.log("[fetchUserInfo]: Error", e)
			// setUserRegistered(false);
		}
	};

    useEffect(() => {
		fetchUserInfo();
	}, [account?.address]);

    const fetchTxnInfo = async () => {
		if (!account) return [];
		try {
			const UserResource = await provider.getAccountResource(
				moduleAddress,
				`${moduleAddress}::${moduleName}::Market<0x1::aptos_coin::AptosCoin,${moduleAddress}::coins::${props.name}>`
			);
			console.log("Here is the txn info=",UserResource)
            const data: {
                buyOrders?: { arr: any[] };
                sellOrders?: { arr: any[] };
                transactions?: { price: string; timestamp: string }[];
            } = UserResource?.data || {};
            const buyOrdersData = data?.buyOrders?.arr || [];
            const sellOrdersData = data?.sellOrders?.arr || [];
            const transactionsData = data?.transactions || [];

            console.log("Buy Orders:", buyOrdersData);
            console.log("Sell Orders:", sellOrdersData);
            console.log("Txn History:",transactionsData);
            // setBuyOrders(buyOrdersData);
            // setSellOrders(sellOrdersData);
            const sortedBuyOrders = buyOrdersData.sort((a, b) => parseFloat(b.price) - parseFloat(a.price));
            const sortedSellOrders = sellOrdersData.sort((a, b) => parseFloat(a.price) - parseFloat(b.price));

            setBuyOrders(sortedBuyOrders);
            setSellOrders(sortedSellOrders);
            setTxnHistory(transactionsData);
			// setUserRegistered(true);
		} catch (e: any) {
			console.log("[fetchTxnInfo] Error: ", e)
			// setUserRegistered(false);
		}
	};

    useEffect(() => {
		fetchTxnInfo();
	}, [account?.address]);

    useEffect(() => {
        //TODO : Yaha pe graph ke liye txns ko fetch karo
    }, []);


    function StateToString(state: number):string{
        // console.log("Here is the state",state);
        if(state === 0){
            return 'Active';
        }
        else if(state ===1){
            return 'Filled';
        }
        else if(state ===2){
            return 'Cancelled';
        }
        else if(state ===3){
            return 'Partially Filled';
        }
        else {
            return 'Failed';
        }
    }

    const fetchUserOrdersInfo = async () => {
        const userOrdersWithPricesData: any[] = [];

        // Iterate over user orders and find corresponding prices from buy and sell orders
        await Promise.all(
        userOrdersIds.map(async (orderId) => {
            // const buyOrder = buyOrders.find((order) => order.id === orderId);
            // const sellOrder = sellOrders.find((order) => order.id === orderId);
            // try{
            const payload1 = {
			    arguments: [orderId],
			    function: `${moduleAddress}::order::price`,
			    type_arguments: [],
		    };
            const Price = await provider.view(payload1);
			// console.log("Here is the price info=",Price)
            // }
            // catch (e: any) {
			// console.log("Price Error: ", e)
			// // setUserRegistered(false);
		    // }
            // try{
            const payload2 = {
			    arguments: [orderId],
			    function: `${moduleAddress}::order::state`,
			    type_arguments: [],
		    };
            const State = await provider.view(payload2);
			// console.log("Here is the state info=",State)
            // }
            // catch (e: any) {
			// console.log("State Error: ", e)
			// // setUserRegistered(false);
		    // }
            
            const orderEntry = {
                    orderId,
                    price: Price,
                    state:State
                    // Add other relevant details if needed
                };
            userOrdersWithPricesData.push(orderEntry);
            // // Create an entry with order  details and prices
            // if (buyOrder || sellOrder) {
            //     console.log("Hiii")
            //     const orderEntry = {
            //         orderId,
            //         price: buyOrder ? buyOrder.price : sellOrder ? sellOrder.price : 0,
            //         // Add other relevant details if needed
            //     };
            //     userOrdersWithPricesData.push(orderEntry);
            // }
            //FETCH the PRICE from view Function here 
        })
        );
        console.log("User Orders Full Info=",userOrdersWithPricesData);
        // Update state with user orders and prices
        setUserOrdersInfo(userOrdersWithPricesData);
        console.log("Updatesdddd")
    };

    useEffect(() => {
        // Fetch user orders with prices when buyOrders, sellOrders, or userOrders change
        fetchUserOrdersInfo();
        // console.log("Here is  info",userOrdersInfo)
    }, [buyOrders, sellOrders, userOrdersIds]);

    const handleOrderClose = async (orderId: string, orderState: number) => {
  try {
    // Call your closeOrder function here passing orderId and orderState
    // Example: const result = await closeOrder(orderId, orderState);
    if(orderState===1 || orderState===3){
        //filled or partially fillled we have to call close_position
        const payload = {
			type: "entry_function_payload",
			function: `${moduleAddress}::${moduleName}::close_order`,
			type_arguments: [`0x1::aptos_coin::AptosCoin`,`${moduleAddress}::coins::${props.name}`],
			arguments: [Number(orderId)],
		};
        try {
      // Send the data to the server
      const response = await wallet.signAndSubmitTransaction(payload);
			// console.log(response)
			await provider.waitForTransaction(response.hash);
      // Handle the response (if needed)
      console.log('Close_order Done:', response.data);
      window.location.reload();
    } catch (error) {
      // Handle any errors during the request
      console.error('Error:', error);
    }

    }
    else{
        // call cancel_req
         const payload = {
			type: "entry_function_payload",
			function: `${moduleAddress}::${moduleName}::cancel_request`,
			type_arguments: [`0x1::aptos_coin::AptosCoin`,`${moduleAddress}::coins::${props.name}`],
			arguments: [Number(orderId)],
		};
        try {
      // Send the data to the server
      const response = await wallet.signAndSubmitTransaction(payload);
			// console.log(response)
			await provider.waitForTransaction(response.hash);
      // Handle the response (if needed)
      console.log('Cancel_request Done:', response.data);
      window.location.reload();
    } catch (error) {
      // Handle any errors during the request
      console.error('Error:', error);
    }

    }
    // After successfully closing the order, you may want to update the UI or fetch updated data
    // For example, you can refetch user orders info
    

    console.log(`Order ${orderId} closed successfully.`);
  } catch (error) {
    console.error(`Error closing order ${orderId}:`, error);
  }
};


    

    return (
       
        <PrimeReactProvider>
        {/* <h1>Hi</h1> */}
        <div className="flex flex-col items-center space-y-4">
            <div className="flex justify-between w-full space-x-4">
            <div className="w-1/3  p-2 rounded  shadow-md">
            <h2 className="text-3xl font-bold mb-2">Buy Orders</h2>
                <table  style={{ borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }}>
              <thead>
                <tr  className=" hover:bg-gray-50 transition duration-300" style={{border: '1px  white', borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)'}}>
                  <th className="p-3 text-1xl " style={{ borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }} >Price</th>
                  <th className="p-3 text-1xl" style={{ borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }} >Orders</th>
                  <th className="p-3 text-1xl" style={{ borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }} >Order IDs</th>
                </tr>
              </thead>
              <tbody>
                {buyOrders.map((order: any) => (
                  <tr key={order.id} style={{border: '1px  white', borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)'}} className=" hover:bg-gray-50 transition duration-300">
                    <td className="p-3" >{(order.price) / 100000000}</td>
                    <td className="p-3" >{order.fixedOrders.length + order.flexibleOrders.length}</td>
                    <td className="p-3" >{order.fixedOrders.concat(order.flexibleOrders).join(", ")}</td>
                  </tr>
                ))}
              </tbody>
            </table>

            </div>
                <div className="w-1/3  p-2 rounded shadow-md">
                {/* Display Sell Orders */}
                <h2 className="text-3xl font-bold mb-2">Sell Orders</h2>
                  <table  style={{ borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }}>
              <thead>
                <tr  className=" hover:bg-gray-50 transition duration-300" style={{border: '1px  white', borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)'}}>
                  <th className="p-3 text-1xl " style={{ borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }} >Price</th>
                  <th className="p-3 text-1xl" style={{ borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }} >Orders</th>
                  <th className="p-3 text-1xl" style={{ borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }} >Order IDs</th>
                </tr>
              </thead>
              <tbody>
                {sellOrders.map((order: any) => (
                  <tr key={order.id} style={{border: '1px  white', borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)'}} className=" hover:bg-gray-50 transition duration-300">
                    <td className="p-3" >{(order.price) / 100000000}</td>
                    <td className="p-3" >{order.fixedOrders.length + order.flexibleOrders.length}</td>
                    <td className="p-3" >{order.fixedOrders.concat(order.flexibleOrders).join(", ")}</td>
                  </tr>
                ))}
              </tbody>
            </table>
                {/* <List
                    bordered
                    dataSource={sellOrders}
                    style={{ border: '3px solid',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }}
                    renderItem={(order: any) => (
                        <List.Item >
                            Price: {(order.price)/100000000}, Orders: {order.fixedOrders.length + order.flexibleOrders.length}, 
                            Order IDs: {order.fixedOrders.concat(order.flexibleOrders).join(", ")}
                        </List.Item>
                    )}
                /> */}
                </div>
                <div className="w-1/3  p-2 rounded shadow-md">
                <h2 className="text-3xl font-bold mb-2">User Orders</h2>
                {/* <h1>Hi</h1> */}
                <table  style={{ borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }}>
              <thead>
                <tr  className=" hover:bg-gray-50 transition duration-300" style={{border: '1px  white', borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)'}}>
                  <th className="p-3 text-1xl " style={{ borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }} >Price</th>
                  <th className="p-3 text-1xl" style={{ borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }} >Order ID's</th>
                  <th className="p-3 text-1xl" style={{ borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }} >State</th>
                  <th className="p-3 text-1xl" style={{ borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }} ></th>
                </tr>
              </thead>
              <tbody>
                {userOrdersInfo.map((order: any) => (
                  <tr key={order.id} style={{border: '1px  white', borderRadius: '8px',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)'}} className=" hover:bg-gray-50 transition duration-300">
                    <td className="p-3" >{(order.price) / 100000000}</td>
                    <td className="p-3" >{order.orderId}</td>
                    <td className="p-3" >{StateToString(order.state[0])}</td>
                    <td className="p-3" ><Button className="bg-green-300 text-white px-4 py-2 rounded-md" onClick={() => handleOrderClose(order.orderId, Number(order.state[0]))}>Close Order</Button></td>
                  </tr>
                ))}
              </tbody>
            </table>
                {/* <List
                    bordered
                    dataSource={userOrdersInfo}
                    style={{ border: '3px solid',boxShadow: '0 8px 12px -4px rgba(0, 0, 0, 0.2), 0 4px 6px -2px rgba(0, 0, 0, 0.1)' }}                   
                    renderItem={(order: any ) => {
                        // console.log("Here is the frontEnd=",order);

                        return(
                            <List.Item style={{ display: 'flex', justifyContent: 'space-between', background: 'green-100', alignItems: 'center' }}>
                            <div>Order ID: {order.orderId}, Price: {(order.price)/100000000} , State:{StateToString(order.state[0])}</div>
                            <Button className="bg-green-300 text-white px-4 py-2 rounded-md" onClick={() => handleOrderClose(order.orderId, Number(order.state[0]))}>Close Order</Button>

                            </List.Item>
                        );
                        
                    }}
                /> */}
                </div>
                {/* <h2>User Orders</h2>
                <List
                    bordered
                    dataSource={userOrdersIds}
                    renderItem={(orderId: string) => {
                        const buyOrder = buyOrders.find((order) => order.fixedOrders.includes(orderId) || order.flexibleOrders.includes(orderId));
                        const sellOrder = sellOrders.find((order) => order.fixedOrders.includes(orderId) || order.flexibleOrders.includes(orderId));
                        const orderPrice = buyOrder?.price || sellOrder?.price || 'Price not available';
                        const orderType = buyOrder ? 'Buy Order' : (sellOrder ? 'Sell Order' : 'Order Type not available');

                        return (
                            <List.Item style={{ background: 'lightblue' }}>
                                Order ID: {orderId}, Price: {orderPrice},Type: {orderType}
                            </List.Item>
                        );
                    }}
                /> */}
            {/* <DataTable value={txns} paginator showGridlines rows={10} rowsPerPageOptions={[5, 10, 25, 50]} dataKey="id" 
                    filters={filters} globalFilterFields={['owner_address']} emptyMessage="No transactions found.">
                <Column field='sno' header="S.No." style={{ minWidth: '0.1rem' }} />
                <Column field="price" header="Price" filterField="value" dataType="numeric" style={{ minWidth: '10rem' }} body={priceBodyTemplate} filter filterElement={priceFilterTemplate} />
                <Column field="sum" header="Sum" filterField="value" dataType="numeric" style={{ minWidth: '10rem' }} body={sumBodyTemplate} filter filterElement={sumFilterTemplate} />
                <Column field="size" header="Size" filterField="value" dataType="numeric" style={{ minWidth: '10rem' }} body={sizeBodyTemplate} filter filterElement={sizeFilterTemplate} />
                <Column field="status" header="Status" filterMenuStyle={{ width: '14rem' }} style={{ minWidth: '12rem' }} body={statusBodyTemplate} filter filterElement={statusFilterTemplate} />
            </DataTable> */}
        </div>
        </div>
        </PrimeReactProvider>
    );
}

export default AdvancedFilterDemo;