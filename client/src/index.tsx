import { BrowserRouter, Routes, Route } from 'react-router-dom';
import ProfilePage from './components/ProfilePage';
import ReactDOM from 'react-dom/client';
import App from './App';
import { PetraWallet } from "petra-plugin-wallet-adapter";
import { AptosWalletAdapterProvider } from "@aptos-labs/wallet-adapter-react";
import { ChakraProvider } from '@chakra-ui/react';
import Home from './components/pages/Home';
import Cryptopage from './components/pages/Cryptopage';

const wallets = [new PetraWallet()];

const root = ReactDOM.createRoot(
	document.getElementById('root') as HTMLElement
);
root.render(
	<AptosWalletAdapterProvider plugins={wallets} autoConnect={false}>
		<ChakraProvider>
			<BrowserRouter>
				<Routes>
					<Route path="/" element={<App />} />
					<Route path="/profile" element={<ProfilePage />} />
					<Route path="/home" element={<Home />} />
					<Route path="/apt-usdt" element={<Cryptopage name={"APT/USDT"} />} />
					<Route path="/btc-usdt" element={<Cryptopage name={"BTC/USDT"} />} />
					<Route path="/eth-usdt" element={<Cryptopage name={"ETH/USDT"} />} />
				</Routes>
		</BrowserRouter>
		</ChakraProvider>
	</AptosWalletAdapterProvider>
);