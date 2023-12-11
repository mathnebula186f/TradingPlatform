import { useState } from 'react';
import {
  Box,
  FormControl,
  FormLabel,
  Input,
  Button,
  VStack,
} from '@chakra-ui/react';

const Market = () => {
  const [size, setSize] = useState('');
  const [error, setError] = useState('');

  const handleSell = async () => {
    // Basic validation
    if (!size) {
      setError('The fields are required');
      return;
    }

    // Reset error state
    setError('');

    // Perform actions with the submitted values
    // TODO : yaha pe button click karke sell
    try {
      // Send the data to the server
      const response = await axios.post('/post', {
        size,
      });

      // Handle the response (if needed)
      console.log('Server Response:', response.data);
    } catch (error) {
      // Handle any errors during the request
      console.error('Error:', error.message);
    }
  };

  const handleBuy = async () => {
    // Basic validation
    if (!size) {
      setError('The fields are required');
      return;
    }

    // Reset error state
    setError('');

    // Perform actions with the submitted values
    // TODO : yaha pe button click karke buy
    try {
      // Send the data to the server
      const response = await axios.post('/post', {
        size,
      });

      // Handle the response (if needed)
      console.log('Server Response:', response.data);
    } catch (error) {
      // Handle any errors during the request
      console.error('Error:', error.message);
    }
  };

  return (
    <VStack spacing={4} align="stretch" maxW="400px" mx="auto">
      <FormControl isRequired>
        <FormLabel htmlFor="size">Size</FormLabel>
        <Input
          type="number"
          id="size"
          placeholder="Enter size"
          value={size}
          onChange={(e) => setSize(e.target.value)}
        />
      </FormControl>

      {error && (
        <Box color="red.500" mt={2} textAlign="center">
          {error}
        </Box>
      )}

      <Button colorScheme="teal" onClick={handleBuy}>
        Buy
      </Button>
      <Button colorScheme="teal" onClick={handleSell}>
        Sell
      </Button>
    </VStack>
  );
};

export default Market;