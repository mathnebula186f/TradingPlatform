import Navbar from "./Navbar/Navbar";
import React from 'react';
import { WalletSelector } from "@aptos-labs/wallet-adapter-ant-design";
import "@aptos-labs/wallet-adapter-ant-design/dist/index.css";

function ProfilePage() {
    const wallet = (window as any).aptos;
    const [address, setAddress] = React.useState<string | null>(null);

    const init = async() => {
        
        // connect
        const { address, publicKey } = await wallet.connect();
        setAddress(address);
      }
      
      React.useEffect(() => {
         init();
      }, []);
    
      return (
        <div>
            <Navbar/>
            {
                address === null ? <p>Wallet Not Connected</p> : <p>Account Address: <code>{ address }</code></p>
            }
          
        </div>
      );
}
export default ProfilePage;