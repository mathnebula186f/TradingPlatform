import { Wrap, WrapItem, Button, Text } from '@chakra-ui/react';
import { Link } from 'react-router-dom';
import Sidebar from './Sidebar';

const tokenNames = ["APT-USDT", "BTC-USDT", "ETH-USDT"];
const colors = ["red", "orange", "yellow", "green", "teal", "blue", "cyan", "purple", "pink", "linkedin", "facebook", "messenger", "whatsapp", "twitter", "telegram"];

const Home = () => {
  return (
    <>
      <Sidebar/>
      <Text fontSize='6xl' fontWeight="bold" textAlign="center" marginBlockEnd='15%' marginBlockStart='20px'>APTOS APP</Text>
      <Wrap spacing='30px' justify='center'>
        {tokenNames.map((tokenName, index) => (
          <WrapItem key={tokenName} as={Button} size='lg' style={{ padding: '0', height: '100px' }}>
            <Button as={Link} to={`/${tokenName.toLowerCase()}`} colorScheme={colors[index]} style={{ width: '200px', height: '100px' }}>
              {tokenName}
            </Button>
          </WrapItem>
        ))}
      </Wrap>
    </>
  );
};

export default Home;