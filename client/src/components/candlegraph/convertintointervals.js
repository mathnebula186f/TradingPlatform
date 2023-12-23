const input = [
  { timestamp: 1702316485, price: 97.14 },
  { timestamp: 1702316710, price: 78.43 },
  { timestamp: 1702316745, price: 99.72 },
  { timestamp: 1702316868, price: 85.85 },
  { timestamp: 1702316722, price: 85.18 },
  { timestamp: 1702317045, price: 50.77 },
  { timestamp: 1702316580, price: 54.62 },
  { timestamp: 1702316526, price: 72.83 },
  { timestamp: 1702316483, price: 85.44 },
  { timestamp: 1702316977, price: 79.21 },
  { timestamp: 1702316739, price: 55.71 },
  { timestamp: 1702316791, price: 53.29 },
  { timestamp: 1702316895, price: 79.72 },
  { timestamp: 1702316868, price: 93.17 },
  { timestamp: 1702316890, price: 84.39 },
  { timestamp: 1702316544, price: 71.01 },
  { timestamp: 1702316822, price: 52.78 },
  { timestamp: 1702316506, price: 59.47 },
  { timestamp: 1702316615, price: 83.56 },
  { timestamp: 1702316828, price: 59.04 },
];

// Assuming input is your array of objects
input.sort((a, b) => a.timestamp - b.timestamp);

let data = [];
let interval = 5 * 60; // 5 minutes in seconds
let currentInterval = Math.floor(input[0].timestamp / interval) * interval;
let currentIntervalData = [];

for (let i = 0; i < input.length; i++) {
  let item = input[i];
  let itemInterval = Math.floor(item.timestamp / interval) * interval;

  if (itemInterval === currentInterval) {
    currentIntervalData.push(item);
  } else {
    // Calculate open, high, low, close prices
    let open = currentIntervalData[0].price;
    let high = Math.max(...currentIntervalData.map((item) => item.price));
    let low = Math.min(...currentIntervalData.map((item) => item.price));
    let close = currentIntervalData[currentIntervalData.length - 1].price;

    data.push({
      x: new Date(currentInterval).toISOString(),
      y: [open, high, low, close],
    });

    // Start a new interval
    currentInterval = itemInterval;
    currentIntervalData = [item];
  }
}
  
// Add the last interval
let open = currentIntervalData[0].price;
let high = Math.max(...currentIntervalData.map((item) => item.price));
let low = Math.min(...currentIntervalData.map((item) => item.price));
let close = currentIntervalData[currentIntervalData.length - 1].price;

data.push({
  x: new Date(currentInterval).toISOString(),
  y: [open, high, low, close],
});
console.log(data);