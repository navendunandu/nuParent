import React, { useEffect, useState } from 'react'
import { DataGrid } from '@mui/x-data-grid';
import { Box, Button, FormControl, InputLabel, MenuItem, Select, Stack, TextField, Typography, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, } from '@mui/material';
import DeleteIcon from '@mui/icons-material/Delete';
import { db } from '../../config/firebase';
import { addDoc, collection, getDocs, deleteDoc, doc } from 'firebase/firestore';

const Dietaryintake = () => {

    const [open, setOpen] = useState(false);
    const [dietaryintakeData, setDietaryintakeData] = useState([]);
    const [dietaryintake, setDietaryintake] = useState('');
    const [selectedRow, setSelectedRow] = useState(null);
    const [ageData, setAgeData] = useState([]);
    const [age, setAge] = useState('');


    const handleClickOpen = (params) => {
        setSelectedRow(params);
        setOpen(true);
    };

    const handleClose = () => {
        setOpen(false);
    };



    const addDietaryintake = async () => {
        try {
            await addDoc(collection(db, "dietaryintake"), { dietaryintake, age })
            loadDietaryintake();
            setDietaryintake('')
            setAge('')

        } catch (error) {
            console.error('Error adding document: ', error);
        }
    };

    const loadDietaryintake = async () => {
        try {
            const querySnapshot = await getDocs(collection(db, "dietaryintake"));
            const dietaryintake = querySnapshot.docs.map((doc, index) => ({ id: doc.id, index: index + 1, ...doc.data() }));
            setDietaryintakeData(dietaryintake);
        } catch (error) {
            console.error('Error getting documents: ', error);
        }


    };

    const deleteDietaryintake = async () => {
        try {
            if (selectedRow) {
                await deleteDoc(doc(db, "dietaryintake", selectedRow.id));
                setOpen(false);
                setSelectedRow(null)
                loadDietaryintake();
            }
        } catch (error) {
            console.error('Error removing document: ', error);
        }
    };

    const loadAgeGroups = async () => {
        try {
            const querySnapshot = await getDocs(collection(db, "ageGroups"));
            const ageGroups = querySnapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
            setAgeData(ageGroups);
        } catch (error) {
            console.error('Error getting documents: ', error);
        }


    };



    useEffect(() => {
        loadDietaryintake();
        loadAgeGroups();
    }, []);



    const columns = [
        { field: 'index', headerName: 'ID', flex: 1 },

        {
            field: 'dietaryintake',
            headerName: 'Dietary Intake',
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


    return (
        <>
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
                        <FormControl sx={{ minWidth: 120 }}>
                            <InputLabel id="demo-simple-select-label">Age</InputLabel>
                            <Select
                                labelId="demo-simple-select-label"
                                id="demo-simple-select"
                                value={age}
                                label="Age"
                                onChange={(event) => setAge(event.target.value)}
                            >
                                {
                                    ageData.map((doc, key) => (
                                        <MenuItem key={key} value={doc.id}>{doc.age}</MenuItem>

                                    ))
                                }

                            </Select>
                        </FormControl>
                        <TextField id="outlined-basic" value={dietaryintake} label="Dietary Intake Details" onChange={(event) => setDietaryintake(event.target.value)} variant="outlined" />

                        <Button variant="contained" sx={{ width: 150 }} onClick={addDietaryintake}>Submit</Button>
                    </Stack>

                </Box>
                <div style={{ height: 400, width: '100%' }}>
                    <DataGrid
                        rows={dietaryintakeData}
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
                    <Button onClick={deleteDietaryintake} autoFocus>
                        Agree
                    </Button>
                </DialogActions>
            </Dialog>
        </>
    )
}

export default Dietaryintake