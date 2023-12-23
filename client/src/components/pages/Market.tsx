import { useState } from 'react';
import {
  Box,
  FormControl,
  FormLabel,
  Input,
  Button,
  VStack,
} from '@chakra-ui/react';
import { useWallet } from "@aptos-labs/wallet-adapter-react";
import { Provider, Network } from "aptos";

export const provider = new Provider(Network.DEVNET);
export const moduleAddress = "0x5ee007992ae8b720030c92f3fa5eb94be806858967a3359f99224e6bca65b7b1";
export const moduleName = "trading_platform";

interface AdvancedFilterDemoProps {
  name: string; 
}



const Market: React.FC<AdvancedFilterDemoProps>  = (props) => {
  const [amount, setAmount] = useState('');
  const [error, setError] = useState('');
  const { account } = useWallet();
  const wallet = (window as any).aptos;

  const handleSell = async () => {
    // Basic validation
    if (!amount) {
      setError('The fields are required');
      return;
    }

    // Reset error state
    setError('');

    // Perform actions with the submitted values
    // TODO : yaha pe button click karke sell
    const payload = {
			type: "entry_function_payload",
			function: `${moduleAddress}::${moduleName}::market_short`,
			type_arguments: [`0x1::aptos_coin::AptosCoin`,`${moduleAddress}::coins::${props.name}`],
			arguments: [Number(amount)*100000000],
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

  const handleBuy = async () => {
    // Basic validation
    if (!amount) {
      setError('The fields are required');
      return;
    }

    // Reset error state
    setError('');

    // Perform actions with the submitted values
    // TODO : yaha pe button click karke buy
    const payload = {
			type: "entry_function_payload",
			function: `${moduleAddress}::${moduleName}::market_long`,
			type_arguments: [`0x1::aptos_coin::AptosCoin`,`${moduleAddress}::coins::${props.name}`],
			arguments: [Number(amount)*100000000],
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
        <FormLabel htmlFor="amount">Amount</FormLabel>
        <Input
          type="number"
          id="amount"
          placeholder="Enter amount"
          value={amount}
          onChange={(e) => setAmount(e.target.value)}
        />
      </FormControl>

      {error && (
        <Box color="red.500" mt={2} textAlign="center">
          {error}
        </Box>
      )}

      <Button className='bg-green-300 text-white' onClick={handleBuy}>
        Buy
      </Button>
      <Button className='bg-green-300 text-white' onClick={handleSell}>
        Sell
      </Button>
    </VStack>
  );
};

export default Market;