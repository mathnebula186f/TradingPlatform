import ReactApexChart from 'react-apexcharts';
import { constOptions } from './constOptions';

const Graph = (props) => {  
  console.log("here are the props in graph.js=",props.data);
  return (
    <ReactApexChart 
        series={
            [
                {data: props.data}
            ]
        }
        options={constOptions}
        type='candlestick'
    />
  )
}

export default Graph