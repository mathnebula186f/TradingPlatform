const generateData = () => {
    const data = [];
  
    for (let i = 1; i <= 10; i++) {
      data.push({
        sno: i,
        price: Math.random() * 100, // Example random price
        sum: Math.random() * 1000,   // Example random sum
        size: Math.floor(Math.random() * 100), // Example random size as an integer
        status: i % 2 === 0 ? 'Active' : 'Inactive', // Example alternating status
      });
    }
  
    return data;
  };
  
  const tableData = generateData();
  console.log(tableData);
  