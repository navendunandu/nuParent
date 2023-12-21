import React, { useEffect, useState } from 'react';
import { DataGrid } from '@mui/x-data-grid';
import { Box, Button, Container, Stack, TextField, Typography, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle } from '@mui/material';
import DeleteIcon from '@mui/icons-material/Delete';
import { db } from '../../config/firebase';
import { addDoc, collection, getDocs, deleteDoc, doc } from 'firebase/firestore';


const DentalVisit = () => {
    const [open, setOpen] = useState(false);
    const [dentalvisitData, setDentalVisitData] = useState([]);
    const [dentalvisit, setDentalvisit] = useState('');
    const [selectedRow, setSelectedRow] = useState(null);
    const [error, setError] = useState('');

    const handleClickOpen = (params) => {
        setSelectedRow(params);
        setOpen(true);
    };

    const handleClose = () => {
        setOpen(false);
    };

    const addDentalvisit = async (e) => {
        e.preventDefault(); // prevent form submission
        if (!dentalvisit) {
            setError('DentalVisit Data is required');
            return;
        }

        try {
            await addDoc(collection(db, "dentalvisit"), { dentalvisit });
            loadDentalvisitData();
            setDentalvisit('');
            setError('');
        } catch (error) {
            console.error('Error adding document: ', error);
        }
    };

    const loadDentalvisitData = async () => {
        try {
            const querySnapshot = await getDocs(collection(db, "dentalvisit"));
            const dentalvisit = querySnapshot.docs.map((doc, index) => ({ id: doc.id, index: index + 1, ...doc.data() }));
            setDentalVisitData(dentalvisit);
        } catch (error) {
            console.error('Error getting documents: ', error);
        }
    };

    const deleteAge = async () => {
        try {
            if (selectedRow) {
                await deleteDoc(doc(db, "dentalvisit", selectedRow.id));
                setOpen(false);
                setSelectedRow(null);
                loadDentalvisitData();
            }
        } catch (error) {
            console.error('Error removing document: ', error);
        }
    };

    useEffect(() => {
        loadDentalvisitData();
    }, []);

    const columns = [
        { field: 'index', headerName: 'ID', flex: 1 },
        { field: 'dentalvisit', headerName: 'Dental Visit', flex: 3 },
        {
            field: "action",
            headerName: "Action",
            flex: 1,
            renderCell: (params) => {
                return (
                    <DeleteIcon
                        className="divListDelete"
                        onClick={() => handleClickOpen(params)}
                    />
                );
            },
        },
    ];

    return (
        <>
            <div>
                <Typography variant="h4" gutterBottom>
                Dental Visit
                </Typography>
                <form onSubmit={addDentalvisit}>
                    <Box
                        sx={{
                            '& > :not(style)': { m: 4, width: '100%' },
                        }}
                        noValidate
                        autoComplete="off"
                    >
                        <Container maxWidth="sm">
                            <Stack spacing={2} direction="row">
                                <TextField id="outlined-basic" label="Dental Visit" autoComplete='off' variant="outlined" value={dentalvisit} onChange={(e) => { setDentalvisit(e.target.value); setError(''); }} />
                                <Button variant="contained" sx={{ width: 150 }} type='submit' >Submit</Button>
                            </Stack>
                            {error && <Typography color="error">{error}</Typography>}
                        </Container>
                    </Box>
                </form>
                <div style={{ height: 400, width: '100%' }}>
                    <DataGrid
                        rows={dentalvisitData}
                        columns={columns}
                        initialState={{
                            pagination: {
                                paginationModel: { page: 0, pageSize: 5 },
                            },
                        }}
                        pageSizeOptions={[5, 10]}
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
                        Are you sure to delete this user permanently
                    </DialogContentText>
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleClose}>Disagree</Button>
                    <Button onClick={deleteAge} autoFocus>
                        Agree
                    </Button>
                </DialogActions>
            </Dialog>
        </>
    );
};

export default DentalVisit;
