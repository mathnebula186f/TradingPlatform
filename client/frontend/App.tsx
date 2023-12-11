import Cryptopage from "./Cryptopage";
import Home from "./Home";
import { Route, Routes } from 'react-router-dom';

function App() {
  return (
    <div>
      <Routes>
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
    </div>
  );
}

export default App;
