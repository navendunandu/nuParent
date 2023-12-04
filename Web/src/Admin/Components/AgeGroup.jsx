import React, { useState } from 'react'
import { DataGrid } from '@mui/x-data-grid';
import { Box, Button, Container, Stack, TextField, Typography , Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle,} from '@mui/material';
import DeleteIcon from '@mui/icons-material/Delete';


const AgeGroup = () => {

    const [open, setOpen] = useState(false);

    const handleClickOpen = () => {
        setOpen(true);
    };

    const handleClose = () => {
        setOpen(false);
    };



    
const columns = [
    { field: 'SL.NO', headerName: 'SL.NO',flex: 1},
    
    {
        field: 'age',
        headerName: 'Age Group',
        flex: 3,
    },
    {
        field: "action",
        headerName: "Action",
        flex: 1,
        renderCell: (params) => {
            return (
                <>
                    <DeleteIcon
                        className="divListDelete"
                        onClick={() => handleClickOpen(params)}
                    />
                </>
            );
        },
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
        <>
        <div>
            <Typography variant="h4" gutterBottom>
                Age
            </Typography>
            <Box
                component="form"
                sx={{
                    '& > :not(style)': { m: 4, width: '100%' },
                }}
                noValidate
                autoComplete="off"
            >
                <Container maxWidth="sm">
                    <Stack spacing={2} direction="row">
                        <TextField id="outlined-basic" label="Age" variant="outlined" />

                        <Button variant="contained" sx={{ width: 150 }}>Submit</Button>
                    </Stack>
                </Container>

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
         <Dialog
         open={open}
         onClose={handleClose}
         aria-labelledby="alert-dialog-title"
         aria-describedby="alert-dialog-description"
     >
         <DialogTitle id="alert-dialog-title">
             {"Confirm Delete"}
         </DialogTitle>
         <DialogContent>
             <DialogContentText id="alert-dialog-description">
                 Are you sure to delete this user permanenently
             </DialogContentText>
         </DialogContent>
         <DialogActions>
             <Button onClick={handleClose}>Disagree</Button>
             <Button onClick={handleClose} autoFocus>
                 Agree
             </Button>
         </DialogActions>
     </Dialog>
     </>
    )
}

export default AgeGroup