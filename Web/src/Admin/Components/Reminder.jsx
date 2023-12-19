import React, { useEffect, useState } from 'react'
import { DataGrid } from '@mui/x-data-grid';
import { Box, Button, FormControl, InputLabel, MenuItem, Select, Stack, TextField, Typography, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, } from '@mui/material';
import DeleteIcon from '@mui/icons-material/Delete';
import { db } from '../../config/firebase';
import { addDoc, collection, getDocs, deleteDoc, doc } from 'firebase/firestore';


const Reminder = () => {

    const [open, setOpen] = useState(false);
    const [reminderData, setReminderData] = useState([]);
    const [reminder, setReminder] = useState('');
    const [duration, setDuration] = useState('');
    const [selectedRow, setSelectedRow] = useState(null);
    const [ageData, setAgeData] = useState([]);
    const [age, setAge] = useState('');
    const [error, setError] = useState('');


    const handleClickOpen = (params) => {
        setSelectedRow(params);
        setOpen(true);
    };


    const handleClose = () => {
        setOpen(false);
    };



    const addReminder = async () => {
        if (!reminder || !age || !duration) {
            setError('Both reminder Details and Age  and duration are required');
            return;
        }
        try {
            await addDoc(collection(db, "reminder"), { reminder, duration, age })
            loadReminder();
            setAge('')
            setReminder('')
            setDuration('')
        } catch (error) {
            console.error('Error adding document: ', error);
        }
    };

    const loadReminder = async () => {
        try {
            const querySnapshot = await getDocs(collection(db, "reminder"));
            const reminderData = querySnapshot.docs.map((doc, index) => ({ id: doc.id, index: index + 1, ...doc.data() }));


            const ageGroupsQuerySnapshot = await getDocs(collection(db, "ageGroups"));
            const ageGroupsData = ageGroupsQuerySnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));

            const joinedData = reminderData
                .filter(reminderDataItem => ageGroupsData.some(ageGroup => ageGroup.id === reminderDataItem.age))
                .map(reminderDataItem => {
                    const matchingAgeGroup = ageGroupsData.find(ageGroup => ageGroup.id === reminderDataItem.age);
                    return { ...reminderDataItem, ageGroup: matchingAgeGroup.age };
                });

            setReminderData(joinedData);
        } catch (error) {
            console.error('Error getting documents: ', error);
        }


    };

    const deleteReminder = async () => {
        try {
            if (selectedRow) {
                await deleteDoc(doc(db, "reminder", selectedRow.id));
                setOpen(false);
                setSelectedRow(null)
                loadReminder();
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
        loadReminder();
        loadAgeGroups();
    }, []);



    const columns = [
        { field: 'index', headerName: 'ID', flex: 1 },

        {
            field: 'reminder',
            headerName: 'Reminder',
            flex: 3
        },

        {
            field: 'duration',
            headerName: 'Duration',
            flex: 3
        },

        {
            field: 'ageGroup',
            headerName: 'Age Group',
            flex: 3
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
                    Reminder
                </Typography>
                <Box
                    component="form"
                    sx={{
                        '& > :not(style)': { m: 4, width: '100%' },
                    }}
                    noValidate
                    autoComplete="off"
                >

                    <Stack spacing={2} direction="row" sx={{p:2}}>
                        <FormControl sx={{ minWidth: 120 }}>
                            <InputLabel id="demo-simple-select-label">Age</InputLabel>
                            <Select
                                labelId="demo-simple-select-label"
                                id="demo-simple-select"
                                value={age}
                                label="Age"
                                onChange={(event) => { setAge(event.target.value); setError(''); }}
                            >
                                {
                                    ageData.map((doc, key) => (
                                        <MenuItem key={key} value={doc.id}>{doc.age}</MenuItem>

                                    ))
                                }
                            </Select>
                        </FormControl>
                        <TextField id="outlined-basic" autoComplete='off' value={duration} label="Enter Duration" variant="outlined" onChange={(event) => { setDuration(event.target.value); setError(''); }} />
                        <TextField id="outlined-basic" autoComplete='off' value={reminder} label="Enter Type Name" variant="outlined" onChange={(event) => { setReminder(event.target.value); setError(''); }} />

                        <Button variant="contained" sx={{ width: 150 }} onClick={addReminder}>Submit</Button>
                    </Stack>
                    {error && <Typography color="error">{error}</Typography>}

                </Box>
                <div style={{ height: 400, width: '100%' }}>
                    <DataGrid
                        rows={reminderData}
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
                        Are you sure to delete this user permanenently
                    </DialogContentText>
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleClose}>Disagree</Button>
                    <Button onClick={deleteReminder} autoFocus>
                        Agree
                    </Button>
                </DialogActions>
            </Dialog>
        </>
    )
}

export default Reminder