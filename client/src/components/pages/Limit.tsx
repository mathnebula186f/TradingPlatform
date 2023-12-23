import { useState } from 'react';
import {
  Box,
  FormControl,
  FormLabel,
  Input,
  Button,
  VStack,
} from '@chakra-ui/react';
import { Checkbox } from 'antd';
import { useWallet } from "@aptos-labs/wallet-adapter-react";
import { Provider, Network } from "aptos";



export const provider = new Provider(Network.DEVNET);
export const moduleAddress = "0x5ee007992ae8b720030c92f3fa5eb94be806858967a3359f99224e6bca65b7b1";
export const moduleName = "trading_platform";

interface AdvancedFilterDemoProps {
  name: string; 
}

const Limit: React.FC<AdvancedFilterDemoProps> = (props) => {
  const [price , setPrice] = useState('');
  const [units, setUnits] = useState('');
  // const [size, setSize] = useState('');
  const [error, setError] = useState('');
  const [atomic, setAtomic] = useState(false); // Default value for the checkbox
  const { account } = useWallet();
  const wallet = (window as any).aptos;


  const handleBuy = async () => {
    // Basic validation
    if (!price || !units) {
      setError('Both fields are required');
      return;
    }

    // Reset error state
    setError('');

    // Perform actions with the submitted values
    // TODO : yaha pe button click karke buy
    console.log("Here is the buy price=",Number(price));
    const payload = {
			type: "entry_function_payload",
			function: `${moduleAddress}::${moduleName}::limit_long`,
			type_arguments: [`0x1::aptos_coin::AptosCoin`,`${moduleAddress}::coins::${props.name}`],
			arguments: [(Number(price)*100000000),Number(units),!atomic],
		};
    try {
      // Send the data to the server
      const response = await wallet.signAndSubmitTransaction(payload);
			// console.log(response)
			await provider.waitForTransaction(response.hash);

      // Handle the response (if needed)
      console.log('Server Response:', response.data);
      window.location.reload();
    } catch (error) {
      // Handle any errors during the request
      console.error('Error:', error);
    }
  };

  const handleSell = async () => {
    // Basic validation
    if (!price || !units) {
      setError('Both fields are required');
      return;
    }

    // Reset error state
    setError('');

    // Perform actions with the submitted values
    // TODO : yaha pe button click karke sell
    const payload = {
			type: "entry_function_payload",
			function: `${moduleAddress}::${moduleName}::limit_short`,
			type_arguments: [`0x1::aptos_coin::AptosCoin`,`${moduleAddress}::coins::${props.name}`],
			arguments: [(Number(price)*100000000),Number(units),!atomic],
		};
    try {
      // Send the data to the server
      const response = await wallet.signAndSubmitTransaction(payload);
			// console.log(response)
			await provider.waitForTransaction(response.hash);
      // Handle the response (if needed)
      console.log('Server Response:', response.data);
      window.location.reload();
    } catch (error) {
      // Handle any errors during the request
      console.error('Error:', error);
    }
  };

  return (
    <VStack spacing={4} align="stretch" maxW="400px" mx="auto">
      <FormControl isRequired>
        <FormLabel htmlFor="price">Price</FormLabel>
        <Input
          type="number"
          id="price"
          placeholder="Enter price"
          value={price}
          onChange={(e) => setPrice(e.target.value)}
        />
      </FormControl>

      <FormControl isRequired>
        <FormLabel htmlFor="units">Units</FormLabel>
        <Input
          type="number"
          id="units"
          placeholder="Enter units"
          value={units}
          onChange={(e) => setUnits(e.target.value)}
        />
      </FormControl>

      <FormControl>
        <Checkbox
          id="atomic"
          // isChecked={atomic}
          onChange={(e) => setAtomic(e.target.checked)}
        >
          Atomic
        </Checkbox>
      </FormControl>

      {error && (
        <Box color="red.500" mt={2} textAlign="center">
          {error}
        </Box>
      )}

      <Button  className='bg-green-300 text-white' onClick={handleBuy}>
        Buy
      </Button>
      <Button className='bg-green-300 text-white' onClick={handleSell}>
        Sell
      </Button>
    </VStack>
  );
};

export default Limit;