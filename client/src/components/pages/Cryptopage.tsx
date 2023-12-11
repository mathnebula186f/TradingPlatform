import React from 'react';
import { Text, Box } from '@chakra-ui/layout';
import { Tabs, Tab, TabIndicator, TabList, TabPanel, TabPanels } from '@chakra-ui/react';
import Graph from '../candlegraph/Graph';
import arr from '../candlegraph/output.mjs';
import Table from '../tables/Table';
import Limit from './Limit';
import Market from './Market';

interface CryptopageProps {
  name: string; 
}

const Cryptopage: React.FC<CryptopageProps> = (props) => {
  return (
    <>
      <Text fontSize='6xl' fontWeight="bold" textAlign="center">{props.name}</Text>
      <Graph data={arr}/>
      <Table />
      <Box bg="white" w="20%" p={4} borderRadius="lg" borderWidth="1px" style={{ position: 'absolute', display: 'inline-block' }} >
        <Tabs colorScheme="blue">
          <TabList>
            <Tab width="50%">Limit</Tab>
            <Tab width="50%">Market</Tab>
          </TabList>
          <TabPanels>
            <TabPanel><Limit /></TabPanel>
            <TabPanel><Market /></TabPanel>
          </TabPanels>
        </Tabs>
      </Box>
    </>
  );
};

export default Cryptopage;
