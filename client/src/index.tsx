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
					<Route path="/" element={<Home />} />
					<Route path="/a" element={<Cryptopage name={"A"} />} />
					<Route path="/b" element={<Cryptopage name={"B"} />} />
					<Route path="/c" element={<Cryptopage name={"C"} />} />
					<Route path="/d" element={<Cryptopage name={"D"} />} />
					<Route path="/e" element={<Cryptopage name={"E"} />} />
					<Route path="/f" element={<Cryptopage name={"F"} />} />
					<Route path="/g" element={<Cryptopage name={"G"} />} />
					<Route path="/h" element={<Cryptopage name={"H"} />} />
				</Routes>
		</BrowserRouter>
		</ChakraProvider>
	</AptosWalletAdapterProvider>
);