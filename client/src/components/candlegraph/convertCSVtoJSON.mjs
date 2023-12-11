import fs from 'fs';
import { parse } from 'csv-parse';

const csvFilePath = 'src/data.csv'

const csvData = fs.readFileSync(csvFilePath, 'utf8');

parse(csvData, { columns: true, skip_empty_lines: true }, (err, records) => {
  if (err) {
    console.error(err);
    return;
  }

  // Transform the data as needed
  const data = records.map(record => ({
    open_time: Number(record.open_time),
    open: Number(record.open),
    high: Number(record.high),
    low: Number(record.low),
    close: Number(record.close),
    volume: Number(record.volume),
    close_time: Number(record.close_time),
  }));

  const transformedArr = data.map((item) => ({
    x: new Date(item.open_time),
    y: [item.open, item.high, item.low, item.close],
  }));

  const outputFilePath = 'src/output.mjs';

  fs.writeFileSync(outputFilePath,"const arr = "); 
  fs.appendFileSync(outputFilePath, JSON.stringify(transformedArr, null, 2));
  fs.appendFileSync(outputFilePath, ";\nexport default arr;");
  console.log(`Data has been written to ${outputFilePath}`);
});