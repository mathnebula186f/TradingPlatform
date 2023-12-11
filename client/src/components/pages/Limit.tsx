import { useState } from 'react';
import {
  Box,
  FormControl,
  FormLabel,
  Input,
  Button,
  VStack,
} from '@chakra-ui/react';

const Limit = () => {
  const [price, setPrice] = useState('');
  const [size, setSize] = useState('');
  const [error, setError] = useState('');

  const handleSubmit = () => {
    // Basic validation
    if (!price || !size) {
      setError('Both fields are required');
      return;
    }

    // Reset error state
    setError('');

    // Perform actions with the submitted values
    console.log('Price:', price);
    console.log('Size:', size);
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

      <Button colorScheme="teal" onClick={handleSubmit}>
        Buy/Sell
      </Button>
    </VStack>
  );
};

export default Limit;