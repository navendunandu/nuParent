import React, { useEffect, useState } from 'react';
import { DataGrid } from '@mui/x-data-grid';
import { Box, Button, Container, Stack, TextField, Typography, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle } from '@mui/material';
import DeleteIcon from '@mui/icons-material/Delete';
import { db } from '../../config/firebase';
import { addDoc, collection, getDocs, deleteDoc, doc } from 'firebase/firestore';

const AgeGroup = () => {
    const [open, setOpen] = useState(false);
    const [ageData, setAgeData] = useState([]);
    const [age, setAge] = useState('');
    const [selectedRow, setSelectedRow] = useState(null);
    const [error, setError] = useState('');

    const handleClickOpen = (params) => {
        setSelectedRow(params);
        setOpen(true);
    };

    const handleClose = () => {
        setOpen(false);
    };

    const addAge = async (e) => {
        e.preventDefault(); // prevent form submission
        if (!age) {
            setError('Age is required');
            return;
        }

        try {
            await addDoc(collection(db, "ageGroups"), { age });
            loadAgeGroups();
            setAge('');
            setError('');
        } catch (error) {
            console.error('Error adding document: ', error);
        }
    };

    const loadAgeGroups = async () => {
        try {
            const querySnapshot = await getDocs(collection(db, "ageGroups"));
            const ageGroups = querySnapshot.docs.map((doc, index) => ({ id: doc.id, index: index + 1, ...doc.data() }));
            setAgeData(ageGroups);
        } catch (error) {
            console.error('Error getting documents: ', error);
        }
    };

    const deleteAge = async () => {
        try {
            if (selectedRow) {
                await deleteDoc(doc(db, "ageGroups", selectedRow.id));
                setOpen(false);
                setSelectedRow(null);
                loadAgeGroups();
            }
        } catch (error) {
            console.error('Error removing document: ', error);
        }
    };

    useEffect(() => {
        loadAgeGroups();
    }, []);

    const columns = [
        { field: 'index', headerName: 'ID', flex: 1 },
        { field: 'age', headerName: 'Age Group', flex: 3 },
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
                    Age
                </Typography>
                <form onSubmit={addAge}>
                    <Box
                        sx={{
                            '& > :not(style)': { m: 4, width: '100%' },
                        }}
                        noValidate
                        autoComplete="off"
                    >
                        <Container maxWidth="sm">
                            <Stack spacing={2} direction="row">
                                <TextField id="outlined-basic" label="Age" variant="outlined" value={age} onChange={(e) => { setAge(e.target.value); setError(''); }} />
                                <Button variant="contained" sx={{ width: 150 }} type='submit' >Submit</Button>
                            </Stack>
                            {error && <Typography color="error">{error}</Typography>}
                        </Container>
                    </Box>
                </form>
                <div style={{ height: 400, width: '100%' }}>
                    <DataGrid
                        rows={ageData}
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

export default AgeGroup;
