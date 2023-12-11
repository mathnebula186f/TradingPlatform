import { useEffect, useState } from 'react';
import { FilterMatchMode, FilterOperator, PrimeReactProvider } from 'primereact/api';
import { DataTable, DataTableFilterMeta } from 'primereact/datatable';
import { Column, ColumnFilterElementTemplateOptions } from 'primereact/column';
import { Dropdown, DropdownChangeEvent } from 'primereact/dropdown';
import { InputNumber, InputNumberChangeEvent } from 'primereact/inputnumber';
import { Tag } from 'primereact/tag';
// import txns from './data.mjs';
import 'primereact/resources/themes/lara-light-indigo/theme.css';
import 'primeflex/primeflex.css';                                   
import 'primeicons/primeicons.css';
import 'primereact/resources/primereact.css';                       
import './style.css';

interface Transaction {
    sno: number;
    price: number;
    size: number;
    sum: number;
    status: string;
}

const defaultFilters: DataTableFilterMeta = {
  size: {
    operator: FilterOperator.AND,
    constraints: [{ value: null, matchMode: FilterMatchMode.EQUALS }],
  },
  price: {
    operator: FilterOperator.AND,
    constraints: [{ value: null, matchMode: FilterMatchMode.EQUALS }],
  },
  sum: {
    operator: FilterOperator.AND,
    constraints: [{ value: null, matchMode: FilterMatchMode.EQUALS }],
  },
  status: {
    operator: FilterOperator.OR,
    constraints: [{ value: null, matchMode: FilterMatchMode.EQUALS }],
  }
};

export default function AdvancedFilterDemo() {
    const [filters, setFilters] = useState<DataTableFilterMeta>(defaultFilters);
    const [statuses] = useState<string[]>(['Unsold', 'Sold']);
    const [txns, setTxns] = useState([]);

    const getSeverity = (status: string) => {
        switch (status) {
            case 'Unsold':
                return 'danger';

            case 'Sold':
                return 'success';
        }
    };
    
    useEffect(() => {
        //TODO : Yaha pe graph ke liye txns ko fetch karo
      }, []);

    const formatCurrency = (value: number) => {
        return value.toLocaleString('en-US', { style: 'currency', currency: 'USD' });
    };

    const priceBodyTemplate = (rowData: Transaction) => {
        return formatCurrency(rowData.price);
    };
    
    const sizeBodyTemplate = (rowData: Transaction) => {
        return formatCurrency(rowData.price);
    };

    const sumBodyTemplate = (rowData: Transaction) => {
        return formatCurrency(rowData.price);
    };

    const priceFilterTemplate = (options: ColumnFilterElementTemplateOptions) => {
        return <InputNumber value={options.value} onChange={(e: InputNumberChangeEvent) => options.filterCallback(e.value, options.index)} mode="currency" currency="USD" locale="en-US" />;
    };

    const sizeFilterTemplate = (options: ColumnFilterElementTemplateOptions) => {
        return <InputNumber value={options.value} onChange={(e: InputNumberChangeEvent) => options.filterCallback(e.value, options.index)} mode="currency" currency="USD" locale="en-US" />;
    };

    const sumFilterTemplate = (options: ColumnFilterElementTemplateOptions) => {
        return <InputNumber value={options.value} onChange={(e: InputNumberChangeEvent) => options.filterCallback(e.value, options.index)} mode="currency" currency="USD" locale="en-US" />;
    };

    const statusBodyTemplate = (rowData: Transaction) => {
        return <Tag value={rowData.status} severity={getSeverity(rowData.status)} />;
    };

    const statusFilterTemplate = (options: ColumnFilterElementTemplateOptions) => {
        return <Dropdown value={options.value} options={statuses} onChange={(e: DropdownChangeEvent) => options.filterCallback(e.value, options.index)} itemTemplate={statusItemTemplate} placeholder="Select One" className="p-column-filter" showClear />;
    };

    const statusItemTemplate = (option: string) => {
        return <Tag value={option} severity={getSeverity(option)} />;
    };

    return (
        <PrimeReactProvider>
        <div className="card">
            <DataTable value={txns} paginator showGridlines rows={10} rowsPerPageOptions={[5, 10, 25, 50]} dataKey="id" 
                    filters={filters} globalFilterFields={['owner_address']} emptyMessage="No transactions found.">
                <Column field='sno' header="S.No." style={{ minWidth: '0.1rem' }} />
                <Column field="price" header="Price" filterField="value" dataType="numeric" style={{ minWidth: '10rem' }} body={priceBodyTemplate} filter filterElement={priceFilterTemplate} />
                <Column field="sum" header="Sum" filterField="value" dataType="numeric" style={{ minWidth: '10rem' }} body={sumBodyTemplate} filter filterElement={sumFilterTemplate} />
                <Column field="size" header="Size" filterField="value" dataType="numeric" style={{ minWidth: '10rem' }} body={sizeBodyTemplate} filter filterElement={sizeFilterTemplate} />
                <Column field="status" header="Status" filterMenuStyle={{ width: '14rem' }} style={{ minWidth: '12rem' }} body={statusBodyTemplate} filter filterElement={statusFilterTemplate} />
            </DataTable>
        </div>
        </PrimeReactProvider>
    );
}