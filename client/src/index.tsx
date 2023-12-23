import { BrowserRouter, Routes, Route } from 'react-router-dom';
import ProfilePage from './components/ProfilePage';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css'
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
	<div className='font-montserrat bg-green-100'>
	<AptosWalletAdapterProvider plugins={wallets} autoConnect={true}>
		<ChakraProvider>
			<BrowserRouter>
				<Routes>
					<Route path="/App" element={<App />} />
					<Route path="/profile" element={<ProfilePage />} />
					<Route path="/" element={<Home />} />
					<Route path="/usdt-apt" element={<Cryptopage name={"USDT"} />} />
					<Route path="/btc-apt" element={<Cryptopage name={"BTC"} />} />
					<Route path="/eth-apt" element={<Cryptopage name={"ETH"} />} />
				</Routes>
		</BrowserRouter>
		</ChakraProvider>
	</AptosWalletAdapterProvider>
	</div>
);