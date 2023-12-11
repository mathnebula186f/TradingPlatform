import React, { useState } from 'react';
import { FilterMatchMode, FilterOperator, PrimeReactProvider } from 'primereact/api';
import { DataTable, DataTableFilterMeta } from 'primereact/datatable';
import { Column, ColumnFilterElementTemplateOptions } from 'primereact/column';
import { InputText } from 'primereact/inputtext';
import { Dropdown, DropdownChangeEvent } from 'primereact/dropdown';
import { InputNumber, InputNumberChangeEvent } from 'primereact/inputnumber';
import { Button } from 'primereact/button';
import { Calendar } from 'primereact/calendar';
import { Tag } from 'primereact/tag';
import txns from './data.mjs';
import 'primereact/resources/themes/lara-light-indigo/theme.css';
import 'primeflex/primeflex.css';                                   
import 'primeicons/primeicons.css';
import 'primereact/resources/primereact.css';                       
import './style.css';

interface Transaction {
    sno: number;
    value: number;
    date: string;
    owner_address: string;
    status: string;
}

const defaultFilters: DataTableFilterMeta = {
  global: { value: null, matchMode: FilterMatchMode.CONTAINS },
  owner_address: {
    operator: FilterOperator.AND,
    constraints: [{ value: null, matchMode: FilterMatchMode.STARTS_WITH }],
  },
  date: {
    operator: FilterOperator.AND,
    constraints: [{ value: null, matchMode: FilterMatchMode.DATE_IS }],
  },
  value: {
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
    const [globalFilterValue, setGlobalFilterValue] = useState<string>('');
    const [statuses] = useState<string[]>(['Unsold', 'Sold']);

    const getSeverity = (status: string) => {
        switch (status) {
            case 'Unsold':
                return 'danger';

            case 'Sold':
                return 'success';
        }
    };
    
    const formatDate = (value: Date) => {
        return value.toLocaleDateString('en-US', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric'
        });
    };

    const formatCurrency = (value: number) => {
        return value.toLocaleString('en-US', { style: 'currency', currency: 'USD' });
    };

    const clearFilter = () => {
        initFilters();
    };

    const onGlobalFilterChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const value = e.target.value;
        let _filters = { ...filters };

        // @ts-ignore
        _filters['global'].value = value;

        setFilters(_filters);
        setGlobalFilterValue(value);
    };

    const initFilters = () => {
        setFilters(defaultFilters);
        setGlobalFilterValue('');
    };

    const renderHeader = () => {
        return (
            <div className="flex justify-content-between">
                <Button type="button" icon="pi pi-filter-slash" label="Clear" outlined onClick={clearFilter} />
                <span className="p-input-icon-left">
                    <i className="pi pi-search" />
                    <InputText value={globalFilterValue} onChange={onGlobalFilterChange} placeholder="Address Search" />
                </span>
            </div>
        );
    };

    const dateBodyTemplate = (rowData: Transaction) => {
        return formatDate(new Date(rowData.date));
    };

    const dateFilterTemplate = (options: ColumnFilterElementTemplateOptions) => {
        return (
            <Calendar
                value={options.value as Date}
                onChange={(e) => options.filterCallback(e.value as Date, options.index)}
                dateFormat="mm/dd/yy"
                placeholder="mm/dd/yyyy"
                mask="99/99/9999"
            />
        );
    };
    

    const balanceBodyTemplate = (rowData: Transaction) => {
        return formatCurrency(rowData.value);
    };

    const balanceFilterTemplate = (options: ColumnFilterElementTemplateOptions) => {
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

    const header = renderHeader();

    return (
        <PrimeReactProvider>
        <div className="card">
            <DataTable value={txns} paginator showGridlines rows={10} rowsPerPageOptions={[5, 10, 25, 50]} dataKey="id" 
                    filters={filters} globalFilterFields={['owner_address']} header={header}
                    emptyMessage="No transactions found.">
                <Column field='sno' header="S.No." style={{ minWidth: '0.1rem' }} />
                <Column field="owner_address" header="Address of Owner Party" filter filterPlaceholder="Search by name" style={{ minWidth: '12rem' }} />
                <Column field="value" header="Value Traded" filterField="value" dataType="numeric" style={{ minWidth: '10rem' }} body={balanceBodyTemplate} filter filterElement={balanceFilterTemplate} />
                <Column field="date" header="Due Date" filterField="date" dataType="date" style={{ minWidth: '10rem' }} body={dateBodyTemplate} filter filterElement={dateFilterTemplate} />
                <Column field="status" header="Status" filterMenuStyle={{ width: '14rem' }} style={{ minWidth: '12rem' }} body={statusBodyTemplate} filter filterElement={statusFilterTemplate} />
            </DataTable>
        </div>
        </PrimeReactProvider>
    );
}