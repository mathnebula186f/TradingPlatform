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

  const handleSell = () => {
    // Basic validation
    if (!size) {
      setError('The fields are required');
      return;
    }

    // Reset error state
    setError('');

    // Perform actions with the submitted values
    console.log('Size:', size);
  };

  const handleBuy = () => {
    // Basic validation
    if (!size) {
      setError('The fields are required');
      return;
    }

    // Reset error state
    setError('');

    // Perform actions with the submitted values
    console.log('Size:', size);
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