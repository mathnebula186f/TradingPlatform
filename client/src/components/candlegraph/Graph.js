import ReactApexChart from 'react-apexcharts';
import { constOptions } from './constOptions';

const Graph = (props) => {  
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