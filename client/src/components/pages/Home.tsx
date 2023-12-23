import { Wrap, WrapItem, Button, Text, Box } from '@chakra-ui/react';
import { Link } from 'react-router-dom';
import Sidebar from './Sidebar';
import { Provider, Network } from "aptos";
import { useWallet } from "@aptos-labs/wallet-adapter-react";
import { useEffect, useState } from "react";
import Navbar from "../Navbar/Navbar";
import Lottie from 'react-lottie';
import { motion } from 'framer-motion';
import animationData from "../lottie/Home.json"
import animationDataLeft from "../lottie/LeftHome.json"

const tokenNames = ["USDT-APT", "BTC-APT", "ETH-APT"];
const colors = ["red", "orange", "yellow", "green", "teal", "blue", "cyan", "purple", "pink", "linkedin", "facebook", "messenger", "whatsapp", "twitter", "telegram"];

export const provider = new Provider(Network.DEVNET);
export const moduleAddress = "0x5ee007992ae8b720030c92f3fa5eb94be806858967a3359f99224e6bca65b7b1";
export const moduleName = "trading_platform";

const Home = () => {
  const { account } = useWallet();
	const wallet = (window as any).aptos;
  const [userRegistered, setUserRegistered] = useState<boolean>(false);

  const fetchUserInfo = async () => {
		if (!account) return [];
		try {
			const UserResource = await provider.getAccountResource(
				account.address,
				`${moduleAddress}::${moduleName}::UserResource<0x1::aptos_coin::AptosCoin,${moduleAddress}::coins::BTC>`
			);
			console.log(UserResource);
			setUserRegistered(true);
		} catch (e: any) {
			console.log("[fetchUserInfo]: ", e);
			setUserRegistered(false);
		}
	};

  useEffect(() => {
		fetchUserInfo();
	}, [account?.address]);

  return (
    <>
      <Navbar />
      <Box bg="green.100" minH="100vh" display="flex" >
         <Box flex="1" p="4">
          <motion.div initial={{ scale: 0.8 }} animate={{ scale: 1 }} transition={{ duration: 2, yoyo: Infinity }}>
            <Lottie options={{ loop: true, autoplay: true, animationData: animationDataLeft, rendererSettings: { preserveAspectRatio: 'xMidYMid slice' } }} height={700} width={700} />
          </motion.div>
        </Box>
        {/* <Sidebar /> */}
        <Box flex="2" p="4">
        <Box textAlign="center" mt="20px">
          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 1 }}>
            <Text fontSize='6xl' fontWeight="bold" textAlign="center" mb='10'>
              SELECT THE CARD TO START TRADING!
            </Text>
          </motion.div>
          <motion.div initial={{ scale: 0.8 }} animate={{ scale: 1 }} transition={{ duration: 2, yoyo: Infinity }}>
            <Lottie options={{ loop: true, autoplay: true, animationData, rendererSettings: { preserveAspectRatio: "xMidYMid slice" } }} height={200} width={200} />
          </motion.div>
        </Box>
        <Wrap spacing='30px' justify='center' p={4} minH="60vh">
          {tokenNames.map((tokenName, index) => (
            <WrapItem key={tokenName}>
              <motion.div initial={{ scale: 0.8 }} animate={{ scale: 1 }} transition={{ duration: 2, yoyo: Infinity }}>
                <Button as={Link} to={`/${tokenName.toLowerCase()}`} colorScheme={colors[index]} size="lg" style={{ width: '200px', height: '100px' }}>
                  {tokenName}
                </Button>
              </motion.div>
            </WrapItem>
          ))}
        </Wrap>
        {/* <motion.div initial={{ scale: 0.8 }} animate={{ scale: 1 }} transition={{ duration: 2, yoyo: Infinity }}>
          <Lottie options={{ loop: true, autoplay: true, animationData, rendererSettings: { preserveAspectRatio: "xMidYMid slice" } }} height={700} width={700} />
        </motion.div> */}
      </Box>
      </Box>
    </>
  );
};

export default Home;
