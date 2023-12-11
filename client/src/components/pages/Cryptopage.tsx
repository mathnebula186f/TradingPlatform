import React from 'react';
import Graph from '../candlegraph/Graph';
import arr from '../candlegraph/output.mjs';
import { Text } from '@chakra-ui/layout';
import Table from '../tables/Table'

interface CryptopageProps {
  name: string; 
}

const Cryptopage: React.FC<CryptopageProps> = (props) => {
  return (
    <>
      <Text fontSize='6xl' fontWeight="bold" textAlign="center">{props.name}</Text>
      <Graph data={arr}/>
      <Table />
    </>
  );
};

export default Cryptopage;
