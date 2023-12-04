import React from 'react'
import { DataGrid } from '@mui/x-data-grid';
import { Box, Button, FormControl, InputLabel, MenuItem, Select, Stack, TextField, Typography } from '@mui/material';


const Dietaryintake = () => {
    
const columns = [
    { field: 'SL.NO', headerName: 'SL.NO', width: 70 },
    { field: 'Name', headerName: 'NAME', width: 130 },
    { field: 'Gender', headerName: 'GENDER', width: 130 },
    {
        field: 'email',
        headerName: 'EMAIL',
        width: 140,
    },
    {
        field: 'phone',
        headerName: 'PHONE NUMBER',
        description: 'This column has a value getter and is not sortable.',
        sortable: false,
        width: 180,

    },
    {
        field: 'Action',
        headerName: 'Full name',
        description: 'This column has a value getter and is not sortable.',
        sortable: false,
        width: 160,

    },
];

const rows = [
    { id: 1, lastName: 'Snow', firstName: 'Jon', age: 35 },
    { id: 2, lastName: 'Lannister', firstName: 'Cersei', age: 42 },
    { id: 3, lastName: 'Lannister', firstName: 'Jaime', age: 45 },
    { id: 4, lastName: 'Stark', firstName: 'Arya', age: 16 },
    { id: 5, lastName: 'Targaryen', firstName: 'Daenerys', age: null },
    { id: 6, lastName: 'Melisandre', firstName: null, age: 150 },
    { id: 7, lastName: 'Clifford', firstName: 'Ferrara', age: 44 },
    { id: 8, lastName: 'Frances', firstName: 'Rossini', age: 36 },
    { id: 9, lastName: 'Roxie', firstName: 'Harvey', age: 65 },
];

    return (
        <div>
            <Typography variant="h4" gutterBottom>
            DietaryIntake
            </Typography>
            <Box
                component="form"
                sx={{
                    '& > :not(style)': { m: 4, width: '100%' },
                }}
                noValidate
                autoComplete="off"
            >

                <Stack spacing={2} direction="row">
                    <FormControl  sx={{ minWidth: 120 }}>
                        <InputLabel id="demo-simple-select-label">Age</InputLabel>
                        <Select
                            labelId="demo-simple-select-label"
                            id="demo-simple-select"
                            value={''}
                            label="Age"
                        >
                            <MenuItem value={10}>Ten</MenuItem>
                            <MenuItem value={20}>Twenty</MenuItem>
                            <MenuItem value={30}>Thirty</MenuItem>
                        </Select>
                    </FormControl>
                    <TextField id="outlined-basic" label="Enter Duration" variant="outlined" />

                    <Button variant="contained"sx={{width:150}}>Submit</Button>
                </Stack>

            </Box>
            <div style={{ height: 400, width: '100%' }}>
                <DataGrid
                    rows={rows}
                    columns={columns}
                    initialState={{
                        pagination: {
                            paginationModel: { page: 0, pageSize: 5 },
                        },
                    }}
                    pageSizeOptions={[5, 10]}
                    checkboxSelection
                />
            </div>
        </div>
    )
}

export default Dietaryintake